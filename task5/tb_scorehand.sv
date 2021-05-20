module tb_scorehand();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

logic [3:0] card1, card2, card3, total;
scorehand dut(.*);

initial begin
    card1 <= 4'd10; //checking the case for when the cards are greater than 9 which 
    card2 <= 4'd10; //should be assigned 0
    card3 <= 4'd10;
    #5;
    assert(total === 4'd0) //total should be 0;
    else $error("total is wrong for out of range case");
    #5;
    card1 <= 4'd9;
    card2 <= 4'd8;
    card3 <= 4'd12; //card3 > 9 so card3 should be 0
    #5;
    assert(total === 4'd7) //total = (9+8+0)%10 = 7
    else $error("total is wrong for 1 out of range case");
    #5;
    card1 <= 4'd1;
    card2 <= 4'd11; //card2 > 9 so card2 should be 0
    card3 <= 4'd12; //card3 > 9 so card3 should be 0
    #5;
    assert(total === 4'd1) //total = (1+0+0)%10 = 1
    else $error("total is wrong for 2 out of range case");
    #5;
    card1 <= 4'd1;
    card2 <= 4'd2;
    card3 <= 4'd3; //no card is greater than 9
    #5;
    assert(total === 4'd6) //total = (1+2+3)%10 = 6
    else $error("total is wrong for no out of range case");
    #5;
    card1 <= 4'd2;
    card2 <= 4'd2;
    card3 <= 4'd6; //this case is for when the total can be divided by 10 with no remainder
    #5;
    assert(total === 4'd0) //total = (2+2+6)%10 = 0
    else $error("total is wrong for no remainder case");
    #5;
    $stop;
end
endmodule
