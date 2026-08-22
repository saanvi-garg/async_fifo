module wptr_full #(
    parameter ADDR_WIDTH=4
)(
    input logic wr_clk,
    input logic wr_rst_n,
    input logic wr_en,
    input logic [ADDR_WIDTH:0] sync_rptr,
    output logic [ADDR_WIDTH-1:0] wr_addr,
    output logic [ADDR_WIDTH:0] wr_ptr,
    output logic full

);
logic [ADDR_WIDTH:0] bin_ptr;
logic [ADDR_WIDTH:0] gray_ptr;
assign gray_ptr=(bin_ptr >> 1) ^ bin_ptr;
assign wr_ptr = gray_ptr;
assign wr_addr = bin_ptr[ADDR_WIDTH-1:0];
always_ff @(posedge wr_clk or negedge wr_rst_n) begin
if (!wr_rst_n) begin
bin_ptr <=0;
end
else if (wr_en && !full) begin
bin_ptr <= bin_ptr+1;
end
end
assign full = (gray_ptr[ADDR_WIDTH] != sync_rptr[ADDR_WIDTH])
    && (gray_ptr[ADDR_WIDTH-1] != sync_rptr[ADDR_WIDTH-1])
    && (gray_ptr[ADDR_WIDTH-2:0] == sync_rptr[ADDR_WIDTH-2:0]);
endmodule