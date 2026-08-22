module rptr_empty #(
    parameter ADDR_WIDTH=4
)(
    input logic rd_clk,
    input logic rd_rst_n,
    input logic rd_en,
    input logic [ADDR_WIDTH:0] sync_wptr,
    output logic [ADDR_WIDTH-1:0] rd_addr,
    output logic [ADDR_WIDTH:0] rd_ptr,
    output logic empty

);
logic [ADDR_WIDTH:0] bin_ptr;
logic [ADDR_WIDTH:0] gray_ptr;
assign gray_ptr=(bin_ptr >> 1) ^ bin_ptr;
assign rd_ptr = gray_ptr;
assign rd_addr = bin_ptr[ADDR_WIDTH-1:0];
always_ff @(posedge rd_clk or negedge rd_rst_n) begin
if (!rd_rst_n) begin
bin_ptr <=0;
end
else if (rd_en && !empty) begin
bin_ptr <= bin_ptr+1;
end
end
assign empty = (rd_ptr == sync_wptr);
endmodule