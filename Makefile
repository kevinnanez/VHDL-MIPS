COMPONENTS = components.vhd adder.vhd alu.vhd aludec.vhd controller.vhd dmem.vhd imem.vhd flopr.vhd flopr1.vhd maindec.vhd mux2.vhd regfile.vhd signext.vhd sl2.vhd fetch.vhd decode.vhd execute.vhd memory.vhd writeback.vhd datapath.vhd


all: run mips

run:
	ghdl -a $(COMPONENTS)

clean: 
	rm -rf *_tb
	rm -rf *.o
	rm -rf *.cf
	rm -rf *.vcd

basics:
	ghdl -a maindec.vhd

components:
	ghdl -a $(COMPONENTS)

controller:
	ghdl -a controller.vhd

datapath:
	ghdl -a datapath.vhd

mips:
	ghdl -a mips.vhd
	ghdl -a mips_tb.vhd
	ghdl -e mips_tb
	./mips_tb --stop-time=300ns --vcd=mips.vcd

fetch:
	ghdl -a fetch.vhd
	ghdl -a fetch_tb.vhd
	ghdl -e fetch_tb
	./fetch_tb --stop-time=300ns --vcd=fetch.vcd
