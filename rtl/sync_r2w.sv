module sync_r2w #(
    parameter ADDR_WIDTH=4
) (
    input logic wr_clk,
    input logic wr_rst_n,
    input logic [ADDR_WIDTH:0] rd_ptr,
    output logic [ADDR_WIDTH:0] sync_rptr

);
logic [ADDR_WIDTH:0] sync_stage1;
always_ff @ (posedge wr_clk or negedge wr_rst_n) begin
if (!wr_rst_n) begin
sync_stage1 <=0;
sync_rptr <=0;
end
else begin
sync_stage1 <= rd_ptr;
sync_rptr <= sync_stage1;
end
end
endmodule