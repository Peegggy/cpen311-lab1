module scorehand(input logic [3:0] card1, input logic [3:0] card2, input logic [3:0] card3, output logic [3:0] total);

always_comb begin
total = (card1+card2+card3)%10;
end
// The code describing scorehand will go here.  Remember this is a combinational
// block. The function is described in the handout. Be sure to review Verilog
// notes on bitwidth mismatches and signed/unsigned numbers.

endmodule