library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity datapath is
  port(PCNext, PC, Instr, PCPlus4, WriteReg, Result, SignImm, WriteData, SrcA, SrcB, ALUResult, ReadData, PCBranch: std_logic_vector(31 downto 0);
	   Jump, CLK, reset, RegWrite, RegDst, AluSrc, AluControl, Zero, MemWrite, dump, MemToReg : std_logic);
end entity;


architecture structural of datapath is

	--component Duda 3

signal PCJump, PCSrc, InAdderA, InAdderB: std_logic_vector(31 downto 0); --Aca los que yo creo(de crear)
	--En vez de signal, me gustaria usar variables. La diferencia entre ambas es que la señal tiene que esperar
	--a que pase la vuelta del clk para asignar el valor, en cambio la variable lo asigna inmediatamente. 
	--Diganme que les parece mejor para el caso.

begin

U0: mux2 port map(PCBranch, PCBranch, PCSrc, PCNext) -- Duda 4
U1: mux2 port map(PCNext, PCJump, Jump, PC)
U2: flopr port map(PC, CLK, reset, PC)
U3: imem port map(PC, Instr)
U4: mux2 port map(Instr(20:16), Instr(15:11), RegDst, WriteReg) -- Duda 5
U5: regfile port map(Instr(25:21), Instr(20:16), WriteReg, Result, CLK, RegWrite, SrcA, WriteData)
U6: mux2 port map(WriteData, SignImm, AluSrc, SrcB)
U7: alu port map(SrcA, SrcB, AluControl, Zero, ALUResult)
U8: dmem port map(ALUResult, WriteData, CLK, MemWrite, dump, ReadData)
U9: mux2 port map(ALUResult, ReadData, MemToReg, Result)
U10: signext port map(Instr(15:0), SignImm)
U11: sl2 port map(SignImm, InAdderA)
U12: adder port map(PC, InAdderB, PCPlus4)
U13: adder port map(InAdderA, PCPlus4, PCBranch)

end structural;

--InAdderA no figura en el grafico
--InAdderB es una variable de 32bits que representan al 4 (crearla!)

