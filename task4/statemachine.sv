`define RESET 4'b0000
`define LDCARD1 4'b0001
`define LPCARD1 4'b0011
`define LDCARD2 4'b0010
`define LPCARD2 4'b0100

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
   `RESET: nextstate = `LPCARD1;
   `LPCARD1: nextstate = `LDCARD1;
   `LDCARD1: nextstate = `LPCARD2;
   `LPCARD2: nextstate = `LDCARD2;
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
always_comb begin
    case(currentstate)
    `RESET: output_assign = 8'b0_0_0_0_0_0_0_0;
    `LPCARD1: output_assign = 8'b1_0_0_0_0_0_0_0;
    `LDCARD1: output_assign = 8'b0_0_0_1_0_0_0_0;
    `LPCARD2: output_assign = 8'b0_1_0_0_0_0_0_0;
    `LDCARD2: output_assign = 8'b0_0_0_0_1_0_0_0;
    default: output_assign = 8'b0_0_0_0_0_0_0_0;
    endcase
    {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = output_assign;
end
 
endmodule

