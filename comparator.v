module comparator(a,b,a_gt_b,a_eq_b,a_lt_b);
input [7:0]a,b;
output reg a_gt_b,a_eq_b,a_lt_b;

always@(*) begin
if(a<b) begin
a_gt_b = 0;
a_eq_b = 0;
a_lt_b = 1;
end
else if(a==b) begin
a_gt_b = 0;
a_eq_b = 1;
a_lt_b = 0;
end
else begin
a_gt_b = 1;
a_eq_b = 0;
a_lt_b = 0;
end
end
endmodule
