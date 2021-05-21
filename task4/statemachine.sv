`define RESET 4'b0000 //reset state
`define LDCARD1 4'b0001 // load dealer card 1 state
`define LPCARD1 4'b0011 // load player card 1 state
`define LDCARD2 4'b0010 //load dealer card 2 state
`define LPCARD2 4'b0100 //load player card 2 state

//the statemachine module indicates whether the player or the dealer gets a card.
//the states of the statemachine will indicate with load signals to turn on.
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

//assigning the next state depending on the current state and condtions
always_comb begin
   case(currentstate) //assigning the next state depending on the current state
   `RESET: nextstate = `LPCARD1;
   `LPCARD1: nextstate = `LDCARD1;
   `LDCARD1: nextstate = `LPCARD2;
   `LPCARD2: nextstate = `LDCARD2;
   default: nextstate = `RESET;
   endcase 
end

//indicates when the next state becomes the current state
always_ff @(negedge slow_clock) begin //negedge because KEY has reverse logic
    if(resetb) //meaning reset is actually off
    currentstate <= nextstate; //the next state becomes the current state
    else 
    currentstate <= `RESET; //if reset is on, the current state is the reset state
end
//output_assign=
//{load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light};
always_comb begin
    case(currentstate) //turns on different load signals depending one whose turn it is to get the card
    `RESET: output_assign = 8'b0_0_0_0_0_0_0_0;
    `LPCARD1: output_assign = 8'b1_0_0_0_0_0_0_0;
    `LDCARD1: output_assign = 8'b0_0_0_1_0_0_0_0;
    `LPCARD2: output_assign = 8'b0_1_0_0_0_0_0_0;
    `LDCARD2: output_assign = 8'b0_0_0_0_1_0_0_0;
    default: output_assign = 8'b0_0_0_0_0_0_0_0;
    endcase
    //assign the load signals
    {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = output_assign;
end
 
endmodule

