library ieee; 
use ieee.std_logic_1164.all; 
use std.textio.all;
use ieee.numeric_std.all; 

library work;
use work.components.all;

entity imem is
  port(a:  in  STD_LOGIC_VECTOR(5 downto 0);
       rd: out STD_LOGIC_VECTOR(31 downto 0));
end imem;

architecture imem of imem is

constant MAX_BOUND: integer := 64;

begin
  process is
    file mem_file: text;
    variable L: line;
    variable ch: character;
    variable index, result: integer;
    variable word: std_logic_vector(31 downto 0);
    type ramtype is array (MAX_BOUND-1 downto 0) of std_logic_vector(31 downto 0);
    variable mem: ramtype;
  begin
    -- initialize memory from file
    for i in 0 to MAX_BOUND-1 loop -- set all contents low
      mem(i) := "00000000000000000000000000000000";
    end loop;
    index := 0; 
    FILE_OPEN(mem_file, MIPS_SOFT_FILE, READ_MODE);
    while not endfile(mem_file) loop
      readline(mem_file, L);
      result := 0;
      for i in 1 to 8 loop
        read(L, ch);
        if '0' <= ch and ch <= '9' then 
            result := result*16 + character'pos(ch)-character'pos('0');
        elsif 'a' <= ch and ch <= 'f' then
            result := result*16 + character'pos(ch)-character'pos('a')+10;
        else report "Format error on line " & integer'image(index)
             severity error;
        end if;
      end loop;
      word := std_logic_vector(to_signed(result, word'length));
      mem(index) := word;
      index := index + 1;
    end loop;

    -- read memory
    loop
      rd <= mem(to_integer(unsigned(a)));
      wait on a;
    end loop;
  end process;
end imem;
