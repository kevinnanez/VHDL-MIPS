library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity memory_tb is
end entity;

architecture arq of memory_tb is

signal dump_s           : std_logic;
signal MemWrite_s       : std_logic;
signal zeroM_s          : std_logic;
signal clk_s            : std_logic;
signal AluOutM_s        : std_logic_vector(31 downto 0);
signal WriteDataM_s     : std_logic_vector(31 downto 0);
signal ReadDat_s        : std_logic_vector(31 downto 0);


begin

memory0 : memory port map(dump => dump_s,
                          MemWriteM => MemWrite_s,
                          clk => clk_s,
                          AluOutM => AluOutM_s,
                          WriteDataM => WriteDataM_s,
                          ReadDataM => ReadDat_s);

process
begin

clk_s <= '0';
wait for 2 ns;
clk_s <= '1';
wait for 2 ns;

end process;



process
begin

-- escribimos los primeros cinco cuadrados: 0 1 4 9 16

  MemWrite_s <= '1';
  AluOutM_s <= x"00000000";
  zeroM_s <= '1';
  WriteDataM_s <= x"00000000";
  wait for 10 ns;
  AluOutM_s <= "00000000000000000000000000000100";
  zeroM_s <= '0';
  WriteDataM_s <= x"00000001";
  wait for 10 ns;
  AluOutM_s <= "00000000000000000000000000001000";
  WriteDataM_s <= x"00000004";
  wait for 10 ns;
  AluOutM_s <= "00000000000000000000000000001100";
  WriteDataM_s <= x"00000009";
  wait for 10 ns;
  AluOutM_s <= "00000000000000000000000000010000";
  WriteDataM_s <= x"00000010";
  wait for 10 ns;
-- ahora leemos la dir 1 y 2 para verificar
  MemWrite_s <= '0';
  AluOutM_s <= "00000000000000000000000000000100";
  wait for 10 ns;
  AluOutM_s <= "00000000000000000000000000001000";
  wait for 10 ns;

  dump_s <= '1';
  wait for 2 ns;
  wait;
end process;
end arq;
