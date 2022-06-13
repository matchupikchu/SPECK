library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SPECK_control is
port(
	in_clk 						: in std_logic;
	in_ext_setup 				: in std_logic;
	in_ext_enc					: in std_logic;
	in_ext_dec					: in std_logic;
	out_int_PT_wr				: out std_logic;
	out_int_CT_wr				: out std_logic;
	out_int_K_wr				: out std_logic;
	out_int_K_rd				: out std_logic;
	out_ext_state_wr			: out std_logic;
	out_int_round_number 	: out std_logic_vector(7 downto 0);
	out_ext_busy 				: out std_logic;
	out_int_state				: out std_logic_vector(1 downto 0);
	out_wr_dec_to_neg 		: out std_logic
);

end SPECK_control;

architecture logic of SPECK_control is

	signal state 	: std_logic_vector(1 downto 0) := b"00";
	signal counter : std_logic_vector(7 downto 0) := x"00";
	
begin

process(in_clk)
	begin
		
		if(rising_edge(in_clk)) then
		
			if((state = b"01") and (unsigned(counter) /= 0)) then
				
				if(unsigned(counter) /= 33) then	
					counter <= std_logic_vector(unsigned(counter) + 1);
				else 
					counter <= x"00";
					state <= b"00";
				end if;
				
			end if;
			
			if((state = b"10") and (unsigned(counter) /= 0)) then
				
				if(unsigned(counter) /= 34) then	
					counter <= std_logic_vector(unsigned(counter) + 1);
				else 
					counter <= x"00";
					state <= b"00";
				end if;
				
			end if;
			
			if((state = b"11") and (unsigned(counter) /= 0)) then
				
				if(unsigned(counter) /= 34) then	
					counter <= std_logic_vector(unsigned(counter) + 1);
				else 
					counter <= x"00";
					state <= b"00";
				end if;
				
			end if;
			
			if(in_ext_setup = '1' and state = b"00") then 
				state <= b"01";
				counter <= std_logic_vector(unsigned(counter) + 1);
			end if;
			
			if(in_ext_enc = '1' and state = b"00") then 
				state <= b"10";
				counter <= std_logic_vector(unsigned(counter) + 1);
			end if;
			
			if(in_ext_dec = '1' and state = b"00") then 
				state <= b"11";
				counter <= std_logic_vector(unsigned(counter) + 1);
			end if;
		
		end if;
		
	end process;
	
	out_int_PT_wr			<= '1' when (unsigned(counter) >= 2 and unsigned(counter) < 34) and (state = b"10")  else'0';
	out_int_CT_wr			<= '1' when (unsigned(counter) >= 2 and unsigned(counter) < 34) and (state = b"11")  else '0';
	out_int_K_wr 			<= '1' when (unsigned(counter) >= 1 and unsigned(counter) < 33) and (state = b"01") else '0';
	out_int_K_rd 			<= '1' when (unsigned(counter) >= 1 and unsigned(counter) < 34) and (state = b"10" or state = b"11") else '0';
	out_ext_state_wr 		<= '1' when (unsigned(counter) = 34 and (state = b"10" xor state = b"11")) else '0';
	out_wr_dec_to_neg		<= '1' when (unsigned(counter) = 33 and state = "11") else '0';
	out_int_round_number <= std_logic_vector(unsigned(counter) - 1) when (unsigned(counter) >= 1) and (state = b"01" or state = b"10") 	else
									std_logic_vector(to_unsigned(32, out_int_round_number'length) - unsigned(counter)) when (unsigned(counter) >= 1) and (state = b"11") 			else
									x"ff";
	out_ext_busy 			<= '1' when (unsigned(counter) /= 0 and unsigned(counter) < 33 and state = b"01") or (unsigned(counter) /= 0 and unsigned(counter) < 34 and (state = b"10" or state = b"11")) else '0';
	out_int_state <= state;
end logic;