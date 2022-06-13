library ieee;
use ieee.std_logic_1164.all;
LIBRARY work;

entity tb_SPECK_128_128 is
end entity tb_SPECK_128_128;

architecture testbench of tb_SPECK_128_128 is

	-- Input signals:
	
	signal in_wr_T : std_logic := '0';
	signal in_wr_K : std_logic := '0';
	SIGNAL in_ext_dec : STD_LOGIC := '0';
	SIGNAL in_ext_enc : STD_LOGIC := '0';
	SIGNAL in_ext_setup : STD_LOGIC := '0';
	
	signal in_K		: std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal in_t		: std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	
	
	-- Output signals:
	
	signal out_text : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal out_ext_neg_state : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal out_busy : std_logic := '0';
	signal out_sth	 : std_logic := '0';

	-- Clock signal:
	
	signal in_clk : std_logic;
	constant clk_period : time := 10 ps;

	-- Other signals:
	COMPONENT PKUC_project IS 
		PORT
		(
			in_clk :  IN  STD_LOGIC;
			in_wr_K :  IN  STD_LOGIC;
			in_wr_T :  IN  STD_LOGIC;
			in_ext_dec :  IN  STD_LOGIC;
			in_ext_enc :  IN  STD_LOGIC;
			in_ext_setup :  IN  STD_LOGIC;
			in_K :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
			in_T :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
			out_busy :  OUT  STD_LOGIC;
			out_ext_neg_state 	:  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0);
			out_text :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
		);
	END COMPONENT;

begin

	SPECK : PKUC_project
		port map(
			in_clk => in_clk,
			in_wr_K => in_wr_K,
			in_wr_T => in_wr_T,
			in_ext_dec => in_ext_dec,
			in_ext_enc => in_ext_enc,
			in_ext_setup => in_ext_setup,
			in_K => in_K,
			in_T => in_T,
			out_busy => out_busy,
			out_ext_neg_state => out_ext_neg_state,
			out_text => out_text
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
		
		in_wr_K <= '1';
		in_wr_T <= '0';
		in_ext_dec <= '0';
		in_ext_enc <= '0';
		in_ext_setup <= '0';
		
		in_T <= x"00000000000000000000000000000000";
		in_K <= x"0f0e0d0c0b0a09080706050403020100";
		
		wait for clk_period;
		
		
		in_wr_K <= '0';
		in_wr_T <= '1';
		in_ext_dec <= '0';
		in_ext_enc <= '0';
		in_ext_setup <= '0';
		
		in_t <= x"6c617669757165207469206564616d20";
		in_K <= x"00000000000000000000000000000000";
		
		wait for clk_period;
		
		
		in_wr_K <= '0';
		in_wr_T <= '0';
		in_ext_dec <= '0';
		in_ext_enc <= '0';
		in_ext_setup <= '1';
		
		in_t <= x"00000000000000000000000000000000";
		in_K <= x"00000000000000000000000000000000";
		
		wait for clk_period;
		
		in_wr_K <= '0';
		in_wr_T <= '0';
		in_ext_dec <= '0';
		in_ext_enc <= '0';
		in_ext_setup <= '0';
		
		in_t <= x"00000000000000000000000000000000";
		in_K <= x"00000000000000000000000000000000";
		
		wait for clk_period * 40;
		
		in_wr_K <= '0';
		in_wr_T <= '0';
		in_ext_dec <= '0';
		in_ext_enc <= '1';
		in_ext_setup <= '0';
		
		in_t <= x"00000000000000000000000000000000";
		in_K <= x"00000000000000000000000000000000";
		
		wait for clk_period;
		
		in_wr_K <= '0';
		in_wr_T <= '0';
		in_ext_dec <= '0';
		in_ext_enc <= '0';
		in_ext_setup <= '0';
		
		in_t <= x"00000000000000000000000000000000";
		in_K <= x"00000000000000000000000000000000";
		
		wait for clk_period * 40;
		
		in_wr_K <= '0';
		in_wr_T <= '1';
		in_ext_dec <= '0';
		in_ext_enc <= '0';
		in_ext_setup <= '0';
		
		in_t <= x"A65D9851797832657860FEDF5C570D18";
		in_K <= x"00000000000000000000000000000000";
		
		wait for clk_period;
		
		in_wr_K <= '0';
		in_wr_T <= '0';
		in_ext_dec <= '1';
		in_ext_enc <= '0';
		in_ext_setup <= '0';
		
		in_t <= x"00000000000000000000000000000000";
		in_K <= x"00000000000000000000000000000000";
		
		wait for clk_period;
		
		in_wr_K <= '0';
		in_wr_T <= '0';
		in_ext_dec <= '0';
		in_ext_enc <= '0';
		in_ext_setup <= '0';
		
		in_t <= x"00000000000000000000000000000000";
		in_K <= x"00000000000000000000000000000000";
		
		wait for clk_period * 40;
		
	end process stimulus;

end architecture testbench;