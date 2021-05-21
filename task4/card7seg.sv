module card7seg(input logic [3:0] value, output logic [6:0] HEX);
		//this module displays the dealt card on the board
  always_comb begin
   HEX = 7'b1;
   if (value == 4'b0000)//blank
      HEX = 7'b1111111;
   if (value == 4'b0001)//ace
      HEX = 7'b0001000; //display A
   if (value == 4'b0010)//2
      HEX = 7'b0100100;
   if (value == 4'b0011)//3
      HEX = 7'b0110000;
   if (value == 4'b0100)//4
      HEX = 7'b0011001;
   if (value == 4'b0101)//5
      HEX = 7'b0010010;
   if (value == 4'b0110)//6
      HEX = 7'b0000010;
   if (value == 4'b0111)//7
      HEX = 7'b1111000;
   if (value == 4'b1000)//8
      HEX = 7'b0;
   if (value == 4'b1001)//9
      HEX = 7'b0010000;
   if (value == 4'b1010)//0
      HEX = 7'b1000000;
   if (value == 4'b1011)//jack
      HEX = 7'b1100001; //display j
   if (value == 4'b1100)//queen
      HEX = 7'b0011000; //display q
   if (value == 4'b1101)//king
      HEX = 7'b0001001;  //display k
  end
	
endmodule

