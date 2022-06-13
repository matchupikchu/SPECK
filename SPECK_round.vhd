library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SPECK_round is
  port ( in_P 	: in std_logic_vector(127 downto 0);
			in_K 	: in std_logic_vector(127 downto 0);
			out_P : out std_logic_vector(127 downto 0)
    );
end SPECK_round;
 
architecture logic of SPECK_round is

	signal P1 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal P2 : std_logic_vector(63 downto 0) := x"0000000000000000";
	
	signal K2 : std_logic_vector(63 downto 0) := x"0000000000000000";
	
	
	signal X1_1 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_2 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_3 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_4 : std_logic_vector(63 downto 0) := x"0000000000000000";
	
	
begin

		P1 <= in_P(127 downto 64);
		P2 <= in_P(63 downto 0);
		
		K2 <= in_K(63 downto 0);
		
		X1_1 <= P1(7 downto 0) & P1(63 downto 8);
		X1_2 <= std_logic_vector(unsigned(X1_1) + unsigned(P2));
		X1_3 <= K2 xor X1_2;
		X1_4 <= X1_3 xor (P2(60 downto 0) & P2(63 downto 61));

	out_P <= X1_3 & X1_4;
		
end logic;