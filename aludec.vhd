library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity aludec is
port (funct : in std_logic_vector (5 downto 0);
      aluop : in std_logic_vector (1 downto 0);
      alucontrol : out std_logic_vector (2 downto 0)
);
end entity;

architecture aludec of aludec is
begin
process (funct, aluop)
begin
	case aluop is
		when "00" => alucontrol <= "010";
		when "01" => alucontrol <= "110";
		when "1-" =>
		case funct is
			when "100000" => alucontrol <= "010";
			when "100010" => alucontrol <= "110";
			when "100100" => alucontrol <= "000";
			when "100101" => alucontrol <= "001";
			when "101010" => alucontrol <= "111";
			when others => alucontrol <= "---";
		end case;
		when others => alucontrol <= "---";
	end case;
end process;
end aludec;
