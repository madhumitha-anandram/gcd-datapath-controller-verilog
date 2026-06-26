module top_tb();
    reg clk=0, rst=1, go;
    reg [7:0] in1, in2;
    wire [7:0] out;
    wire done;

    top dut(clk, rst, go, in1, in2, out, done);

    always begin
        clk = 0; #25;
        clk = 1; #25;
    end

    initial begin
        rst = 1;
        go  = 0;
        #100;
        rst = 0;

        // First input
        in1 = 10;
        in2 = 5;
        #100;
        go = 1;
        wait(done==0);  
        go = 0;
        wait(done==1);  

        // Second input
        in1 = 243;
        in2 = 144;
        #100;
        go = 1;
        wait(done==0);  
        go = 0;
        wait(done==1); 
       
        //third input
 
        in1 = 112;
        in2 = 46;
        #100;
        go = 1;
        wait(done==0);  
        go = 0;
        wait(done==1); 
        

        #10000;
        $finish;
    end
endmodule
