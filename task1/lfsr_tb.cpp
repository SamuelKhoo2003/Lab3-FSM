#include "Vlfsr.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include "vbuddy.cpp"
#define MAX_SIM_CYC 100000

int main(int argc, char **argv, char **env){
    int simcyc;
    int clk;

    Verilated::commandArgs(argc, argv);

    // init top verilog instance
    Vlfsr* top = new Vlfsr;

    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("lfsr.vcd");

    if (vbdOpen() != 1) return (-1);
    vbdHeader("L3T1:4B LFSR");

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 1;
    top->en = 0;

    // run simulation for many clock cycles
    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++) {

        top->rst = (simcyc < 2);
        top->en = vbdFlag();
        vbdSetMode(1);
        
        // dump variables into VCD file and toggle clock
        for (clk = 0; clk < 2; clk++){
            tfp->dump (2*simcyc + clk); // unit is in ps!!!
            top->clk = !top->clk;
            top->eval();
        }

        /* 
        Challenge:
        vbdHex(2, (int(top->data_out) >> 4) & 0xF); 
        */

        vbdHex(1, int(top->data_out) & 0xF);

        vbdBar(top->data_out & 0xFF);
        vbdCycle(simcyc + 1);
        // ---- end of Vbuddy output section

        if (Verilated::gotFinish()) exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);

}