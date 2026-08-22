module sync_w2r #(
    parameter ADDR_WIDTH=4
) (
    input logic rd_clk,
    input logic rd_rst_n,
    input logic [ADDR_WIDTH:0] wr_ptr,
    output logic [ADDR_WIDTH:0] sync_wptr

);
logic [ADDR_WIDTH:0] sync_stage1;
always_ff @ (posedge rd_clk or negedge rd_rst_n) begin
if (!rd_rst_n) begin
sync_stage1 <=0;
sync_wptr <=0;
end
else begin
sync_stage1 <= wr_ptr;
sync_wptr <= sync_stage1;
end
end
endmodule