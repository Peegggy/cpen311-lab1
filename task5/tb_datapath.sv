module tb_datapath();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
logic slow_clock, fast_clock, resetb, load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3;
logic [3:0] pcard3_out, pscore_out, dscore_out;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

datapath dut(.*);

initial begin
    fast_clock = 0; //new card being dealt every 10 ps
    forever #5 fast_clock = ~fast_clock;
end

initial begin
    slow_clock = 1; //slow clock is twice as slow so new_card is every second card
    forever #10 slow_clock = ~slow_clock;
end

initial begin
    resetb = 0;
    #10;
    assert(pscore_out === 4'd0 && dscore_out === 4'd0)//check if total is 0
    else $error("did not successfully reset");
    resetb = 1;
    load_pcard1 = 1; //load player card 1: card should be 1
    #10;
    load_pcard1 = 0;
    #10;
    load_pcard2 = 1; //load player card 2: card should be 3
    #10;
    load_pcard2 = 0;
    #10;
    load_pcard3 = 1; //load player card 3: card should be 5
    #10;
    $display("card 1 is %d", tb_datapath.dut.card1); //check the card value
    $display("card 2 is %d", tb_datapath.dut.card2);
    $display("card 3 is %d", tb_datapath.dut.card3);
    assert(pcard3_out === 4'd5) //check is the player's third card is being driven out correctly
    else $error("pcard3 is wrong");
    assert(pscore_out === 4'd9) //pscore = (1+3+5) % 10 = 9
    else $error("pscore out is wrong");
    assert(HEX0 === 7'b0001000) //should display first card: ace
    else $error("HEX0 is wrong");
    assert(HEX1 === 7'b0110000) //should display second card: 3
    else $error("HEX1 is wrong");
    assert(HEX2 === 7'b0010010) //should display thrid card: 5
    else $error("HEX2 is wrong");
    load_pcard3 = 0;
    #10;
    load_dcard1 = 1; //load dealer card 1: card should be 7
    #10;
    load_dcard1 = 0;
    #10;
    load_dcard2 = 1; //load dealer card 2: card should be 9
    #10;
    load_dcard2 = 0; 
    #10;
    load_dcard3 = 1; //load dealer card 3: card should be 11
    #10;
    $display("card 4 is %d", tb_datapath.dut.card4); //check the card value
    $display("card 5 is %d", tb_datapath.dut.card5);
    $display("card 6 is %d", tb_datapath.dut.card6);
    assert(dscore_out === 4'd6) //dscore = (7+9+0)%10=6
    else $error("dscore out is wrong");
    assert(HEX3 === 7'b1111000) //should display first dealer card: 7
    else $error("HEX3 is wrong");
    assert(HEX4 === 7'b0010000) //should display second dealer card: 9
    else $error("HEX4 is wrong");
    assert(HEX5 === 7'b1100001) //should display third dealer card: j
    else $error("HEX5 is wrong");
    load_dcard3 = 0;
    $stop;

end
endmodule
