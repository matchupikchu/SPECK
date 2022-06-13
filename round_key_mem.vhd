library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity round_key_mem is
  port(
    in_clk  	 	: in  std_logic;
	 in_wr_K			: in  std_logic;
	 in_rd_K			: in  std_logic;
    in_addr			: in  std_logic_vector(7 downto 0);
    in_round_key  : in  std_logic_vector(127 downto 0);
    out_round_key : out std_logic_vector(127 downto 0)
  );
end entity round_key_mem;

architecture logic of round_key_mem is
	
	type memory is array(0 to 31) of std_logic_vector(127 downto 0);
	signal mem : memory;
	
	signal round_key : std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";
	
begin

  process(in_clk) is

  begin
    if rising_edge(in_clk) then
      
		if(in_wr_K = '1')then
		
			case in_addr is
				when x"00" => mem(0) <= in_round_key;
				when x"01" => mem(1) <= in_round_key;
				when x"02" => mem(2) <= in_round_key;
				when x"03" => mem(3) <= in_round_key;
				when x"04" => mem(4) <= in_round_key;
				when x"05" => mem(5) <= in_round_key;
				when x"06" => mem(6) <= in_round_key;
				when x"07" => mem(7) <= in_round_key;
				when x"08" => mem(8) <= in_round_key;
				when x"09" => mem(9) <= in_round_key;
				when x"0a" => mem(10) <= in_round_key;
				when x"0b" => mem(11) <= in_round_key;
				when x"0c" => mem(12) <= in_round_key;
				when x"0d" => mem(13) <= in_round_key;
				when x"0e" => mem(14) <= in_round_key;
				when x"0f" => mem(15) <= in_round_key;
				when x"10" => mem(16) <= in_round_key;
				when x"11" => mem(17) <= in_round_key;
				when x"12" => mem(18) <= in_round_key;
				when x"13" => mem(19) <= in_round_key;
				when x"14" => mem(20) <= in_round_key;
				when x"15" => mem(21) <= in_round_key;
				when x"16" => mem(22) <= in_round_key;
				when x"17" => mem(23) <= in_round_key;
				when x"18" => mem(24) <= in_round_key;
				when x"19" => mem(25) <= in_round_key;
				when x"1a" => mem(26) <= in_round_key;
				when x"1b" => mem(27) <= in_round_key;
				when x"1c" => mem(28) <= in_round_key;
				when x"1d" => mem(29) <= in_round_key;
				when x"1e" => mem(30) <= in_round_key;
				when x"1f" => mem(31) <= in_round_key;
				when others => null;
			end case;
				
      end if;
			
		if(in_rd_K = '1') then
		
			case in_addr is
				when x"00" => round_key <= mem(0);
				when x"01" => round_key <= mem(1);
				when x"02" => round_key <= mem(2);
				when x"03" => round_key <= mem(3);
				when x"04" => round_key <= mem(4);
				when x"05" => round_key <= mem(5);
				when x"06" => round_key <= mem(6);
				when x"07" => round_key <= mem(7);
				when x"08" => round_key <= mem(8);
				when x"09" => round_key <= mem(9);
				when x"0a" => round_key <= mem(10);
				when x"0b" => round_key <= mem(11);
				when x"0c" => round_key <= mem(12);
				when x"0d" => round_key <= mem(13);
				when x"0e" => round_key <= mem(14);
				when x"0f" => round_key <= mem(15);
				when x"10" => round_key <= mem(16);
				when x"11" => round_key <= mem(17);
				when x"12" => round_key <= mem(18);
				when x"13" => round_key <= mem(19);
				when x"14" => round_key <= mem(20);
				when x"15" => round_key <= mem(21);
				when x"16" => round_key <= mem(22);
				when x"17" => round_key <= mem(23);
				when x"18" => round_key <= mem(24);
				when x"19" => round_key <= mem(25);
				when x"1a" => round_key <= mem(26);
				when x"1b" => round_key <= mem(27);
				when x"1c" => round_key <= mem(28);
				when x"1d" => round_key <= mem(29);
				when x"1e" => round_key <= mem(30);
				when x"1f" => round_key <= mem(31);
				when others => round_key <= x"00000000000000000000000000000000";
			end case;
			
		end if;
		
      
    end if;
  end process;
	
	out_round_key <= round_key;

end architecture logic;