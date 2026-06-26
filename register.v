module register(clk,rst,in,lden,out);

input clk,rst;
input [7:0]in;
input lden;
output reg [7:0] out;
always@(posedge clk) begin
if(rst)
out<=0;
else if (lden==1)
out<=in;
end
endmodule

