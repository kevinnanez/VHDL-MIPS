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
			when "000000" => tmp := "110000010";
      when "100011" => tmp := "101001000";
      when "101011" => tmp := "001010000";
      when "000100" => tmp := "000100001";
      when "001000" => tmp := "101000000";
      when "000010" => tmp := "000000100";
      when others   => tmp := "---------";
    end case;

    RegWrite <= tmp(8);
    RegDst   <= tmp(7);
    AluSrc   <= tmp(6);
    Branch   <= tmp(5);
    MemWrite <= tmp(4);
    MemToReg <= tmp(3);
    Jump     <= tmp(2);
    AluOp    <= tmp(1 downto 0);
		
		end case;
	end process;
end maindec;
