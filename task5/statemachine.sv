`define RESET 4'b0000 //reset state
`define LDCARD1 4'b0001 // load dealer card 1 state
`define LPCARD1 4'b0011 // load player card 1 state
`define LDCARD2 4'b0010 //load dealer card 2 state
`define LPCARD2 4'b0100 //load player card 2 state
`define LPCARD3 4'b0110 //load player card 3 state
`define LDCARD3 4'b0111 //load dealer card 3 state
`define WINNER 4'b1000 //determines the winner

module statemachine(input logic slow_clock, input logic resetb,
                    input logic [3:0] dscore, input logic [3:0] pscore, input logic [3:0] pcard3,
                    output logic load_pcard1, output logic load_pcard2, output logic load_pcard3,
                    output logic load_dcard1, output logic load_dcard2, output logic load_dcard3,
                    output logic player_win_light, output logic dealer_win_light);


// The code describing your state machine will go here.  Remember that
// a state machine consists of next state logic, output logic, and the 
// registers that hold the state.  You will want to review your notes from
// CPEN 211 or equivalent if you have forgotten how to write a state machine.

//output_assign={load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light};
logic [7:0] output_assign;

logic [3:0] currentstate, nextstate;

always_comb begin
   case(currentstate) 
  `RESET: nextstate <= `LPCARD1;
   `LPCARD1: nextstate <= `LDCARD1;
   `LDCARD1: nextstate <= `LPCARD2;
   `LPCARD2: nextstate <= `LDCARD2;
   `LDCARD2:begin  //if dscore is not 8 or 9 and pscore is from 0 to 5, player gets a third card
                if((dscore !== 4'd8 || dscore !== 4'd9) && pscore < 4'd6) nextstate <= `LPCARD3;
                //if pscore is 6 or 7 and dscore is 0 to 5, dealer gets a third card
                else if(4'd5 < pscore < 4'd8 && dscore < 4'd6) nextstate <= `LDCARD3;
                //otherwise no one gets a third card
                else nextstate <= `WINNER;
   end
   `LPCARD3: begin if(dscore !== 4'd7 && //dscore cannot be 7 or else dealer doesn't get a card
                    // if dscore is 6 and pcard3 is 6 or 7 dealer gets a card
                    ((dscore === 4'd6 && 4'd5 < pcard3 < 4'd8) || 
                    //if dscore is 5 and pcard3 is 4,5,6 or 7 dealer gets a card
                    (dscore === 4'd5 && 4'd3 < pcard3 < 4'd8) ||
                    //if dscore is 4 and pcard3 is 2,3,4,5,6, or 7 dealer gets a card
                    (dscore === 4'd4 && 4'd1 < pcard3 < 4'd8) ||
                    //if dscore is 3 and pcard3 is not 8 dealer gets a card
                    (dscore === 4'd3 && pcard3 !== 4'd8) ||
                    //if dscore is 0,1 or 2;
                    (dscore < 4'd3)))
                    nextstate <= `LDCARD3;
            //if non is satisfied, dealer does not get a card
            else nextstate <= `WINNER;
   end
   `LDCARD3: nextstate <= `WINNER;
   `WINNER: nextstate <= `RESET;
   default: nextstate <= `RESET;
   endcase 
end

always_ff @(negedge slow_clock) begin
    if(resetb)
    currentstate <= nextstate;
    else 
    currentstate <= `RESET;
end

//output_assign=
//{load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light};
always_ff @(negedge slow_clock) begin //turns on different load signals depending one whose turn it is to get the card
    case(currentstate)
    `RESET: output_assign = 8'b0_0_0_0_0_0_0_0;
    `LPCARD1: output_assign = 8'b1_0_0_0_0_0_0_0;
    `LDCARD1: output_assign = 8'b0_0_0_1_0_0_0_0;
    `LPCARD2:  output_assign = 8'b0_1_0_0_0_0_0_0;
    `LDCARD2:  output_assign = 8'b0_0_0_0_1_0_0_0;
    //`GAME_CONT: output_assign = 8'b0_0_0_0_0_0_0_0;
                 
    `LPCARD3:  output_assign = 8'b0_0_1_0_0_0_0_0;
    `LDCARD3: output_assign = 8'b0_0_0_0_0_1_0_0;
    `WINNER: begin if(pscore > dscore)
                        output_assign = 8'b0_0_0_0_0_0_1_0;
                    else if(pscore < dscore)
                        output_assign = 8'b0_0_0_0_0_0_0_1;
                    else if(pscore == dscore) output_assign = 8'b0_0_0_0_0_0_1_1;
              end
    default: output_assign = 8'b00000000;
    endcase
    {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = output_assign;
end
endmodule

//second version of the code which makes sense to me but i dont know why the third card is not being drawn

/*`define RESET 4'b0000 //reset state
`define LDCARD1 4'b0001 // load dealer card 1 state
`define LPCARD1 4'b0011 // load player card 1 state
`define LDCARD2 4'b0010 //load dealer card 2 state
`define LPCARD2 4'b0100 //load player card 2 state
`define GAME_CONT 4'b0101 //should the game continue?
`define LPCARD3 4'b0110 //load player card 3 state
`define LDCARD3 4'b0111 //load dealer card 3 state
`define WINNER 4'b1000 //determines the winner

module statemachine(input logic slow_clock, input logic resetb,
                    input logic [3:0] dscore, input logic [3:0] pscore, input logic [3:0] pcard3,
                    output logic load_pcard1, output logic load_pcard2, output logic load_pcard3,
                    output logic load_dcard1, output logic load_dcard2, output logic load_dcard3,
                    output logic player_win_light, output logic dealer_win_light);


// The code describing your state machine will go here.  Remember that
// a state machine consists of next state logic, output logic, and the 
// registers that hold the state.  You will want to review your notes from
// CPEN 211 or equivalent if you have forgotten how to write a state machine.

logic p_gets_card, d_gets_card;
//output_assign={load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light};
logic [7:0] output_assign;

logic [3:0] currentstate, nextstate;

always_comb begin
   case(currentstate) 
  `RESET: nextstate = `LPCARD1;
   `LPCARD1: nextstate = `LDCARD1;
   `LDCARD1: nextstate = `LPCARD2;
   `LPCARD2: nextstate = `LDCARD2;
   `LDCARD2: nextstate = `GAME_CONT;
   `GAME_CONT: begin if(4'd8 <= pscore <= 4'd9 || 4'd8 <= dscore <= 4'd9)
                    nextstate = `WINNER;
            
                else nextstate = p_gets_card ? `LPCARD3 : `LDCARD3;
   end
   `LPCARD3: nextstate = d_gets_card ? `LDCARD3 : `WINNER;
   `LDCARD3: nextstate = `WINNER;
   `WINNER: nextstate = `RESET;
   default: nextstate = `RESET;
   endcase 
end

always_ff @(negedge slow_clock) begin
    if(resetb)
    currentstate <= nextstate;
    else 
    currentstate <= `RESET;
end

//output_assign=
//{load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light};
always_ff @(negedge slow_clock) begin //turns on different load signals depending one whose turn it is to get the card
    case(currentstate)
    `RESET: output_assign = 8'b0_0_0_0_0_0_0_0;
    `LPCARD1: output_assign = 8'b1_0_0_0_0_0_0_0;
    `LDCARD1: output_assign = 8'b0_0_0_1_0_0_0_0;
    `LPCARD2:  output_assign = 8'b0_1_0_0_0_0_0_0;
    `LDCARD2: begin output_assign = 8'b0_0_0_0_1_0_0_0;
             if(pscore <= 4'd5) begin
                 if((dscore==4'd6 && 4'd6<=pcard3<=4'd7) || 
                    (dscore==4'd5 && 4'd4<=pcard3<=4'd7) ||
                    (dscore==4'd4 && 4'd2<=pcard3<=4'd7) ||
                    (dscore==4'd3 && pcard3 !== 4'd8) ||
                    (4'd0<=dscore<=4'd2)) begin
                        d_gets_card = 1;
                        p_gets_card = 1;
                    end
                 else begin 
                    p_gets_card = 1;
                    d_gets_card = 0;
                    end
             end
            else if(4'd6<=pscore<=4'd7)begin
                    if(4'd0<=dscore<=4'd5)begin
                        p_gets_card = 0;
                        d_gets_card = 1;
                    end
                        else begin
                            p_gets_card = 0;
                            d_gets_card = 0;
                        end
            end
            else begin
                p_gets_card = 0;
                d_gets_card = 0;
            end
    end
    `GAME_CONT: output_assign = 8'b0_0_0_0_0_0_0_0;
    `LPCARD3:  output_assign = 8'b0_0_1_0_0_0_0_0;
    `LDCARD3: output_assign = 8'b0_0_0_0_0_1_0_0;
    `WINNER: begin if(pscore > dscore)
                        output_assign = 8'b0_0_0_0_0_0_1_0;
                    else if(pscore < dscore)
                        output_assign = 8'b0_0_0_0_0_0_0_1;
                    else if(pscore == dscore) output_assign = 8'b0_0_0_0_0_0_1_1;
              end
    default: output_assign = 8'b00000000;
    endcase
    {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = output_assign;
end
endmodule
*/