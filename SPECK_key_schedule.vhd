library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SPECK_key_schedule is
  port (	in_K 			: in std_logic_vector(127 downto 0);
			in_counter 	: in std_logic_vector(7 downto 0);
			out_K 		: out std_logic_vector(127 downto 0)
    );
end SPECK_key_schedule;
 
architecture logic of SPECK_key_schedule is
	
	signal K1 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal K2 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal c  : std_logic_vector(63 downto 0) := x"0000000000000000";
	
	signal X1_1 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_2 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_3 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_4 : std_logic_vector(63 downto 0) := x"0000000000000000";
	
begin
		
		K1 <= in_K(127 downto 64);
		K2 <= in_K(63 downto 0);
		c  <= x"00000000000000" & in_counter;
		
		X1_1 <= K1(7 downto 0) & K1(63 downto 8);
		X1_2 <= std_logic_vector(unsigned(X1_1) + unsigned(K2));
		X1_3 <= X1_2 xor c;
		X1_4 <= X1_3 xor (K2(60 downto 0) & K2(63 downto 61));

	out_K <= X1_3 & X1_4;
		
end logic;