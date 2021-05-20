module tb_datapath();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
logic slow_clock, fast_clock, resetb, load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3;
logic [3:0] pcard3_out, pscore_out, dscore_out;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

datapath dut(.*);

initial begin
    slow_clock = 0;
    forever #10 slow_clock = ~slow_clock;
end

initial begin
    resetb <= 0;
    #5;
    resetb <= 1;

    
end
endmodule
