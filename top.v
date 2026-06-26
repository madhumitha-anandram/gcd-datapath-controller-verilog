module top(clk,rst,go,in1,in2,out,done);

input clk,rst,go;
input [7:0] in1,in2;
output [7:0] out;
output done;

wire a_gt_b,a_eq_b,a_lt_b,a_ld,a_sel,b_ld,b_sel,output_en;

controller c1(clk,rst,go,a_gt_b,a_eq_b,a_lt_b,a_ld,b_ld,a_sel,b_sel,output_en,done);

datapath d1(clk,rst,in1,in2,a_sel,b_sel,a_ld,b_ld,a_gt_b,a_eq_b,a_lt_b,output_en,out);

endmodule
