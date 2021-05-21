/*module tb_statemachine();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
logic slow_clock, resetb;
logic [3:0] dscore, pscore, pcard3;
logic load_pcard1,load_pcard2,load_pcard3,load_dcard1, load_dcard2, load_dcard3, 
        player_win_light,  dealer_win_light;
//logic [3:0] currentstate, nextstate;

statemachine dut(.*);

initial begin
    slow_clock = 0;
    forever #5 slow_clock = ~slow_clock;
end

initial begin
    resetb = 0;
    #10;
    assert(dut.currentstate === 4'b0000) //should go to RESET
    else $error("RESET state wrong");
    resetb = 1;
    #10;
    pscore = 4'd2; //case 1 where pscore is 2 -> player gets the third card
    pcard3 = 4'd7; // pcard3 = 7
    dscore = 4'd6;//dscore = 6
    //dealer gets the third card
    assert(dut.currentstate === 4'b0011) //should go to LPCARD1
    else $error("LPCARD1 state wrong");
    #10;
    assert(dut.currentstate === 4'b0001) //should go to LDCARD1
    else $error("LDCARD1 state wrong");
    #10;
    assert(dut.currentstate === 4'b0100) //should go to LPCARD2
    else $error("LPCARD2 state wrong");
    #10;
    assert(dut.currentstate === 4'b0010) //should go to LDCARD2
    else $error("LDCARD2 state wrong");
   
    #10;
    assert(dut.currentstate === 4'b0110) //should go to LPCARD3
    else $error("not in LPCARD3 state for case 1");
    pscore = 4'd3;//player has a lower score
    dscore = 4'd5; //dealer has a higher schore so dealer wins
    #10;
    assert(dut.currentstate === 4'b0111) //should go to LDCARD3
    else $error("not in LDCARD3 state for case 1");
    #10;
    assert(dut.currentstate === 4'b1000) //should go to WINNER
    else $error("not in WINNER state fr case 1");
    #10;
    assert(dealer_win_light === 1)
    else $error("winner ligth wrong for case 1");
    pscore = 4'd6; //case 2 where pscore is 6 so player does not get a third card
    dscore = 4'd3; //dscore is 3 so dealer gets a third card
    #50;
    assert(dut.currentstate === 4'b0111)
    else $error("not in LDCARD3 state for #2");
    pscore = 4'd8; //final score for player is 8 so player wins
    dscore = 4'd5; //final score for dealeris 5
    #10;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #2");
    #10;
    assert(player_win_light === 1)
    else $error("player light wrong for #2");
    pscore = 4'd5; //case 3 where pscore is 5 so player gets a card
    dscore = 4'd4; //dscore is 4 
    pcard3 = 4'd4; //and pcard3 is 4 so dealer gets a card
    #50;
    assert(dut.currentstate === 4'b0110)
    else $error("not in LPCARD3 state for #3");
    pscore = 4'd9; //total pscore is 9 so player wins 
    dscore = 4'd6; //total dscore is 6
    #10;
    assert(dut.currentstate === 4'b0111)
    else $error("not in LDCARD3 state for #3");
    #10;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #3");
    #10;
    assert(player_win_light === 1)
    else $error("player light wrong for #3");
    pscore = 4'd9; //case 4 where pscore is 9 so game is over
    dscore = 4'd5; //dscore has a lower value so player wins
    #60;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #4");
    #10;
    assert(player_win_light === 1)
    else $error("player light wrong for #4");
    pscore = 4'd8; //case 5 where pscore is 8 so game is over
    dscore = 4'd8; //and dcsore is also 8 so it is a tie
    #60;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #5");
    #10;
    assert(player_win_light === 1 && dealer_win_light === 1)
    else $error("player and dealer lights wrong for #5");
    pscore = 4'd3; //case 6 where pscore is 3 so player gets a card
    dscore = 4'd7; //dscore is 7 so dealer should not get a card
    #60;
    assert(dut.currentstate === 4'b0110)
    else $error("not in LPCARD3 state for #6");
    pscore = 4'd5; //total pscore is 5 and dscore should still be 7
    #10;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #6");
    #10;
    assert(dealer_win_light === 1)
    else $error("dealer light wrong for #6");
    #10;
    


    $stop;
end
endmodule
*/

