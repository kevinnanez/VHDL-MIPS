library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_std.all; 

library work;
use work.components.all;

entity dmem is
  port(clk, we, dump: in std_logic; a, wd: in std_logic_vector(31 downto 0); rd: out std_logic_vector(31 downto 0));
end dmem;

architecture dmem of dmem is
 constant MAX_BOUND: Integer := 64;
 
 type ramtype is array (MAX_BOUND-1 downto 0) of std_logic_vector(31 downto 0);
 signal mem: ramtype;

 procedure memDump is
   file dumpfile : text open write_mode is MEMORY_DUMP_FILE;
   variable dumpline : line;
   variable i: natural := 0;
   begin
		write(dumpline, string'("Memoria RAM de Mips:"));
		writeline(dumpfile,dumpline);
		write(dumpline, string'("Address Data"));
		writeline(dumpfile,dumpline);
      while i <= MAX_BOUND-1 loop        
		  write(dumpline, i);
		  write(dumpline, string'(" "));
		  write(dumpline, to_integer(unsigned(mem(i))));		  
		  writeline(dumpfile,dumpline);
        i:=i+1;
      end loop;
   end procedure memDump;

begin
   process(clk, a, mem)
	begin 
	  if clk'event and clk = '1' and we = '1' then
				mem(to_integer(unsigned(a(7 downto 2)))) <= wd;
	  end if;
	   rd <= mem(to_integer(unsigned(a(7 downto 2))));
	end process;
	
	process(dump)
	begin
	 if dump = '1' then
	   memDump;
	 end if;
	end process;
end dmem;
