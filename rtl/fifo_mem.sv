module fifo_mem #(
    parameter data_width=8,
    parameter fifo_depth=16
)(
    input logic [data_width-1:0] data_in,
    input logic wr_clk,
    input logic rd_clk,
    input logic wr_en,
    input logic [$clog2(fifo_depth)-1:0] wr_addr,
    input logic [$clog2(fifo_depth)-1:0] rd_addr,
    output logic [data_width-1:0] data_out
);
logic [data_width-1:0] memory [fifo_depth];
always_ff @(posedge wr_clk) begin
if(wr_en) begin
memory[wr_addr]<=data_in;
end
end
assign data_out=memory[rd_addr];
endmodule