#!/bin/sh
# this will go horribly wrong if any step fails, it's just the example from https://www.youtube.com/watch?v=yUiNlmvVOq8
yosys -p "read_verilog example.v; synth_ice40 -blif example.blif"  # makes .blif
arachne-pnr -d 1k -p example.pcf -o example.txt example.blif && rm example.blif # makes .txt and rms blif
icepack example.txt example.bin && rm example.txt # makes .bin and removes .txt
echo "Will need to sudo in order to write to device.\n"
sudo iceprog example.bin && rm example.bin # writes .bin to the icestick and then removes it

# note: Try "time ./go.sh". I get a real time of 0m3.134s on my development box. 
