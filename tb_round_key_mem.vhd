library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
LIBRARY work;

entity tb_round_key_mem is
end entity tb_round_key_mem;

architecture testbench of tb_round_key_mem is

	signal TEST : std_logic_vector(63 downto 0) := x"0000000000000000";

	-- Input signals:
	
	signal in_wr_K : std_logic := '0';
	signal in_rd_K : std_logic := '0';
	
	signal in_addr		: std_logic_vector(7 downto 0) := x"00";
	signal in_round_key		: std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	
	
	-- Output signals:
	
	signal out_round_key : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	
	-- Clock signal:
	
	signal in_clk : std_logic;
	constant clk_period : time := 10 ps;

	-- Other signals:
	component round_key_mem is
	  port(
		 in_clk  	 	: in  std_logic;
		 in_wr_K			: in  std_logic;
		 in_rd_K			: in  std_logic;
		 in_addr			: in  std_logic_vector(7 downto 0);
		 in_round_key  : in  std_logic_vector(127 downto 0);
		 out_round_key : out std_logic_vector(127 downto 0)
	  );
	end component;

begin

	mem : round_key_mem
		port map(
			in_clk => in_clk,
			in_wr_K => in_wr_K,
			in_rd_K => in_rd_K,
			in_addr => in_addr,
			in_round_key => in_round_key,
			out_round_key => out_round_key
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
		
		
		for i in 0 to 30 loop
		
			in_wr_K <= '1';
			in_rd_K <= '0';
			
			in_addr <= std_logic_vector(to_unsigned(i, in_addr'length));
			in_round_key <= x"ffffffffffffffffffffffffffffffff";
			
			wait for clk_period;
			
		end loop;
		
			in_wr_K <= '1';
			in_rd_K <= '0';
			
			in_addr <= x"1d";
			in_round_key <= x"cccccccccccccccccccccccccccccccc";
			
			wait for clk_period;
			
			in_wr_K <= '1';
			in_rd_K <= '0';
			
			in_addr <= x"1e";
			in_round_key <= x"cccccccccccccccccccccccccccccccc";
			
			wait for clk_period;
		
		for i in 0 to 32 loop
		
			in_wr_K <= '0';
			in_rd_K <= '1';
			
			in_addr <= std_logic_vector(to_unsigned(i, in_addr'length));
			in_round_key <= x"ffffffffffffffffffffffffffffffff";
			
			wait for clk_period;
			
		end loop;
		
		
	end process stimulus;

end architecture testbench;