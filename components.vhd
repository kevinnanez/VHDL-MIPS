library ieee;
use ieee.std_logic_1164.all;

package components is

	component adder is
		port (a, b: in std_logic_vector(width-1 downto 0); y: out std_logic_vector(width-1 downto 0));
	end component;

	component flopr is
		port (q: out std_logic_vector(width-1 downto 0); d: in std_logic_vector(width-1 downto 0); clk, reset: in std_logic);
	end component;

	component mux2 is
    	port (d0, d1: in std_logic_vector(width-1 downto 0); s: in std_logic; y: out std_logic_vector(width-1 downto 0));
	end component;

	component imem is
		port(a:  in  std_logic_vector(5 downto 0); rd: out std_logic_vector(31 downto 0));
	end component;

	component signext is
		port(a: in std_logic_vector (15 downto 0); y: out std_logic_vector (31 downto 0));
	end component;
	
	component sl2 is
		port(a : in std_logic_vector(width - 1 downto 0); y : out std_logic_vector(width - 1 downto 0));
	end component;
	
	component alu is
    	port(a, b: in std_logic_vector(width-1 downto 0); alucontrol: in std_logic_vector(2 downto 0); zero: out std_logic; 
			 result: out std_logic_vector(width-1 downto 0));
	end component;

	component regfile is
		port(ra1: in std_logic_vector(4 downto 0); ra2: in std_logic_vector(4 downto 0); wa3: in std_logic_vector(4 downto 0);
     		 rd1: out std_logic_vector(width - 1 downto 0); rd2: out std_logic_vector(width - 1 downto 0);
			 wd3: in std_logic_vector(width - 1 downto 0); clk: in std_logic; we3: in std_logic);
	end component;

	component dmem is
		port(clk, we: in std_logic; a, wd: in std_logic_vector(31 downto 0); rd: out std_logic_vector(31 downto 0); dump: in std_logic);
	end component;

end components;
