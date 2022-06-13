library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SPECK_round_dec is
  port ( in_C 	: in std_logic_vector(127 downto 0);
			in_K 	: in std_logic_vector(127 downto 0);
			out_P : out std_logic_vector(127 downto 0)
    );
end SPECK_round_dec;
 
architecture logic of SPECK_round_dec is

	signal C1 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal C2 : std_logic_vector(63 downto 0) := x"0000000000000000";

	signal K2 : std_logic_vector(63 downto 0) := x"0000000000000000";
	
	
	signal X1_1 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_2 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_3 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_4 : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal X1_5 : std_logic_vector(63 downto 0) := x"0000000000000000";

begin

		C1 <= in_C(127 downto 64);
		C2 <= in_C(63 downto 0);

		K2 <= in_K(63 downto 0);
		
		X1_1 <= C1 xor C2;
		X1_2 <= X1_1(2 downto 0) & X1_1(63 downto 3);
		
		X1_3 <= C1 xor K2;
		X1_4 <= std_logic_vector(unsigned(X1_3) - unsigned(X1_2));
		X1_5 <= X1_4(55 downto 0) & X1_4(63 downto 56);
		
	out_P <= X1_5 & X1_2;
		
end logic;