
1k: upload-1k 

upload-1k: example-1k.bin
	sudo iceprog example-1k.bin && rm example-1k.bin

example-1k.bin: example-1k.txt
	icepack example-1k.txt example-1k.bin && rm example-1k.txt

example-1k.txt: example-1k.blif
	arachne-pnr -d 1k -p example-1k.pcf -o example-1k.txt example-1k.blif && rm example-1k.blif

example-1k.blif: example-1k.v
	yosys -p "read_verilog example-1k.v; synth_ice40 -blif example-1k.blif"


8k: upload-8k 

upload-8k: example-8k.bin
	sudo iceprog example-8k.bin && rm example-8k.bin

example-8k.bin: example-8k.txt
	icepack example-8k.txt example-8k.bin && rm example-8k.txt

example-8k.txt: example-8k.blif
	arachne-pnr -d 8k -p example-8k.pcf -o example-8k.txt example-8k.blif && rm example-8k.blif

example-8k.blif: example-8k.v
	yosys -p "read_verilog example-8k.v; synth_ice40 -blif example-8k.blif"
