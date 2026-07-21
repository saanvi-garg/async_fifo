`timescale 1ns/1ps
module sync_fifo_tb;
logic clk;
logic rst_n;
logic wr_en;
logic rd_en;
logic full;
logic empty;
logic [7:0] data_in;
logic [7:0] data_out;
initial begin
clk=0;
forever #5 clk=~clk;
end
sync_fifo dut(
    .clk(clk),
    .rst_n(rst_n),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .full(full),
    .empty(empty),
    .data_in(data_in),
    .data_out(data_out)

); 
initial begin
rst_n=0;wr_en=0;rd_en=0;data_in=0;
@(posedge clk); @(posedge clk);
rst_n=1;
repeat (16) begin
@(posedge clk);
wr_en=1;
data_in=data_in+1;
end
wr_en=0;
@(posedge clk);
wr_en=1;data_in=8'hFF;
@(posedge clk);
wr_en=0;
repeat (16) begin
@(posedge clk);
rd_en=1;
end
rd_en=0;
@(posedge clk);
    wr_en = 1; rd_en = 1; data_in = 8'hAA;
    @(posedge clk);
    wr_en = 0; rd_en = 0;
@(posedge clk);
    wr_en = 1; data_in = 8'h55;
    @(posedge clk);
    rst_n = 0;
    @(posedge clk);
    rst_n = 1;
    wr_en = 0;
#20 $finish;        
end   
initial begin
    $dumpfile("sim/sync_fifo.vcd");
    $dumpvars(0, sync_fifo_tb);
end


endmodule