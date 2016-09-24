library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  generic(width: integer := 32);
    port(a, b: in std_logic_vector(width-1 downto 0); alucontrol: in std_logic_vector(2 downto 0);
        zero: out std_logic; result: out std_logic_vector(width-1 downto 0));
end alu;

architecture alu of alu is
  begin
    process(alucontrol)
    variable temp: std_logic_vector(width-1 downto 0);
    begin
    case alucontrol is
      when "000" => temp := a and b;
      when "100" => temp := a and not b;
      when "001" => temp := a or b;
      when "101" => temp := a or not b;
      when "010" => temp := std_logic_vector(unsigned(a) + unsigned(b));
      when "110" => temp := std_logic_vector(unsigned(a) - unsigned(b));
      when "111" =>
        if a < b then
          temp := "11111111111111111111111111111111";
        else
          temp := "00000000000000000000000000000000";
        end if;
        when others => temp := "--------------------------------";
      end case;
      if temp = "00000000000000000000000000000000" then
        zero <= '1';
      else
        zero <= '0';
      end if;
      result <= temp;
    end process;
end alu;
