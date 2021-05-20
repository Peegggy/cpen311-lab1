module scorehand(input logic [3:0] card1, input logic [3:0] card2, input logic [3:0] card3, output logic [3:0] total);

logic [3:0] card_val1, card_val2, card_val3; //the actual score values will be stored in here

always_comb begin
//check if card1 is in the range of ace to 9, if not, score value for card1 = 0
if(card1 < 4'd10)
    card_val1 = card1;
else 
    card_val1 = 4'd0;
//check if card2 is in the range of ace to 9, if not, score value for card2 = 0
if(card2 < 4'd10)
    card_val2 = card2;
else
    card_val2 = 4'd0;
//check if card3 is in the range of ace to 9, if not, score value for card3 = 0
if(card3 < 4'd10)
    card_val3 = card3;
else
    card_val3 = 4'd0;
//the total score is the right most digit of all the score values summed
total = (card_val1+card_val2+card_val3)%4'd10;
end
// The code describing scorehand will go here.  Remember this is a combinational
// block. The function is described in the handout. Be sure to review Verilog
// notes on bitwidth mismatches and signed/unsigned numbers.

endmodule

