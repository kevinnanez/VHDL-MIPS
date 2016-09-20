-------------------------------------------------------------------------------
--
-- Title       : imem
-- Design      : Mips
-- Author      : Eduardo Sanchez - modificado
-- Company     : Famaf
--
-------------------------------------------------------------------------------
--
-- File        : imem.vhd
--
-------------------------------------------------------------------------------
--
-- Description : Archivo con el diseño de la memoria ROM del procesador MIPS.
-- Para mantener un diseño corto, la memoria solo puede contener hasta 64 
-- instrucciones (palabras) de 32 bits(aunque podria direccionar mas memoria)
-- Inicialmente, al salir de reset, carga en la memoria el archivo MIPS_SOFT_FILE
-- con el programa a ejecutar.
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use STD.TEXTIO.all;
use IEEE.numeric_std.all; 

library WORK;
use WORK.components.all;

entity imem is -- instruction memory
  port(a:  in  STD_LOGIC_VECTOR(5 downto 0);
       rd: out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of imem is

constant MAX_BOUND: Integer := 64;

begin
  process is
    file mem_file: TEXT;
    variable L: line;
    variable ch: character;
    variable index, result: integer;
    variable word: STD_LOGIC_VECTOR(31 downto 0);
    type ramtype is array (MAX_BOUND-1 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
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
end;
