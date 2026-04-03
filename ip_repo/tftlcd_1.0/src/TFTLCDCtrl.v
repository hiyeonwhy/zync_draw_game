`timescale 1ns / 1ps

module TFTLCDctrl (
    input clk,
    input rstn,
    input [1:0] mode,  // 0: 도형, 1: SD 이미지
    input [15:0] r_data, // SD 이미지에서 읽은 RGB565 데이터

    output wire opclk,     // TFT-LCD Clock
    output wire Hsync,     // TFT-LCD HSYNC
    output wire Vsync,     // TFT-LCD VSYNC
    output wire [4:0] R,   // TFT-LCD Red signal 
    output wire [5:0] G,   // TFT-LCD Green signal
    output wire [4:0] B,   // TFT-LCD Blue signal
    output wire DE,        // Data Enable
    output wire TFTLCD_Tpower,  // Backlight On
    output wire TFTLCD_DE_out,  // Data Enable Out

    input Left,
    input Up,
    input Down,
    input Right,
    input [1:0] shape_mode,

    output wire done       //  Game Clear 신호 출력
);

    wire [9:0] HsyncCount;
    wire [8:0] VsyncCount;
    wire hDE, vDE;
    assign DE = hDE & vDE;
    assign TFTLCD_DE_out = 1'b1;
    assign TFTLCD_Tpower = 1'b1;

    wire [4:0] shape_R;
    wire [5:0] shape_G;
    wire [4:0] shape_B;

    wire [4:0] sd_R = r_data[4:0];
    wire [5:0] sd_G = r_data[10:5];
    wire [4:0] sd_B = r_data[15:11];

    g2m g2m_u0(
        .rstn(rstn),
        .clk(clk),
        .opclk(opclk)
    );

    horizontal horizontal_u0(
        .rstn(rstn),
        .clk(opclk),
        .HsyncCount(HsyncCount),
        .Hsync(Hsync),
        .hDE(hDE)
    );

    vertical vertical_u0(
        .rstn(rstn),
        .clk(opclk),
        .HsyncCount(HsyncCount),
        .VsyncCount(VsyncCount),
        .Vsync(Vsync),
        .vDE(vDE)
    );

    rgb rgb_u0(
        .rstn(rstn),
        .clk(opclk),
        .DE(DE),
        .HsyncCount(HsyncCount),
        .VsyncCount(VsyncCount),
        .Move_Left(Left),
        .Move_Up(Up),
        .Move_Down(Down),
        .Move_Right(Right),
        .shape_R(shape_R),
        .shape_G(shape_G),
        .shape_B(shape_B),
        .shape_mode(shape_mode),
        .done(done)  // Game Clear 연결
    );

    // mode에 따라 RGB 선택
    assign R = (mode == 0) ? shape_R : sd_R;
    assign G = (mode == 0) ? shape_G : sd_G;
    assign B = (mode == 0) ? shape_B : sd_B;

endmodule
