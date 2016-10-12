library ieee;
use ieee.std_logic_1164.all;

entity fetch_tb is
end fetch_tb;


architecture arq of fetch_tb is

component fetch is

  port(Jump             : in  std_logic;
       clk              : in  std_logic;
       reset            : in  std_logic;
       PcSrcM           : in  std_logic;
       PcBranchM        : in  std_logic_vector(31 downto 0);
       InstrF           : out std_logic_vector(31 downto 0);
       PCF              : out std_logic_vector(31 downto 0);
       PCPlus4F         : out std_logic_vector(31 downto 0));
end component;

signal Jump_s             :  std_logic;
signal clk_s              :  std_logic;
signal reset_s            :  std_logic;
signal PcSrcM_s           :  std_logic;
signal PcBranchM_s        :  std_logic_vector(31 downto 0);
signal InstrF_s           : std_logic_vector(31 downto 0);
signal PCF_s              : std_logic_vector(31 downto 0);
signal PCPlus4F_s         : std_logic_vector(31 downto 0);

begin

nombre : fetch port map(Jump => Jump_s,
                        PcSrcM => PcSrcM_s,
                        PcBranchM => PcBranchM_s,
                        clk => clk_s,
                        reset => reset_s,
                        InstrF => InstrF_s,
                        PCF => PCF_s,
                        PCPlus4F => PCPlus4F_s);

-- Todo irá oscilando (esta es la señal que hicieron los wacho)
PcBranchM_s <= "00000000000000000000000000000000";
--clk process
    process
        begin
        clk_s <= '1';
        wait for 10 ns;
        clk_s <= '0';
        wait for 10 ns;
    end process;

--Dump memory process
    process
        begin
            reset_s <= '1';
                  Jump_s <= '0';
                  PCSrcM_s <= '0';
            wait for 40 ns;
            reset_s <= '0';
            wait for 170 ns;
        end process;
    

end arq;
