module tb_task5();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 100,000 ticks (equivalent to "initial #100000 $finish();").
logic CLOCK_50;
logic [3:0] KEY;
logic [9:0] LEDR;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
logic [3:0] pscore, dscore;

task5 dut(.*);

initial begin
    CLOCK_50 = 1;
    forever #5 CLOCK_50 = ~CLOCK_50;
end

initial begin
    KEY[0] = 1;
    forever #10 KEY[0] = ~KEY[0];
end
initial begin
    KEY[3] = 1'b0;
    #10;
    KEY[3] = 1'b1;
    #260;
    //from looking at the waveform, the dealt cards are below and both dealers and players
    //should not get a third card because the dealer got 8 which is game over
    //and dealer wins
    assert(HEX0 === 7'b0000010) //should display first card: 6
    else $error("HEX0 is wrong");
    assert(HEX1 === 7'b1000000) //should display second card: 0
    else $error("HEX1 is wrong");
    assert(HEX2 === 7'b1) //should display thrid card: blank
    else $error("HEX2 is wrong");
    assert(HEX3 === 7'b0) //should display first card: 8
    else $error("HEX3 is wrong");
    assert(HEX4 === 7'b0011000) //should display second card: k
    else $error("HEX4 is wrong");
    assert(HEX5 === 7'b1) //should display thrid card: blank
    else $error("HEX5 is wrong");  
    assert(LEDR[9] === 1) //dealer wins
    else $error("winning light wrong"); 
    assert(LEDR[3:0] === 4'd6) //check if the led is displaying the right total
    else $error("pscore is wrong");
    assert(LEDR[7:4] === 4'd8)
    else $error("dscore is wrong");
    $stop;
end
endmodule

