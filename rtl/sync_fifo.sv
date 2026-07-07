module sync_fifo #(
    parameter data_width=8,
    parameter fifo_depth=16
     )
    //port list 
    (input logic [data_width-1:0] data_in,
    input logic clk,
    input logic rst_n,
    input logic wr_en,
    input logic rd_en,
    output logic [data_width-1:0] data_out,
    output logic full,
    output logic empty
);
localparam width= $clog2(fifo_depth);
logic [width:0] wr_ptr;
logic [width:0] rd_ptr;
logic [data_width-1:0] memory [fifo_depth];
always_ff @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
wr_ptr<=0;
rd_ptr<=0;
data_out<=0;
end
else begin
if (wr_en==1 && full==0) begin
memory[wr_ptr[width-1:0]]<= data_in;
wr_ptr <= wr_ptr + 1;
end
if (rd_en==1 && empty==0)begin
data_out<=memory[rd_ptr[width-1:0]];
rd_ptr <= rd_ptr + 1;
end
end
end
assign empty = (wr_ptr == rd_ptr);
assign full  = (wr_ptr[width] != rd_ptr[width]) && (wr_ptr[width-1:0] == rd_ptr[width-1:0]);

endmodule