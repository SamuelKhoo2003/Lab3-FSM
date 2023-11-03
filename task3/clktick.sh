#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f *.vcd

# run Verilator to translate Verilog into C++, including C++ testbench
verilator -Wall --cc --trace clktick.sv --exe clktick_tb.cpp

# build C++ project via make automatically generated by Verilator
make -j -C obj_dir/ -f Vclktick.mk Vclktick

# run executable simulation file
echo "\nRunning simulation"
obj_dir/Vclktick
echo "\nSimulation completed"

# MY N VALUE is 24/25