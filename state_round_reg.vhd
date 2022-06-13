library ieee;
use ieee.std_logic_1164.all;

entity state_round_reg is
port(
	in_clk 				: in std_logic;
	in_wr_state_enc	: in std_logic;
	in_wr_state_dec	: in std_logic;
	in_wr_round_key	: in std_logic;
	in_state_enc		: in std_logic_vector(127 downto 0);
	in_state_dec		: in std_logic_vector(127 downto 0);
	in_round_key 		: in std_logic_vector(127 downto 0);
	in_state_out		: in std_logic;
	in_ext_P				: in std_logic_vector(127 downto 0);
	in_ext_K				: in std_logic_vector(127 downto 0);
	in_ext_wr_P			: in std_logic;
	in_ext_wr_K			: in std_logic;
	in_int_state		: in std_logic_vector(1 downto 0);
	in_wr_state_to_neg : in std_logic;
	out_state 				: out std_logic_vector(127 downto 0);
	out_round_key 			: out std_logic_vector(127 downto 0);
	out_CT					: out std_logic_vector(127 downto 0);
	out_CT_neg				: out std_logic_vector(127 downto 0)
);
end state_round_reg;

architecture logic of state_round_reg is

	signal state 		: std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal round_key  : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	
	signal neg_state 		: std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	signal neg_round_key  : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";	
	
begin

	process(in_clk) 
	begin
	
		if(rising_edge(in_clk)) then
			
			if(in_ext_wr_P = '1') then
				state <= in_ext_P;
				neg_state <= not(in_ext_P);
			end if;
			
			if(in_ext_wr_K = '1') then
				round_key <= in_ext_K;
				neg_round_key <= not(in_ext_K);
			end if;
			
			if(in_wr_state_enc = '1') then
				state <= in_state_enc;
				neg_state <= not(in_state_enc);
			end if;
			
			if(in_wr_state_dec = '1') then
				state <= in_state_dec;
				neg_state <= not(in_state_dec);
			end if;
			
			if(in_wr_state_to_neg = '1') then
				neg_round_key <= in_state_dec;
				round_key 	  <= not(in_state_dec);
			end if;
			
			if(in_wr_round_key = '1') then
				round_key <= in_round_key;
				neg_round_key <= not(in_round_key);
			end if;
	
		end if;
	
	end process;

	out_state <= state when in_wr_state_enc = '1' xor in_wr_state_dec = '1' else x"00000000000000000000000000000000";
	out_round_key <= round_key when in_wr_round_key = '1' else x"00000000000000000000000000000000";
	
	out_CT <= state when in_state_out = '1' else x"ffffffffffffffffffffffffffffffff";

	out_CT_neg <= neg_state when (in_state_out = '1' and in_int_state = "10") else 
					  neg_round_key when (in_state_out = '1' and in_int_state = "11") else
					  x"ffffffffffffffffffffffffffffffff";
	
end logic;