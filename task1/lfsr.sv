module lfsr #(
    parameter WIDTH = 4
    /*
    Challenge:
    parameter WIDTH = 7
    */
)(
    input logic                   clk, // clock
    input logic                   rst, // reset
    input logic                    en, // enable
    output logic [WIDTH-1:0] data_out  // pseudo-random output
);

logic [4:1] sreg; // shift register
/*
Challenge:
logic [7:1] sreg;
*/

always_ff @(posedge clk)
    if (rst)
        sreg <= 4'b1;
    else if (en)
        sreg <= {sreg[3:1], sreg[4] ^ sreg[3]};

    /*
    Challenge:
    if (rst)
        sreg <= 7'b1;
    else if(en)
        sreg <= {sreg[6:1], sreg[3] ^ sreg[7]};
    */

assign data_out = sreg;
endmodule
