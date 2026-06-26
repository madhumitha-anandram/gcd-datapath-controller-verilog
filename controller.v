module controller(clk,rst,go,a_gt_b,a_eq_b,a_lt_b,a_ld,b_ld,a_sel,b_sel,output_en,done);

input clk,rst,go,a_gt_b,a_eq_b,a_lt_b;
output reg a_ld,b_ld,a_sel,b_sel,output_en,done;

reg [2:0] cstate,nstate;

parameter s0 = 3'b000; 
parameter s1 = 3'b001; 
parameter s2 = 3'b010; 
parameter s3 = 3'b011; 
parameter s4 = 3'b100; 
parameter s5 = 3'b101; 
parameter s6 = 3'b110; 
parameter s7 = 3'b111; 

always@(posedge clk) begin
if(rst == 1)
 cstate<=s0;
else
cstate<=nstate;
end

always@(go or a_gt_b or a_eq_b or a_lt_b or cstate) begin

case (cstate)
s0: begin
    if(go==0) nstate<=s0;
    else nstate<=s1;
    end
s1: nstate<=s2;
s2: nstate<=s3;
s3: begin
    if (a_gt_b) nstate<=s4;
    else if(a_eq_b) nstate<=s7;
    else nstate<=s5;
    end
s4:nstate<=s6;
s5:nstate<=s6;
s6:nstate<=s3;
s7:nstate<=s0;
default: nstate<=s0;
endcase
end

always@(cstate) begin
case(cstate)
s0: begin
a_sel<=0;
b_sel<=0;
a_ld<=0;
b_ld<=0;
done<=1;
output_en<=0;
end
s1:begin
a_sel<=1;
b_sel<=1;
a_ld<=1;
b_ld<=1;
done<=0;
output_en<=0;
end
s2:begin
a_sel<=0;
b_sel<=0;
a_ld<=0;
b_ld<=0;
done<=0;
output_en<=0;
end
s3:begin
a_sel<=0;
b_sel<=0;
a_ld<=0;
b_ld<=0;
done<=0;
output_en<=0;
end
s4:begin
a_sel<=0;
b_sel<=0;
a_ld<=1;
b_ld<=0;
done<=0;
output_en<=0;
end
s5:begin
a_sel<=0;
b_sel<=0;
a_ld<=0;
b_ld<=1;
done<=0;
output_en<=0;
end
s6:begin
a_sel<=0;
b_sel<=0;
a_ld<=0;
b_ld<=0;
done<=0;
output_en<=0;
end
s7:begin
a_sel<=0;
b_sel<=0;
a_ld<=0;
b_ld<=0;
done<=1;
output_en<=1;
end
default:begin
a_sel<=0;
b_sel<=0;
a_ld<=0;
b_ld<=0;
done<=0;
output_en<=0;
end
endcase
end
endmodule
