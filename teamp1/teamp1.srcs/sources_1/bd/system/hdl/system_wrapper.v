//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Sat Jun 21 17:22:29 2025
//Host        : hiyeon running 64-bit major release  (build 9200)
//Command     : generate_target system_wrapper.bd
//Design      : system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_wrapper
   (B_0,
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    Down_0,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    G_0,
    Hsync_0,
    Left_0,
    R_0,
    Right_0,
    TFTLCD_DE_out_0,
    TFTLCD_Tpower_0,
    Up_0,
    Vsync_0,
    clk_0,
    done_0,
    lcd_data_0,
    lcd_en_0,
    lcd_rs_0,
    lcd_rw_0,
    opclk_0,
    resetn_0,
    seg_data_0,
    seg_en_0);
  output [4:0]B_0;
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  input Down_0;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output [5:0]G_0;
  output Hsync_0;
  input Left_0;
  output [4:0]R_0;
  input Right_0;
  output TFTLCD_DE_out_0;
  output TFTLCD_Tpower_0;
  input Up_0;
  output Vsync_0;
  input clk_0;
  output done_0;
  output [7:0]lcd_data_0;
  output lcd_en_0;
  output lcd_rs_0;
  output lcd_rw_0;
  output opclk_0;
  input resetn_0;
  output [7:0]seg_data_0;
  output [7:0]seg_en_0;

  wire [4:0]B_0;
  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire Down_0;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [5:0]G_0;
  wire Hsync_0;
  wire Left_0;
  wire [4:0]R_0;
  wire Right_0;
  wire TFTLCD_DE_out_0;
  wire TFTLCD_Tpower_0;
  wire Up_0;
  wire Vsync_0;
  wire clk_0;
  wire done_0;
  wire [7:0]lcd_data_0;
  wire lcd_en_0;
  wire lcd_rs_0;
  wire lcd_rw_0;
  wire opclk_0;
  wire resetn_0;
  wire [7:0]seg_data_0;
  wire [7:0]seg_en_0;

  system system_i
       (.B_0(B_0),
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .Down_0(Down_0),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .G_0(G_0),
        .Hsync_0(Hsync_0),
        .Left_0(Left_0),
        .R_0(R_0),
        .Right_0(Right_0),
        .TFTLCD_DE_out_0(TFTLCD_DE_out_0),
        .TFTLCD_Tpower_0(TFTLCD_Tpower_0),
        .Up_0(Up_0),
        .Vsync_0(Vsync_0),
        .clk_0(clk_0),
        .done_0(done_0),
        .lcd_data_0(lcd_data_0),
        .lcd_en_0(lcd_en_0),
        .lcd_rs_0(lcd_rs_0),
        .lcd_rw_0(lcd_rw_0),
        .opclk_0(opclk_0),
        .resetn_0(resetn_0),
        .seg_data_0(seg_data_0),
        .seg_en_0(seg_en_0));
endmodule
