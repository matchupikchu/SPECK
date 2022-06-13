-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
-- CREATED		"Fri Jun 10 22:45:11 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY PKUC_project IS 
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
		out_ext_neg_state :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0);
		out_text :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END PKUC_project;

ARCHITECTURE bdf_type OF PKUC_project IS 

COMPONENT speck_round_dec
	PORT(in_C : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 in_K : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 out_P : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT speck_round
	PORT(in_K : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 in_P : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 out_P : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT state_round_reg
	PORT(in_clk : IN STD_LOGIC;
		 in_wr_state_enc : IN STD_LOGIC;
		 in_wr_state_dec : IN STD_LOGIC;
		 in_wr_round_key : IN STD_LOGIC;
		 in_state_out : IN STD_LOGIC;
		 in_ext_wr_P : IN STD_LOGIC;
		 in_ext_wr_K : IN STD_LOGIC;
		 in_wr_state_to_neg : IN STD_LOGIC;
		 in_ext_K : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 in_ext_P : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 in_int_state : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 in_round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 in_state_dec : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 in_state_enc : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 out_CT : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
		 out_CT_neg : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
		 out_round_key : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
		 out_state : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT speck_control
	PORT(in_clk : IN STD_LOGIC;
		 in_ext_setup : IN STD_LOGIC;
		 in_ext_enc : IN STD_LOGIC;
		 in_ext_dec : IN STD_LOGIC;
		 out_int_PT_wr : OUT STD_LOGIC;
		 out_int_CT_wr : OUT STD_LOGIC;
		 out_int_K_wr : OUT STD_LOGIC;
		 out_int_K_rd : OUT STD_LOGIC;
		 out_ext_state_wr : OUT STD_LOGIC;
		 out_ext_busy : OUT STD_LOGIC;
		 out_wr_dec_to_neg : OUT STD_LOGIC;
		 out_int_round_number : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 out_int_state : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT speck_key_schedule
	PORT(in_counter : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 in_K : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 out_K : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT round_key_mem
	PORT(in_clk : IN STD_LOGIC;
		 in_wr_K : IN STD_LOGIC;
		 in_rd_K : IN STD_LOGIC;
		 in_addr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 in_round_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 out_round_key : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;


BEGIN 



b2v_dec : speck_round_dec
PORT MAP(in_C => SYNTHESIZED_WIRE_19,
		 in_K => SYNTHESIZED_WIRE_20,
		 out_P => SYNTHESIZED_WIRE_11);


b2v_enc : speck_round
PORT MAP(in_K => SYNTHESIZED_WIRE_20,
		 in_P => SYNTHESIZED_WIRE_19,
		 out_P => SYNTHESIZED_WIRE_12);


b2v_inst : state_round_reg
PORT MAP(in_clk => in_clk,
		 in_wr_state_enc => SYNTHESIZED_WIRE_4,
		 in_wr_state_dec => SYNTHESIZED_WIRE_5,
		 in_wr_round_key => SYNTHESIZED_WIRE_21,
		 in_state_out => SYNTHESIZED_WIRE_7,
		 in_ext_wr_P => in_wr_T,
		 in_ext_wr_K => in_wr_K,
		 in_wr_state_to_neg => SYNTHESIZED_WIRE_8,
		 in_ext_K => in_K,
		 in_ext_P => in_T,
		 in_int_state => SYNTHESIZED_WIRE_9,
		 in_round_key => SYNTHESIZED_WIRE_10,
		 in_state_dec => SYNTHESIZED_WIRE_11,
		 in_state_enc => SYNTHESIZED_WIRE_12,
		 out_CT => out_text,
		 out_CT_neg => out_ext_neg_state,
		 out_round_key => SYNTHESIZED_WIRE_23,
		 out_state => SYNTHESIZED_WIRE_19);


b2v_inst2 : speck_control
PORT MAP(in_clk => in_clk,
		 in_ext_setup => in_ext_setup,
		 in_ext_enc => in_ext_enc,
		 in_ext_dec => in_ext_dec,
		 out_int_PT_wr => SYNTHESIZED_WIRE_4,
		 out_int_CT_wr => SYNTHESIZED_WIRE_5,
		 out_int_K_wr => SYNTHESIZED_WIRE_21,
		 out_int_K_rd => SYNTHESIZED_WIRE_16,
		 out_ext_state_wr => SYNTHESIZED_WIRE_7,
		 out_ext_busy => out_busy,
		 out_wr_dec_to_neg => SYNTHESIZED_WIRE_8,
		 out_int_round_number => SYNTHESIZED_WIRE_22,
		 out_int_state => SYNTHESIZED_WIRE_9);


b2v_key_schedule : speck_key_schedule
PORT MAP(in_counter => SYNTHESIZED_WIRE_22,
		 in_K => SYNTHESIZED_WIRE_23,
		 out_K => SYNTHESIZED_WIRE_10);


b2v_round_key_mem : round_key_mem
PORT MAP(in_clk => in_clk,
		 in_wr_K => SYNTHESIZED_WIRE_21,
		 in_rd_K => SYNTHESIZED_WIRE_16,
		 in_addr => SYNTHESIZED_WIRE_22,
		 in_round_key => SYNTHESIZED_WIRE_23,
		 out_round_key => SYNTHESIZED_WIRE_20);


END bdf_type;