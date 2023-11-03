module f1 #(
	parameter A_WIDTH = 16,
    parameter D_WIDTH = 8
)(
  // interface signals
  input  logic                  clk,        // clock 
  input  logic                  rst,        // reset
  input  logic                  en,         // enable signal
  input  logic [A_WIDTH-1:0]    N,     	    // clock divided by N+1
  output logic [D_WIDTH-1:0]    data_out    // tick output
);

logic count;

// instantiate f1_fsm module called fsm
f1_fsm fsm (
  .clk (clk),
  .rst (rst),
  .en (count), // the external signal name must be count since 'logic count' 
  .data_out (data_out)
);

// instantiate clktick module called clktick
clktick clktick (
  .clk (clk),
  .rst (rst),
  .en (en),
  .N (N),
  .tick (count) // the external signal name must be count since 'logic count' 
);

endmodule