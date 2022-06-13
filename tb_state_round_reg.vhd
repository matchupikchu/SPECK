library ieee;
use ieee.std_logic_1164.all;
LIBRARY work;

entity tb_state_round_reg is
end entity tb_state_round_reg;

architecture testbench of tb_state_round_reg is

	signal TEST : std_logic_vector(63 downto 0) := x"0000000000000000";

	-- Input signals:
	signal in_wr_state 			: std_logic := '0';
	signal in_wr_round_key	 	: std_logic := '0';
	
	
	signal in_state : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal in_neg_state : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal in_round_key : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal in_neg_round_key : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	
	-- Output signals:
	
	signal out_state : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal out_neg_state : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal out_round_key : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal out_neg_round_key : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	
	-- Clock signal:
	
	signal in_clk : std_logic;
	constant clk_period : time := 10 ps;

	-- Other signals:
	
	component state_round_reg is
	port(
		in_clk 				: in std_logic;
		in_wr_state			: in std_logic;
		in_wr_round_key	: in std_logic;
		in_state 			: in std_logic_vector(127 downto 0);
		in_neg_state 		: in std_logic_vector(127 downto 0);
		in_round_key 		: in std_logic_vector(127 downto 0);
		in_neg_round_key 	: in std_logic_vector(127 downto 0);
		out_state 				: out std_logic_vector(127 downto 0);
		out_neg_state 			: out std_logic_vector(127 downto 0);
		out_round_key 			: out std_logic_vector(127 downto 0);
		out_neg_round_key 	: out std_logic_vector(127 downto 0)
	);
	end component;


begin

		reg : state_round_reg 
	port map(
	  in_clk  => in_clk,
	  in_wr_state 	=> in_wr_state,
	  in_wr_round_key 	=> in_wr_round_key,
	  in_state  => in_state,
	  in_neg_state 	=> in_neg_state,
	  in_round_key 	=> in_round_key,
	  in_neg_round_key  => in_neg_round_key,
	  out_state 	=> out_state,
	  out_neg_state 	=> out_neg_state,
	  out_round_key  => out_round_key,
	  out_neg_round_key 	=> out_neg_round_key
	);

		
	clock: process
	begin
		in_clk <= '0';
		wait for clk_period / 2;
		in_clk <= '1';
		wait for clk_period / 2;
	end process clock;
	
	stimulus: process
	begin
		
		in_wr_state		 	<= '1';
		in_wr_round_key 	<= '1';
		in_state 			<= x"fedcba98765432100123456789acbdef";
		in_neg_state 		<= x"4841516518511847471187aaaccddee7";
		in_round_key 		<= x"747714515618121321a212acceeddff4";
		in_neg_round_key	<= x"12352899474742112113212121299961";
		wait for clk_period;


	
	end process stimulus;

end architecture testbench;