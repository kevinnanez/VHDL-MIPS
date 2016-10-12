library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_std.all;

library work;
use work.components.all;

entity imem is
  port(a: in std_logic_vector(5 downto 0);
      rd: out std_logic_vector(31 downto 0)
      );
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
    --for i in 0 to MAX_BOUND-1 loop -- set all contents low
    mem(0) := x"20080000";
    mem(1) := x"20090001";
    mem(2) := x"200a0002";
    mem(3) := x"200b0003";
    mem(4) := x"200c0004";
    mem(5) := x"200d0005";
    mem(6) := x"200e0006";
    mem(7) := x"200f0007";
    mem(8) := x"ac080000";
    mem(9) := x"ac090004";
    mem(10) := x"ac0a0008";
    mem(11) := x"ac0b000c";
    mem(12) := x"ac0c0010";
    mem(13) := x"ac0d0014";
    mem(14) := x"ac0e0018";
    mem(15) := x"ac0f001c";
    mem(16) := x"ac0f001c";
    mem(17) := x"ac0f001c";
    mem(18) := x"ac0f001c";
    mem(19) := x"ac0f001c";
    mem(20) := x"ac0f001c";
      --mem(i) := "00000000000000000000000000000000";
    --end loop;
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
