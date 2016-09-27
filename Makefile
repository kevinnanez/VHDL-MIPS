NOMBRE = controller

all: aludec maindec controller

# run:
# 	echo "Super Makefile!"
# 	ghdl -a $(NOMBRE).vhd
# 	ghdl -a $(NOMBRE)_tb.vhd
# 	ghdl -e $(NOMBRE)_tb
# 	./$(NOMBRE)_tb --stop-time=200ns --vcd=$(NOMBRE).vcd

clean: 
	rm -rf *_tb
	rm -rf *.o
	rm -rf *.cf
	rm -rf *.vcd

aludec:
	ghdl -a aludec.vhd
	# ghdl -a aludec_tb.vhd
	# ghdl -e aludec_tb
	# ./aludec_tb --stop-time=200ns --vcd=aludec.vcd

maindec:
	ghdl -a maindec.vhd
	# ghdl -a maindec_tb.vhd
	# ghdl -e maindec_tb
	# ./maindec_tb --stop-time=200ns --vcd=maindec.vcd

controller:
	ghdl -a controller.vhd
	ghdl -a controller_tb.vhd
	ghdl -e controller_tb
	./controller_tb --stop-time=200ns --vcd=controller.vcd
