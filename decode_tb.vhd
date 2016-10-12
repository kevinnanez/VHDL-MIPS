library ieee;
use ieee.std_logic_1164.all;

entity decode_tb is
end entity;

architecture arq of decode_tb is

component decode is

  port(RegWriteW         : in  std_logic;
       clk              : in  std_logic;
       InstrD           : in  std_logic_vector(31 downto 0);
       ResultW              : in  std_logic_vector(31 downto 0);
       WriteRegW               : in  std_logic_vector(4 downto 0);
       SignImmD         : out std_logic_vector(31 downto 0);
       RD1             : out std_logic_vector(31 downto 0);
       RD2             : out std_logic_vector(31 downto 0);
       RtD              : out std_logic_vector(4 downto 0);
       RdD              : out std_logic_vector(4 downto 0);
               Op, Funct : out std_logic_vector(5 downto 0)
);
end component;

signal RegWrite_s         :  std_logic;
signal clk_s              :  std_logic;
signal InstrD_s           :  std_logic_vector(31 downto 0);
signal Wd3_s              :  std_logic_vector(31 downto 0);
signal A3_s               :  std_logic_vector(4 downto 0);
signal SignImmD_s         : std_logic_vector(31 downto 0);
signal RD1D_s             : std_logic_vector(31 downto 0);
signal RD2D_s             : std_logic_vector(31 downto 0);
signal RtD_s              : std_logic_vector(4 downto 0);
signal RdD_s              : std_logic_vector(4 downto 0);
signal Op_s              : std_logic_vector(5 downto 0);
signal Funct_s              : std_logic_vector(5 downto 0);

begin

decode0 : decode PORT MAP(RegWriteW => RegWrite_s,
                         clk => clk_s,
                         InstrD => InstrD_s,
                         ResultW => Wd3_s,
                         WriteRegW => A3_s,
                         SignImmD => SignImmD_s,
                         RD1=> RD1D_s,
                         RD2 => RD2D_s,
                         RtD => RtD_s,
                         Funct => Funct_s,
                        Op => Op_s);
process
begin


-- que alguien pruebe esto por el amor de...
--señal de los wacho
--clk process
        clk_s <= '1';
        wait for 5 ns;
        clk_s <= '0';
        wait for 5 ns;
    end process;

--Dump memory process
    process
        begin
            RegWrite_s <= '1';
            A3_s <= "01000";
            Wd3_s <= X"00000001";
            wait for 10 ns;
            RegWrite_s <= '1';
            A3_s <= "01001";
            Wd3_s <= X"00000002";
            wait for 10 ns;
            RegWrite_s <= '1';
            A3_s <= "01010";
            Wd3_s <= X"00000003";
            wait for 10 ns;
            RegWrite_s <= '0';
            InstrD_s <= x"20080000";
            wait for 10 ns;
            RegWrite_s <= '0';
            InstrD_s <= x"20090001";
            wait for 10 ns;
            RegWrite_s <= '0';
            InstrD_s <= x"200a0002";
            wait for 10 ns;
            RegWrite_s <= '0';
            InstrD_s <= x"200b0003";
            wait for 10 ns;
      

end process;

end;
