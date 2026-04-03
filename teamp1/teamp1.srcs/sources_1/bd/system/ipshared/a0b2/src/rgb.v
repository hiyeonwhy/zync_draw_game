`timescale 1ns / 1ps

module rgb(
    input clk,
    input rstn,
    input [9:0] HsyncCount,
    input [9:0] VsyncCount,
    input DE,
    input Move_Left,
    input Move_Up,
    input Move_Down,
    input Move_Right,
    input [1:0] shape_mode,
    output reg [4:0] shape_R,
    output reg [5:0] shape_G,
    output reg [4:0] shape_B,
    output reg done
);

    parameter WIDTH = 80;
    parameter HEIGHT = 60;

    reg paint [0:WIDTH*HEIGHT-1];
    reg [6:0] cursor_x;
    reg [5:0] cursor_y;
    reg prev_left, prev_up, prev_down, prev_right;

    parameter BORDER_LEFT   = 32;
    parameter BORDER_RIGHT  = 39;
    parameter BORDER_TOP    = 24;
    parameter BORDER_BOTTOM = 30;

    wire [6:0] cell_x = HsyncCount[9:3];
    wire [5:0] cell_y = VsyncCount[9:3];

    function is_inside_rect;
        input [6:0] x;
        input [5:0] y;
        begin
            is_inside_rect = (x > BORDER_LEFT && x < BORDER_RIGHT &&
                              y > BORDER_TOP && y < BORDER_BOTTOM);
        end
    endfunction

    function is_inside_circle;
        input [6:0] x;
        input [5:0] y;
        integer cx, cy, dx, dy, r2;
        begin
            cx = (BORDER_LEFT + BORDER_RIGHT) / 2;
            cy = (BORDER_TOP + BORDER_BOTTOM) / 2;
            dx = x - cx;
            dy = y - cy;
            r2 = ((BORDER_RIGHT - BORDER_LEFT) / 2) ** 2;
            is_inside_circle = (dx*dx + dy*dy <= r2);
        end
    endfunction

    function is_inside_grapes;
        input [6:0] x;
        input [5:0] y;
        integer cx, cy, dx, dy, r, r2;
        begin
            r = 3;
            r2 = r * r;
            is_inside_grapes = 0;

            cx = 20; cy = 15; dx = x - cx; dy = y - cy;
            if (dx*dx + dy*dy <= r2) is_inside_grapes = 1;

            cx = 26; cy = 17; dx = x - cx; dy = y - cy;
            if (dx*dx + dy*dy <= r2) is_inside_grapes = 1;

            cx = 32; cy = 15; dx = x - cx; dy = y - cy;
            if (dx*dx + dy*dy <= r2) is_inside_grapes = 1;

            cx = 22; cy = 22; dx = x - cx; dy = y - cy;
            if (dx*dx + dy*dy <= r2) is_inside_grapes = 1;

            cx = 30; cy = 22; dx = x - cx; dy = y - cy;
            if (dx*dx + dy*dy <= r2) is_inside_grapes = 1;

            cx = 26; cy = 27; dx = x - cx; dy = y - cy;
            if (dx*dx + dy*dy <= r2) is_inside_grapes = 1;
        end
    endfunction

    function is_inside_shape;
        input [6:0] x;
        input [5:0] y;
        begin
            case (shape_mode)
                2'b00: is_inside_shape = is_inside_rect(x, y);
                2'b01: is_inside_shape = is_inside_circle(x, y);
                2'b10: is_inside_shape = is_inside_grapes(x, y);
                2'b11: is_inside_shape = 1;  // 자유 그리기 모드
                default: is_inside_shape = 0;
            endcase
        end
    endfunction

    function is_rect_border;
        input [6:0] x;
        input [5:0] y;
        begin
            is_rect_border =
                ((x >= BORDER_LEFT && x <= BORDER_RIGHT &&
                  (y == BORDER_TOP || y == BORDER_BOTTOM)) ||
                 (y >= BORDER_TOP && y <= BORDER_BOTTOM &&
                  (x == BORDER_LEFT || x == BORDER_RIGHT)));
        end
    endfunction

    function is_circle_border;
        input [6:0] x;
        input [5:0] y;
        integer cx, cy, dx, dy, r, r2, dist;
        begin
            cx = (BORDER_LEFT + BORDER_RIGHT) / 2;
            cy = (BORDER_TOP + BORDER_BOTTOM) / 2;
            dx = x - cx;
            dy = y - cy;
            r = (BORDER_RIGHT - BORDER_LEFT) / 2;
            dist = dx*dx + dy*dy;
            r2 = r * r;
            is_circle_border = (dist >= r2 - 2) && (dist <= r2 + 2);
        end
    endfunction

    function is_grape_border;
        input [6:0] x;
        input [5:0] y;
        integer cx, cy, dx, dy, r, r2, dist;
        begin
            r = 3;
            r2 = r * r;
            is_grape_border = 0;

            cx = 20; cy = 15; dx = x - cx; dy = y - cy; dist = dx*dx + dy*dy;
            if (dist >= r2 - 1 && dist <= r2 + 1) is_grape_border = 1;

            cx = 26; cy = 17; dx = x - cx; dy = y - cy; dist = dx*dx + dy*dy;
            if (dist >= r2 - 1 && dist <= r2 + 1) is_grape_border = 1;

            cx = 32; cy = 15; dx = x - cx; dy = y - cy; dist = dx*dx + dy*dy;
            if (dist >= r2 - 1 && dist <= r2 + 1) is_grape_border = 1;

            cx = 22; cy = 22; dx = x - cx; dy = y - cy; dist = dx*dx + dy*dy;
            if (dist >= r2 - 1 && dist <= r2 + 1) is_grape_border = 1;

            cx = 30; cy = 22; dx = x - cx; dy = y - cy; dist = dx*dx + dy*dy;
            if (dist >= r2 - 1 && dist <= r2 + 1) is_grape_border = 1;

            cx = 26; cy = 27; dx = x - cx; dy = y - cy; dist = dx*dx + dy*dy;
            if (dist >= r2 - 1 && dist <= r2 + 1) is_grape_border = 1;
        end
    endfunction

    function is_shape_border;
        input [6:0] x;
        input [5:0] y;
        begin
            case (shape_mode)
                2'b00: is_shape_border = is_rect_border(x, y);
                2'b01: is_shape_border = is_circle_border(x, y);
                2'b10: is_shape_border = is_grape_border(x, y);
                2'b11: is_shape_border = 0;  // 자유 그리기 모드는 테두리 없음
                default: is_shape_border = 0;
            endcase
        end
    endfunction

    always @(*) begin
        if (!rstn || !DE) begin
            shape_R = 0;
            shape_G = 0;
            shape_B = 0;
        end else if (is_shape_border(cell_x, cell_y)) begin
            shape_R = 0;
            shape_G = 6'b111111;
            shape_B = 0;
        end else if (cell_x == cursor_x && cell_y == cursor_y) begin
            shape_R = 5'b11111;
            shape_G = 6'b111111;
            shape_B = 5'b11111;
        end else if (paint[cell_y * WIDTH + cell_x]) begin
            shape_R = 5'b11111;
            shape_G = 0;
            shape_B = 5'b11111;  // 보라색
        end else begin
            shape_R = 0;
            shape_G = 0;
            shape_B = 0;
        end
    end

    integer i, j;

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < WIDTH * HEIGHT; i = i + 1)
                paint[i] <= 0;

            cursor_x <= WIDTH / 2;
            cursor_y <= HEIGHT / 2;

            prev_left  <= 1;
            prev_right <= 1;
            prev_up    <= 1;
            prev_down  <= 1;

            done <= 0;
        end else begin
            if (!Move_Left && prev_left && cursor_x > 0)
                cursor_x <= cursor_x - 1;
            if (!Move_Right && prev_right && cursor_x < WIDTH - 1)
                cursor_x <= cursor_x + 1;
            if (!Move_Up && prev_up && cursor_y > 0)
                cursor_y <= cursor_y - 1;
            if (!Move_Down && prev_down && cursor_y < HEIGHT - 1)
                cursor_y <= cursor_y + 1;

            if (is_inside_shape(cursor_x, cursor_y) && !is_shape_border(cursor_x, cursor_y))
                paint[cursor_y * WIDTH + cursor_x] <= 1;

            prev_left  <= Move_Left;
            prev_right <= Move_Right;
            prev_up    <= Move_Up;
            prev_down  <= Move_Down;

            done <= 1;
            for (i = 0; i < HEIGHT; i = i + 1) begin
                for (j = 0; j < WIDTH; j = j + 1) begin
                    if (is_inside_shape(j, i) && !is_shape_border(j, i) && !paint[i * WIDTH + j])
                        done <= 0;
                end
            end
        end
    end

endmodule
