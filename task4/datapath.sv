module datapath(input logic slow_clock, input logic fast_clock, input logic resetb,
                input logic load_pcard1, input logic load_pcard2, input logic load_pcard3,
                input logic load_dcard1, input logic load_dcard2, input logic load_dcard3,
                output logic [3:0] pcard3_out,
                output logic [3:0] pscore_out, output logic [3:0] dscore_out,
                output logic [6:0] HEX5, output logic [6:0] HEX4, output logic [6:0] HEX3,
                output logic [6:0] HEX2, output logic [6:0] HEX1, output logic [6:0] HEX0);

// The code describing your datapath will go here.  Your datapath 
// will hierarchically instantiate six card7seg blocks, two scorehand
// blocks, and a dealcard block.  The registers may either be instatiated
// or included as sequential always blocks directly in this file.
//
// Follow the block diagram in the Lab 1 handout closely as you write this code.
logic [3:0] new_card, card1, card2, card3, card4, card5, card6;

//instantitate dealcard to get a new_card
dealcard DC1 (.clock(fast_clock),
          .resetb(resetb),
          .new_card(new_card));
//instantiate the loadReg module to load values into the correct register
loadReg P1 (.clk(slow_clock),
            .load(load_pcard1),
            .reset(resetb),
            .in(new_card),
            .out(card1));
loadReg P2 (.clk(slow_clock),
            .load(load_pcard2),
            .reset(resetb),
            .in(new_card),
            .out(card2));
loadReg P3 (.clk(slow_clock),
            .load(load_pcard3),
            .reset(resetb),
            .in(new_card),
            .out(card3));
loadReg D1 (.clk(slow_clock),
            .load(load_dcard1),
            .reset(resetb),
            .in(new_card),
            .out(card4));
loadReg D2 (.clk(slow_clock),
            .load(load_dcard2),
            .reset(resetb),
            .in(new_card),
            .out(card5));
loadReg D3 (.clk(slow_clock),
            .load(load_dcard3),
            .reset(resetb),
            .in(new_card),
            .out(card6));
//instantiate the card7seg modules to display both player's cards and dealer's cards
card7seg PCS1 (.value(card1), .HEX(HEX0));
card7seg PCS2 (.value(card2), .HEX(HEX1));
card7seg PCS3 (.value(card3), .HEX(HEX2));
card7seg DCS1 (.value(card4), .HEX(HEX3));
card7seg DCS2 (.value(card5), .HEX(HEX4));
card7seg DCS3 (.value(card6), .HEX(HEX5));

//instatiate scorehand module to caluclate the player's score and display it with LED
scorehand PS (.card1(card1),
               .card2(card2),
               .card3(card3),
               .total(pscore_out));
//instantiate scorehand module to calculate the dealer's score and display it with LED
scorehand DS (.card1(card4),
              .card2(card5),
              .card3(card6),
              .total(dscore_out));
assign pcard3_out = card3;

endmodule

module loadReg(input logic clk, input logic load, input logic reset, input logic [3:0] in, output logic [3:0]out);
    logic [3:0] next_out;
    assign next_out = reset ? (load ? in : out) : 4'b0000;
    always_ff @(negedge clk)begin
        out = next_out;
    end
endmodule