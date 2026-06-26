module datapath(clk,rst,in1,in2,a_sel,b_sel,a_ld,b_ld,a_gt_b,a_eq_b,a_lt_b,output_en,out);

input clk,rst;
input [7:0] in1,in2;
input a_sel,b_sel,a_ld,b_ld,output_en;
output a_gt_b,a_eq_b,a_lt_b;
output [7:0] out;

wire [7:0] tain,tbin,taout,tbout,t1,t2;

subtractor s1(taout,tbout,t1);
subtractor s2(tbout,taout,t2);

mux m1(tain,a_sel,t1,in1);
mux m2(tbin,b_sel,t2,in2);

register r1(clk,rst,tain,a_ld,taout);
register r2(clk,rst,tbin,b_ld,tbout);
register rout(clk,rst,taout,output_en,out);

comparator c1(taout,tbout,a_gt_b,a_eq_b,a_lt_b);

endmodule
