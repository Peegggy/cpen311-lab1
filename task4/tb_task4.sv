module tb_task4();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 100,000 ticks (equivalent to "initial #100000 $finish();").
logic CLOCK_50;
logic [3:0] KEY;
logic [9:0] LEDR;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

task4 dut(.*);

initial begin
    CLOCK_50 = 0;
    forever #5 CLOCK_50 = ~CLOCK_50;
end

initial begin
    KEY[0] = 1;
    forever #10 KEY[0] = ~KEY[0];
end
initial begin
    KEY[3] <= 1'b0;
    #10;
    KEY[3] <= 1'b1; 
    
    pscore <= 4'd5;
    dscore <= 4'd4;
    assert (LEDR[8] === 1 && LEDR[9] === 0);
    else $error ("winner light wrong");
end
endmodule
