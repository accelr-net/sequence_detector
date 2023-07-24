
if [file exists "work"] {vdel -all}
vlib work

vlog -64 -incr -mfcu -sv seq_detector.sv
vlog -64 -incr -mfcu -sv testbench.sv

vopt -64 +acc=npr testbench -o testbench_opt

vsim testbench_opt -wlf mywlf.wlf

# add log /* -r
add log sim:/testbench/dut/*

run -all

dataset save

quit

