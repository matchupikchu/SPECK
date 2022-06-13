library ieee;
use ieee.std_logic_1164.all;
LIBRARY work;

entity tb_SPECK_round is
end entity tb_SPECK_round;

architecture testbench of tb_SPECK_round is

	signal TEST : std_logic_vector(63 downto 0) := x"0000000000000000";

	-- Input signals:
	
	signal in_P : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal in_K : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal in_counter : std_logic_vector(7 downto 0) := x"00";
	
	-- Output signals:
	
	signal out_P : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal out_K : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	
	-- Clock signal:
	
	signal inClk : std_logic;
	constant clk_period : time := 10 ps;

	-- Other signals:
	
	component SPECK_round is
	  port ( in_P 	: in std_logic_vector(127 downto 0);
				in_K 	: in std_logic_vector(127 downto 0);
				out_P : out std_logic_vector(127 downto 0)
		 );
	end component;
	
	component SPECK_key_schedule is
	  port (	in_K 			: in std_logic_vector(127 downto 0);
				in_counter 	: in std_logic_vector(7 downto 0);
				out_K 		: out std_logic_vector(127 downto 0)
		 );
	end component;

begin

		round : SPECK_round 
	port map(
	  in_P  => in_P,
	  in_K 	=> in_K,
	  out_P 	=> out_P
	);
	
		key_schedule : SPECK_key_schedule
	port map(
		in_K => in_K,
		in_counter => in_counter,
		out_K => out_K
	);

		
	clock: process
	begin
		inClk <= '0';
		wait for clk_period / 2;
		inClk <= '1';
		wait for clk_period / 2;
	end process clock;
	
	stimulus: process
	begin
		
		in_P <= x"6c617669757165207469206564616d20";
		in_K <= x"0f0e0d0c0b0a09080706050403020100";
		in_counter <= x"00";
		
		wait for clk_period;


	
	end process stimulus;

end architecture testbench;