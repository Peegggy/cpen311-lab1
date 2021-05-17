module tb_card7seg();

  logic [3:0] SW;
  logic [6:0] HEX0;

  card7seg dut(.*);

/* if the code fails some test cases then the error message "Error: Assertion error"
   will display in the transcript window, else the code works and passes all cases.*/

  initial begin
     SW <= 4'd0; //blank
     #10;
     assert(HEX0 === 7'b1111111); //check to see if the LED output is nothing
     #10;
     
     SW <= 4'd1; //ace
     #10;
     assert(HEX0 === 7'b0001000); //output is A?
     #10;

     SW <= 4'd2; //2
     #10;
     assert(HEX0 === 7'b0100100); //output is 2?
     #10;

     SW <= 4'd3; //3
     #10;
     assert(HEX0 === 7'b0110000); //output is 3?
     #10;

     SW <= 4'd4; //4
     #10;
     assert(HEX0 === 7'b0011001); //output is 4?
     #10;

     SW <= 4'd5; //5
     #10;
     assert(HEX0 === 7'b0010010); //output is 5?
     #10;

     SW <= 4'd6; //6
     #10;
     assert(HEX0 === 7'b0000010); //output is 6?
     #10;

     SW <= 4'd7; //7
     #10;
     assert(HEX0 === 7'b1111000); //output is 7?
     #10;

     SW <= 4'd8; //8
     #10;
     assert(HEX0 === 7'b0); //output is 8?
     #10;

     SW <= 4'd9; //9
     #10;
     assert(HEX0 === 7'b0010000); //output is 9?
     #10;

     SW <= 4'd10; //10
     #10;
     assert(HEX0 === 7'b1000000); //output is 0?
     #10;

     SW <= 4'd11; //jack
     #10;
     assert(HEX0 === 7'b1100001); //output is j?
     #10;

     SW <= 4'd12; //queen
     #10;
     assert(HEX0 === 7'b0011000); //output is q?
     #10;

     SW <= 4'd13; //king
     #10;
     assert(HEX0 === 7'b0001001); //output is k?
     #10;
     
     SW <= 4'd14; //14
     #10;
     assert(HEX0 === 7'bx); //no such card, output should be blank
     #10;

     SW <= 4'd15; //15
     #10;
     assert(HEX0 === 7'bx); //no such card, output should be blank
     #10;

     $stop;
   end
endmodule

