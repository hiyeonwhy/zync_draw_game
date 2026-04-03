`timescale 1 ns / 1 ps

module tftlcd_v1_0 #
(
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 19
)
(
    input wire clk,
    input wire Left,
    input wire Right,
    input wire Up,
    input wire Down,

    output wire opclk,
    output wire Vsync,
    output wire Hsync,
    output wire [4:0] R,
    output wire [5:0] G,
    output wire [4:0] B,
    output wire TFTLCD_DE_out,
    output wire TFTLCD_Tpower,
    output wire done,

    // AXI 인터페이스
    input wire  s00_axi_aclk,
    input wire  s00_axi_aresetn,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
    input wire [2 : 0] s00_axi_awprot,
    input wire  s00_axi_awvalid,
    output wire  s00_axi_awready,
    input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
    input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
    input wire  s00_axi_wvalid,
    output wire  s00_axi_wready,
    output wire [1 : 0] s00_axi_bresp,
    output wire  s00_axi_bvalid,
    input wire  s00_axi_bready,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
    input wire [2 : 0] s00_axi_arprot,
    input wire  s00_axi_arvalid,
    output wire  s00_axi_arready,
    output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
    output wire [1 : 0] s00_axi_rresp,
    output wire  s00_axi_rvalid,
    input wire  s00_axi_rready
);

    // 내부 연결
    wire [15:0] r_data;
    wire [1:0] mode;
    wire [1:0] shape_mode;


    // AXI 슬레이브 인스턴스: 제어 신호만 제공
    tftlcd_v1_0_S00_AXI #
    (
        .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
    ) tftlcd_v1_0_S00_AXI_inst (
        .clk(clk),
        .mode(mode),
        .r_data(r_data),
        .shape_mode(shape_mode),
        .S_AXI_ACLK(s00_axi_aclk),
        .S_AXI_ARESETN(s00_axi_aresetn),
        .S_AXI_AWADDR(s00_axi_awaddr),
        .S_AXI_AWPROT(s00_axi_awprot),
        .S_AXI_AWVALID(s00_axi_awvalid),
        .S_AXI_AWREADY(s00_axi_awready),
        .S_AXI_WDATA(s00_axi_wdata),
        .S_AXI_WSTRB(s00_axi_wstrb),
        .S_AXI_WVALID(s00_axi_wvalid),
        .S_AXI_WREADY(s00_axi_wready),
        .S_AXI_BRESP(s00_axi_bresp),
        .S_AXI_BVALID(s00_axi_bvalid),
        .S_AXI_BREADY(s00_axi_bready),
        .S_AXI_ARADDR(s00_axi_araddr),
        .S_AXI_ARPROT(s00_axi_arprot),
        .S_AXI_ARVALID(s00_axi_arvalid),
        .S_AXI_ARREADY(s00_axi_arready),
        .S_AXI_RDATA(s00_axi_rdata),
        .S_AXI_RRESP(s00_axi_rresp),
        .S_AXI_RVALID(s00_axi_rvalid),
        .S_AXI_RREADY(s00_axi_rready)
    );

    // 최종 출력은 여기서 담당
    TFTLCDctrl TFTLCDctrl_U0 (
        .clk(clk),
        .rstn(s00_axi_aresetn),
        .mode(mode),
        .r_data(r_data),
        .shape_mode(shape_mode),
        .Left(Left),
        .Right(Right),
        .Up(Up),
        .Down(Down),
        .opclk(opclk),
        .Vsync(Vsync),
        .Hsync(Hsync),
        .R(R),
        .G(G),
        .B(B),
        .DE(), // 사용 안하면 비워둠
        .TFTLCD_DE_out(TFTLCD_DE_out),
        .TFTLCD_Tpower(TFTLCD_Tpower),
        .done(done)
        
    );

endmodule