module tb_statemachine();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
logic slow_clock, resetb;
logic [3:0] dscore, pscore, pcard3;
logic load_pcard1,load_pcard2,load_pcard3,load_dcard1, load_dcard2, load_dcard3, 
        player_win_light,  dealer_win_light;
//logic [3:0] currentstate, nextstate;

statemachine dut(.*);

initial begin
    slow_clock = 0;
    forever #5 slow_clock = ~slow_clock;
end

initial begin
    resetb = 0;
    #10;
    assert(dut.currentstate === 4'b0000) //should go to RESET
    else $error("RESET state wrong");
    resetb = 1;
    #10;
    pscore = 4'd2; //case 1 where pscore is 2 -> player gets the third card
    pcard3 = 4'd7; // pcard3 = 7
    dscore = 4'd6;//dscore = 6
    //dealer gets the third card
    assert(dut.currentstate === 4'b0011) //should go to LPCARD1
    else $error("LPCARD1 state wrong");
    #10;
    assert(dut.currentstate === 4'b0001) //should go to LDCARD1
    else $error("LDCARD1 state wrong");
    #10;
    assert(dut.currentstate === 4'b0100) //should go to LPCARD2
    else $error("LPCARD2 state wrong");
    #10;
    assert(dut.currentstate === 4'b0010) //should go to LDCARD2
    else $error("LDCARD2 state wrong");
   
    #10;
    assert(dut.currentstate === 4'b0110) //should go to LPCARD3
    else $error("not in LPCARD3 state for case 1");
    pscore = 4'd3;//player has a lower score
    dscore = 4'd5; //dealer has a higher schore so dealer wins
    #10;
    assert(dut.currentstate === 4'b0111) //should go to LDCARD3
    else $error("not in LDCARD3 state for case 1");
    #10;
    assert(dut.currentstate === 4'b1000) //should go to WINNER
    else $error("not in WINNER state fr case 1");
    #10;
    assert(dealer_win_light === 1)
    else $error("winner ligth wrong for case 1");
    pscore = 4'd6; //case 2 where pscore is 6 so player does not get a third card
    dscore = 4'd3; //dscore is 3 so dealer gets a third card
    #50;
    assert(dut.currentstate === 4'b0111)
    else $error("not in LDCARD3 state for #2");
    pscore = 4'd8; //final score for player is 8 so player wins
    dscore = 4'd5; //final score for dealeris 5
    #10;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #2");
    #10;
    assert(player_win_light === 1)
    else $error("player light wrong for #2");
    pscore = 4'd5; //case 3 where pscore is 5 so player gets a card
    dscore = 4'd4; //dscore is 4 
    pcard3 = 4'd4; //and pcard3 is 4 so dealer gets a card
    #50;
    assert(dut.currentstate === 4'b0110)
    else $error("not in LPCARD3 state for #3");
    pscore = 4'd9; //total pscore is 9 so player wins 
    dscore = 4'd6; //total dscore is 6
    #10;
    assert(dut.currentstate === 4'b0111)
    else $error("not in LDCARD3 state for #3");
    #10;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #3");
    #10;
    assert(player_win_light === 1)
    else $error("player light wrong for #3");
    pscore = 4'd9; //case 4 where pscore is 9 so game is over
    dscore = 4'd5; //dscore has a lower value so player wins
    #60;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #4");
    #10;
    assert(player_win_light === 1)
    else $error("player light wrong for #4");
    pscore = 4'd8; //case 5 where pscore is 8 so game is over
    dscore = 4'd8; //and dcsore is also 8 so it is a tie
    #50;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #5");
    #10;
    assert(player_win_light === 1 && dealer_win_light === 1)
    else $error("player and dealer lights wrong for #5");
    pscore = 4'd3; //case 6 where pscore is 3 so player gets a card
    dscore = 4'd7; //dscore is 7 so dealer should not get a card
    #50;
    assert(dut.currentstate === 4'b0110)
    else $error("not in LPCARD3 state for #6");
    pscore = 4'd5; //total pscore is 5 and dscore should still be 7
    #10;
    assert(dut.currentstate === 4'b1000)
    else $error("not in WINNER state for #6");
    #10;
    assert(dealer_win_light === 1)
    else $error("dealer light wrong for #6");
    #10;


    $stop;
end
endmodule
