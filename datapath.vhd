library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity datapath is

  port(MemToReg, MemWrite, Branch, AluSrc, RegDst, RegWrite, Jump, dump, reset, clk : std_logic;
      pc, instr : std_logic_vector(31 downto 0)
      );

end entity;

architecture behavior of datapath is
  
