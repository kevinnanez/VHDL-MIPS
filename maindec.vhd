library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maindec is
	port(
    Op : in std_logic_vector(5 downto 0);
		MemToReg, MemWrite, Branch, AluSrc, RegDst, RegWrite, Jump : out std_logic;
		AluOp : out std_logic_vector(1 downto 0)
  );
end maindec;

architecture maindec of maindec is
begin
	process(Op)
	begin
		case Op is
			when "000000" =>
				MemToReg<='0'; MemWrite<='0'; Branch<='0'; AluSrc<='0'; RegDst<='1'; RegWrite<='1'; Jump<='0'; AluOp<="10";
			when "100011" =>
				MemToReg<='1'; MemWrite<='0'; Branch<='0'; AluSrc<='1'; RegDst<='0'; RegWrite<='1'; Jump<='0'; AluOp<="00";
			when "101011" =>
				MemToReg<='0'; MemWrite<='1'; Branch<='0'; AluSrc<='1'; RegDst<='0'; RegWrite<='0'; Jump<='0'; AluOp<="00";
			when "000100" =>
				MemToReg<='0'; MemWrite<='0'; Branch<='1'; AluSrc<='0'; RegDst<='0'; RegWrite<='0'; Jump<='0'; AluOp<="01";
			when "001000" =>
				MemToReg<='0'; MemWrite<='0'; Branch<='0'; AluSrc<='1'; RegDst<='0'; RegWrite<='1'; Jump<='0'; AluOp<="00";
			when "000010" =>
				MemToReg<='0'; MemWrite<='0'; Branch<='0'; AluSrc<='0'; RegDst<='0'; RegWrite<='0'; Jump<='1'; AluOp<="00";
			when others =>
				MemToReg<='-'; MemWrite<='-'; Branch<='-'; AluSrc<='-'; RegDst<='-'; RegWrite<='-'; Jump<='-'; AluOp<="--";
		end case;
	end process;
end maindec;
