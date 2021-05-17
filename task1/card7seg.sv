module card7seg(input logic [3:0] SW, output logic [6:0] HEX0);
		
  always_comb begin
   HEX0 = 7'bx;
   if(SW == 4'b0000)//blank
      HEX0 = 7'b1111111;
   if(SW == 4'b0001)//ace
      HEX0 = 7'b0001000; //display A
   if(SW == 4'b0010)//2
      HEX0 = 7'b0100100;
   if(SW == 4'b0011)//3
      HEX0 = 7'b0110000;
   if(SW == 4'b0100)//4
      HEX0 = 7'b0011001;
   if(SW == 4'b0101)//5
      HEX0 = 7'b0010010;
   if(SW == 4'b0110)//6
      HEX0 = 7'b0000010;
   if(SW == 4'b0111)//7
      HEX0 = 7'b1111000;
   if(SW == 4'b1000)//8
      HEX0 = 7'b0;
   if(SW == 4'b1001)//9
      HEX0 = 7'b0010000;
   if(SW == 4'b1010)//0
      HEX0 = 7'b1000000;
   if(SW == 4'b1011)//jack
      HEX0 = 7'b1100001; //display j
   if(SW == 4'b1100)//queen
      HEX0 = 7'b0011000; //display q
   if(SW == 4'b1101)//king
      HEX0 = 7'b0001001;  //display k
   
  end
	
endmodule

