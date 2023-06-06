
module register(
    input clk,
    input rst,
    input [7:0] din,
    input inc,
    input we, 
    output reg [7:0] dout
);

always @(posedge clk or we or !we) begin
    if (rst) 
        dout <= 8'b0;
    else if (we) 
        dout <= din;
    else if (inc) 
        dout <= dout + 1;
end
initial begin
    dout =0;
end

endmodule