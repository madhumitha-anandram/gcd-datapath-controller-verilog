module mux(out, sel, in0, in1);
    output reg [7:0] out;  
    input  [7:0] in0, in1;
    input sel;

    always@(sel or in0 or in1) begin
        out = (sel==0) ? in0 : in1;  
    end

endmodule

