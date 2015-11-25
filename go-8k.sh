#!/bin/sh
# this will go horribly wrong if any step fails, it's just the example from https://www.youtube.com/watch?v=yUiNlmvVOq8
yosys -p "read_verilog example-8k.v; synth_ice40 -blif example-8k.blif"  # makes .blif
arachne-pnr -d 8k -p example-8k.pcf -o example-8k.txt example-8k.blif && rm example-8k.blif # makes .txt and rms blif
icepack example-8k.txt example-8k.bin && rm example-8k.txt # makes .bin and removes .txt
echo "Will need to sudo in order to write to device.\n"
sudo iceprog example-8k.bin && rm example-8k.bin # writes .bin to the icestick and then removes it

# note: Try "time ./go.sh". I get a real time of 0m3.134s on my development box. 
