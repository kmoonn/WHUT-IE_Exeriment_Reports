-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Full Version"

-- DATE "11/03/2022 21:11:07"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	subway IS
    PORT (
	clk : IN std_logic;
	select_start : IN std_logic;
	insert_start : IN std_logic;
	note : IN std_logic_vector(3 DOWNTO 0);
	cancel : IN std_logic;
	ticket_stop : IN std_logic_vector(4 DOWNTO 0);
	ticket_account : IN std_logic_vector(2 DOWNTO 0);
	money_gate : OUT std_logic_vector(1 DOWNTO 0);
	ticket_out : OUT std_logic_vector(4 DOWNTO 0);
	ticket_gate : OUT std_logic;
	change_gate : OUT std_logic
	);
END subway;

-- Design Ports Information
-- money_gate[0]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- money_gate[1]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_out[0]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_out[1]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_out[2]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_out[3]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_out[4]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_gate	=>  Location: PIN_A6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- change_gate	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- note[3]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- note[1]	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- note[2]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- note[0]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- insert_start	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_stop[4]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_stop[2]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_stop[1]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_stop[3]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_stop[0]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_account[0]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_account[1]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ticket_account[2]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cancel	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- select_start	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF subway IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_select_start : std_logic;
SIGNAL ww_insert_start : std_logic;
SIGNAL ww_note : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_cancel : std_logic;
SIGNAL ww_ticket_stop : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_ticket_account : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_money_gate : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_ticket_out : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_ticket_gate : std_logic;
SIGNAL ww_change_gate : std_logic;
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \money_gate[0]~output_o\ : std_logic;
SIGNAL \money_gate[1]~output_o\ : std_logic;
SIGNAL \ticket_out[0]~output_o\ : std_logic;
SIGNAL \ticket_out[1]~output_o\ : std_logic;
SIGNAL \ticket_out[2]~output_o\ : std_logic;
SIGNAL \ticket_out[3]~output_o\ : std_logic;
SIGNAL \ticket_out[4]~output_o\ : std_logic;
SIGNAL \ticket_gate~output_o\ : std_logic;
SIGNAL \change_gate~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \select_start~input_o\ : std_logic;
SIGNAL \sign~0_combout\ : std_logic;
SIGNAL \ticket_account[1]~input_o\ : std_logic;
SIGNAL \ticket_account[2]~input_o\ : std_logic;
SIGNAL \Selector27~0_combout\ : std_logic;
SIGNAL \cancel~input_o\ : std_logic;
SIGNAL \Selector46~0_combout\ : std_logic;
SIGNAL \insert_start~input_o\ : std_logic;
SIGNAL \ticket_account[0]~input_o\ : std_logic;
SIGNAL \Mux13~0_combout\ : std_logic;
SIGNAL \ticket_stop[0]~input_o\ : std_logic;
SIGNAL \ticket_stop[1]~input_o\ : std_logic;
SIGNAL \ticket_stop[2]~input_o\ : std_logic;
SIGNAL \ticket_stop[3]~input_o\ : std_logic;
SIGNAL \LessThan7~0_combout\ : std_logic;
SIGNAL \process_0~0_combout\ : std_logic;
SIGNAL \ticket_stop[4]~input_o\ : std_logic;
SIGNAL \price~0_combout\ : std_logic;
SIGNAL \Selector19~0_combout\ : std_logic;
SIGNAL \type_temp~feeder_combout\ : std_logic;
SIGNAL \type_temp~3_combout\ : std_logic;
SIGNAL \type_temp~q\ : std_logic;
SIGNAL \type_temp~0_combout\ : std_logic;
SIGNAL \type_temp~1_combout\ : std_logic;
SIGNAL \Selector20~0_combout\ : std_logic;
SIGNAL \account_temp~q\ : std_logic;
SIGNAL \Selector48~0_combout\ : std_logic;
SIGNAL \Selector46~1_combout\ : std_logic;
SIGNAL \Selector48~1_combout\ : std_logic;
SIGNAL \Selector46~2_combout\ : std_logic;
SIGNAL \state.select_state~q\ : std_logic;
SIGNAL \number[0]~1_combout\ : std_logic;
SIGNAL \number[0]~0_combout\ : std_logic;
SIGNAL \number[0]~2_combout\ : std_logic;
SIGNAL \number[2]~3_combout\ : std_logic;
SIGNAL \Selector28~0_combout\ : std_logic;
SIGNAL \~GND~combout\ : std_logic;
SIGNAL \change~12_combout\ : std_logic;
SIGNAL \change[1]~22_combout\ : std_logic;
SIGNAL \Add9~0_combout\ : std_logic;
SIGNAL \price~1_combout\ : std_logic;
SIGNAL \LessThan4~0_combout\ : std_logic;
SIGNAL \price~5_combout\ : std_logic;
SIGNAL \price~6_combout\ : std_logic;
SIGNAL \Selector25~0_combout\ : std_logic;
SIGNAL \note[1]~input_o\ : std_logic;
SIGNAL \note[0]~input_o\ : std_logic;
SIGNAL \note[3]~input_o\ : std_logic;
SIGNAL \note[2]~input_o\ : std_logic;
SIGNAL \Mux18~0_combout\ : std_logic;
SIGNAL \Add2~0_combout\ : std_logic;
SIGNAL \Selector38~0_combout\ : std_logic;
SIGNAL \total_insert[2]~0_combout\ : std_logic;
SIGNAL \Add7~0_combout\ : std_logic;
SIGNAL \Add6~0_combout\ : std_logic;
SIGNAL \Add5~0_combout\ : std_logic;
SIGNAL \change~6_combout\ : std_logic;
SIGNAL \change~7_combout\ : std_logic;
SIGNAL \change~8_combout\ : std_logic;
SIGNAL \change~9_combout\ : std_logic;
SIGNAL \change[0]~24_combout\ : std_logic;
SIGNAL \change[0]~25_combout\ : std_logic;
SIGNAL \change[0]~26_combout\ : std_logic;
SIGNAL \change[4]~19_combout\ : std_logic;
SIGNAL \change[2]~20_combout\ : std_logic;
SIGNAL \Add9~1\ : std_logic;
SIGNAL \Add9~2_combout\ : std_logic;
SIGNAL \type_temp~2_combout\ : std_logic;
SIGNAL \price~2_combout\ : std_logic;
SIGNAL \price~3_combout\ : std_logic;
SIGNAL \Selector24~0_combout\ : std_logic;
SIGNAL \Mux14~1_combout\ : std_logic;
SIGNAL \Add2~1\ : std_logic;
SIGNAL \Add2~2_combout\ : std_logic;
SIGNAL \Mux17~0_combout\ : std_logic;
SIGNAL \Selector37~0_combout\ : std_logic;
SIGNAL \Add7~1\ : std_logic;
SIGNAL \Add7~2_combout\ : std_logic;
SIGNAL \Add6~1\ : std_logic;
SIGNAL \Add6~2_combout\ : std_logic;
SIGNAL \Add5~1\ : std_logic;
SIGNAL \Add5~2_combout\ : std_logic;
SIGNAL \change~17_combout\ : std_logic;
SIGNAL \change~18_combout\ : std_logic;
SIGNAL \change[1]~27_combout\ : std_logic;
SIGNAL \change[1]~28_combout\ : std_logic;
SIGNAL \Add9~3\ : std_logic;
SIGNAL \Add9~4_combout\ : std_logic;
SIGNAL \change[2]~29_combout\ : std_logic;
SIGNAL \price~4_combout\ : std_logic;
SIGNAL \Selector23~0_combout\ : std_logic;
SIGNAL \Add2~3\ : std_logic;
SIGNAL \Add2~4_combout\ : std_logic;
SIGNAL \Mux16~0_combout\ : std_logic;
SIGNAL \Selector36~0_combout\ : std_logic;
SIGNAL \Add7~3\ : std_logic;
SIGNAL \Add7~4_combout\ : std_logic;
SIGNAL \Add6~3\ : std_logic;
SIGNAL \Add6~4_combout\ : std_logic;
SIGNAL \change~10_combout\ : std_logic;
SIGNAL \Add5~3\ : std_logic;
SIGNAL \Add5~4_combout\ : std_logic;
SIGNAL \Add4~1_cout\ : std_logic;
SIGNAL \Add4~3_cout\ : std_logic;
SIGNAL \Add4~4_combout\ : std_logic;
SIGNAL \change~11_combout\ : std_logic;
SIGNAL \change[2]~32_combout\ : std_logic;
SIGNAL \Mux15~0_combout\ : std_logic;
SIGNAL \Add2~5\ : std_logic;
SIGNAL \Add2~6_combout\ : std_logic;
SIGNAL \Mux15~1_combout\ : std_logic;
SIGNAL \Selector35~0_combout\ : std_logic;
SIGNAL \Add7~5\ : std_logic;
SIGNAL \Add7~6_combout\ : std_logic;
SIGNAL \Add6~5\ : std_logic;
SIGNAL \Add6~6_combout\ : std_logic;
SIGNAL \Add5~5\ : std_logic;
SIGNAL \Add5~6_combout\ : std_logic;
SIGNAL \change~13_combout\ : std_logic;
SIGNAL \Add4~5\ : std_logic;
SIGNAL \Add4~6_combout\ : std_logic;
SIGNAL \change~14_combout\ : std_logic;
SIGNAL \Add9~5\ : std_logic;
SIGNAL \Add9~6_combout\ : std_logic;
SIGNAL \change[3]~30_combout\ : std_logic;
SIGNAL \change[3]~33_combout\ : std_logic;
SIGNAL \LessThan10~0_combout\ : std_logic;
SIGNAL \Selector45~8_combout\ : std_logic;
SIGNAL \Selector45~3_combout\ : std_logic;
SIGNAL \Selector45~4_combout\ : std_logic;
SIGNAL \Selector45~5_combout\ : std_logic;
SIGNAL \Selector45~6_combout\ : std_logic;
SIGNAL \LessThan9~0_combout\ : std_logic;
SIGNAL \Add3~0_combout\ : std_logic;
SIGNAL \Add2~7\ : std_logic;
SIGNAL \Add2~8_combout\ : std_logic;
SIGNAL \Mux14~0_combout\ : std_logic;
SIGNAL \Selector34~0_combout\ : std_logic;
SIGNAL \Add7~7\ : std_logic;
SIGNAL \Add7~8_combout\ : std_logic;
SIGNAL \Add6~7\ : std_logic;
SIGNAL \Add6~8_combout\ : std_logic;
SIGNAL \change~15_combout\ : std_logic;
SIGNAL \Add5~7\ : std_logic;
SIGNAL \Add5~8_combout\ : std_logic;
SIGNAL \Add4~7\ : std_logic;
SIGNAL \Add4~8_combout\ : std_logic;
SIGNAL \change~16_combout\ : std_logic;
SIGNAL \LessThan9~1_combout\ : std_logic;
SIGNAL \Selector45~7_combout\ : std_logic;
SIGNAL \state.initialize_state~q\ : std_logic;
SIGNAL \sign~q\ : std_logic;
SIGNAL \Mux8~1_combout\ : std_logic;
SIGNAL \Mux8~0_combout\ : std_logic;
SIGNAL \Mux8~2_combout\ : std_logic;
SIGNAL \Selector29~2_combout\ : std_logic;
SIGNAL \Mux14~2_combout\ : std_logic;
SIGNAL \Selector30~0_combout\ : std_logic;
SIGNAL \Selector30~1_combout\ : std_logic;
SIGNAL \Selector31~0_combout\ : std_logic;
SIGNAL \Selector31~1_combout\ : std_logic;
SIGNAL \Mux16~1_combout\ : std_logic;
SIGNAL \Mux11~1_combout\ : std_logic;
SIGNAL \Mux11~0_combout\ : std_logic;
SIGNAL \Mux11~2_combout\ : std_logic;
SIGNAL \Mux12~0_combout\ : std_logic;
SIGNAL \Mux12~1_combout\ : std_logic;
SIGNAL \LessThan8~0_combout\ : std_logic;
SIGNAL \LessThan8~1_combout\ : std_logic;
SIGNAL \Selector44~2_combout\ : std_logic;
SIGNAL \Selector44~3_combout\ : std_logic;
SIGNAL \temp~0_combout\ : std_logic;
SIGNAL \temp~1_combout\ : std_logic;
SIGNAL \temp~q\ : std_logic;
SIGNAL \Selector48~2_combout\ : std_logic;
SIGNAL \state.ticket_state~q\ : std_logic;
SIGNAL \LessThan10~1_combout\ : std_logic;
SIGNAL \Selector49~0_combout\ : std_logic;
SIGNAL \Selector49~1_combout\ : std_logic;
SIGNAL \Selector49~2_combout\ : std_logic;
SIGNAL \state.change_state~q\ : std_logic;
SIGNAL \change[4]~21_combout\ : std_logic;
SIGNAL \Add9~7\ : std_logic;
SIGNAL \Add9~8_combout\ : std_logic;
SIGNAL \change[4]~23_combout\ : std_logic;
SIGNAL \change[4]~31_combout\ : std_logic;
SIGNAL \Selector45~2_combout\ : std_logic;
SIGNAL \Selector47~0_combout\ : std_logic;
SIGNAL \Selector47~1_combout\ : std_logic;
SIGNAL \state.insert_state~q\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \money_gate[0]~reg0_q\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \money_gate[1]~reg0_q\ : std_logic;
SIGNAL \Selector6~0_combout\ : std_logic;
SIGNAL \ticket_out[0]~0_combout\ : std_logic;
SIGNAL \ticket_out[0]~reg0_q\ : std_logic;
SIGNAL \Selector5~0_combout\ : std_logic;
SIGNAL \ticket_out[1]~reg0_q\ : std_logic;
SIGNAL \Selector4~0_combout\ : std_logic;
SIGNAL \ticket_out[2]~reg0_q\ : std_logic;
SIGNAL \Selector10~0_combout\ : std_logic;
SIGNAL \temp_type[4]~0_combout\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \ticket_out[3]~reg0_q\ : std_logic;
SIGNAL \Selector9~0_combout\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \ticket_out[4]~reg0_q\ : std_logic;
SIGNAL \Selector7~0_combout\ : std_logic;
SIGNAL \ticket_gate~reg0_q\ : std_logic;
SIGNAL \change_gate~0_combout\ : std_logic;
SIGNAL \change_gate~1_combout\ : std_logic;
SIGNAL \change_gate~reg0_q\ : std_logic;
SIGNAL total_price : std_logic_vector(4 DOWNTO 0);
SIGNAL total_insert : std_logic_vector(4 DOWNTO 0);
SIGNAL temp_type : std_logic_vector(4 DOWNTO 0);
SIGNAL price : std_logic_vector(4 DOWNTO 0);
SIGNAL number : std_logic_vector(2 DOWNTO 0);
SIGNAL change : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_sign~q\ : std_logic;
SIGNAL \ALT_INV_number[0]~2_combout\ : std_logic;
SIGNAL \ALT_INV_state.select_state~q\ : std_logic;
SIGNAL \ALT_INV_state.initialize_state~q\ : std_logic;

BEGIN

ww_clk <= clk;
ww_select_start <= select_start;
ww_insert_start <= insert_start;
ww_note <= note;
ww_cancel <= cancel;
ww_ticket_stop <= ticket_stop;
ww_ticket_account <= ticket_account;
money_gate <= ww_money_gate;
ticket_out <= ww_ticket_out;
ticket_gate <= ww_ticket_gate;
change_gate <= ww_change_gate;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);
\ALT_INV_sign~q\ <= NOT \sign~q\;
\ALT_INV_number[0]~2_combout\ <= NOT \number[0]~2_combout\;
\ALT_INV_state.select_state~q\ <= NOT \state.select_state~q\;
\ALT_INV_state.initialize_state~q\ <= NOT \state.initialize_state~q\;

-- Location: IOOBUF_X12_Y31_N2
\money_gate[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \money_gate[0]~reg0_q\,
	devoe => ww_devoe,
	o => \money_gate[0]~output_o\);

-- Location: IOOBUF_X24_Y31_N2
\money_gate[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \money_gate[1]~reg0_q\,
	devoe => ww_devoe,
	o => \money_gate[1]~output_o\);

-- Location: IOOBUF_X12_Y31_N9
\ticket_out[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ticket_out[0]~reg0_q\,
	devoe => ww_devoe,
	o => \ticket_out[0]~output_o\);

-- Location: IOOBUF_X22_Y31_N9
\ticket_out[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ticket_out[1]~reg0_q\,
	devoe => ww_devoe,
	o => \ticket_out[1]~output_o\);

-- Location: IOOBUF_X14_Y31_N2
\ticket_out[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ticket_out[2]~reg0_q\,
	devoe => ww_devoe,
	o => \ticket_out[2]~output_o\);

-- Location: IOOBUF_X26_Y31_N9
\ticket_out[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ticket_out[3]~reg0_q\,
	devoe => ww_devoe,
	o => \ticket_out[3]~output_o\);

-- Location: IOOBUF_X14_Y31_N9
\ticket_out[4]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ticket_out[4]~reg0_q\,
	devoe => ww_devoe,
	o => \ticket_out[4]~output_o\);

-- Location: IOOBUF_X10_Y31_N2
\ticket_gate~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ticket_gate~reg0_q\,
	devoe => ww_devoe,
	o => \ticket_gate~output_o\);

-- Location: IOOBUF_X33_Y25_N2
\change_gate~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \change_gate~reg0_q\,
	devoe => ww_devoe,
	o => \change_gate~output_o\);

-- Location: IOIBUF_X16_Y0_N15
\clk~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G17
\clk~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOIBUF_X20_Y31_N8
\select_start~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_select_start,
	o => \select_start~input_o\);

-- Location: LCCOMB_X24_Y28_N0
\sign~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sign~0_combout\ = (\sign~q\ & !\select_start~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \sign~q\,
	datad => \select_start~input_o\,
	combout => \sign~0_combout\);

-- Location: IOIBUF_X16_Y31_N1
\ticket_account[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ticket_account(1),
	o => \ticket_account[1]~input_o\);

-- Location: IOIBUF_X16_Y31_N8
\ticket_account[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ticket_account(2),
	o => \ticket_account[2]~input_o\);

-- Location: LCCOMB_X25_Y29_N12
\Selector27~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector27~0_combout\ = (\ticket_account[1]~input_o\ & !\ticket_account[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \ticket_account[1]~input_o\,
	datad => \ticket_account[2]~input_o\,
	combout => \Selector27~0_combout\);

-- Location: IOIBUF_X26_Y31_N1
\cancel~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cancel,
	o => \cancel~input_o\);

-- Location: LCCOMB_X20_Y29_N28
\Selector46~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector46~0_combout\ = (!\state.ticket_state~q\ & (((!\cancel~input_o\ & !\temp~q\)) # (!\state.insert_state~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100010011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \cancel~input_o\,
	datab => \state.ticket_state~q\,
	datac => \state.insert_state~q\,
	datad => \temp~q\,
	combout => \Selector46~0_combout\);

-- Location: IOIBUF_X29_Y31_N1
\insert_start~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_insert_start,
	o => \insert_start~input_o\);

-- Location: IOIBUF_X24_Y31_N8
\ticket_account[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ticket_account(0),
	o => \ticket_account[0]~input_o\);

-- Location: LCCOMB_X25_Y29_N2
\Mux13~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux13~0_combout\ = \ticket_account[2]~input_o\ $ (((\ticket_account[1]~input_o\) # (\ticket_account[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_account[2]~input_o\,
	datac => \ticket_account[1]~input_o\,
	datad => \ticket_account[0]~input_o\,
	combout => \Mux13~0_combout\);

-- Location: IOIBUF_X29_Y31_N8
\ticket_stop[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ticket_stop(0),
	o => \ticket_stop[0]~input_o\);

-- Location: IOIBUF_X31_Y31_N1
\ticket_stop[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ticket_stop(1),
	o => \ticket_stop[1]~input_o\);

-- Location: IOIBUF_X31_Y31_N8
\ticket_stop[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ticket_stop(2),
	o => \ticket_stop[2]~input_o\);

-- Location: IOIBUF_X33_Y27_N8
\ticket_stop[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ticket_stop(3),
	o => \ticket_stop[3]~input_o\);

-- Location: LCCOMB_X26_Y29_N22
\LessThan7~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \LessThan7~0_combout\ = (\ticket_stop[3]~input_o\) # ((\ticket_stop[2]~input_o\ & ((\ticket_stop[0]~input_o\) # (\ticket_stop[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_stop[0]~input_o\,
	datab => \ticket_stop[1]~input_o\,
	datac => \ticket_stop[2]~input_o\,
	datad => \ticket_stop[3]~input_o\,
	combout => \LessThan7~0_combout\);

-- Location: LCCOMB_X26_Y29_N0
\process_0~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \process_0~0_combout\ = (\ticket_stop[3]~input_o\) # ((\ticket_stop[1]~input_o\ & ((\ticket_stop[2]~input_o\))) # (!\ticket_stop[1]~input_o\ & (!\ticket_stop[0]~input_o\ & !\ticket_stop[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_stop[0]~input_o\,
	datab => \ticket_stop[1]~input_o\,
	datac => \ticket_stop[2]~input_o\,
	datad => \ticket_stop[3]~input_o\,
	combout => \process_0~0_combout\);

-- Location: IOIBUF_X33_Y27_N1
\ticket_stop[4]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ticket_stop(4),
	o => \ticket_stop[4]~input_o\);

-- Location: LCCOMB_X26_Y29_N28
\price~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \price~0_combout\ = (!\ticket_stop[3]~input_o\ & ((!\ticket_stop[2]~input_o\) # (!\ticket_stop[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ticket_stop[1]~input_o\,
	datac => \ticket_stop[2]~input_o\,
	datad => \ticket_stop[3]~input_o\,
	combout => \price~0_combout\);

-- Location: LCCOMB_X25_Y29_N30
\Selector19~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector19~0_combout\ = (\state.select_state~q\ & \type_temp~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \state.select_state~q\,
	datad => \type_temp~1_combout\,
	combout => \Selector19~0_combout\);

-- Location: LCCOMB_X25_Y29_N14
\type_temp~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \type_temp~feeder_combout\ = \Selector19~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Selector19~0_combout\,
	combout => \type_temp~feeder_combout\);

-- Location: LCCOMB_X24_Y29_N18
\type_temp~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \type_temp~3_combout\ = (\state.initialize_state~q\ & ((\state.select_state~q\))) # (!\state.initialize_state~q\ & (!\sign~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \sign~q\,
	datac => \state.initialize_state~q\,
	datad => \state.select_state~q\,
	combout => \type_temp~3_combout\);

-- Location: FF_X25_Y29_N15
type_temp : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \type_temp~feeder_combout\,
	ena => \type_temp~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \type_temp~q\);

-- Location: LCCOMB_X26_Y29_N18
\type_temp~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \type_temp~0_combout\ = (\type_temp~q\) # ((!\price~0_combout\ & !\ticket_stop[4]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \price~0_combout\,
	datac => \ticket_stop[4]~input_o\,
	datad => \type_temp~q\,
	combout => \type_temp~0_combout\);

-- Location: LCCOMB_X26_Y29_N4
\type_temp~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \type_temp~1_combout\ = (\type_temp~0_combout\) # ((\ticket_stop[4]~input_o\ & (!\LessThan7~0_combout\)) # (!\ticket_stop[4]~input_o\ & ((!\process_0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101010011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LessThan7~0_combout\,
	datab => \process_0~0_combout\,
	datac => \ticket_stop[4]~input_o\,
	datad => \type_temp~0_combout\,
	combout => \type_temp~1_combout\);

-- Location: LCCOMB_X25_Y29_N8
\Selector20~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector20~0_combout\ = (\state.select_state~q\ & ((\account_temp~q\) # ((\type_temp~1_combout\ & \Mux13~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \type_temp~1_combout\,
	datab => \state.select_state~q\,
	datac => \account_temp~q\,
	datad => \Mux13~0_combout\,
	combout => \Selector20~0_combout\);

-- Location: FF_X25_Y29_N9
account_temp : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector20~0_combout\,
	ena => \type_temp~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \account_temp~q\);

-- Location: LCCOMB_X25_Y29_N24
\Selector48~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector48~0_combout\ = (\insert_start~input_o\ & (\type_temp~1_combout\ & ((\Mux13~0_combout\) # (\account_temp~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \insert_start~input_o\,
	datab => \Mux13~0_combout\,
	datac => \account_temp~q\,
	datad => \type_temp~1_combout\,
	combout => \Selector48~0_combout\);

-- Location: LCCOMB_X19_Y29_N0
\Selector46~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector46~1_combout\ = (\Selector46~0_combout\ & (((!\cancel~input_o\ & !\Selector48~0_combout\)) # (!\state.select_state~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010001001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.select_state~q\,
	datab => \Selector46~0_combout\,
	datac => \cancel~input_o\,
	datad => \Selector48~0_combout\,
	combout => \Selector46~1_combout\);

-- Location: LCCOMB_X20_Y29_N18
\Selector48~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector48~1_combout\ = ((!\state.initialize_state~q\ & (\select_start~input_o\ & \sign~q\))) # (!\Selector46~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.initialize_state~q\,
	datab => \select_start~input_o\,
	datac => \Selector46~1_combout\,
	datad => \sign~q\,
	combout => \Selector48~1_combout\);

-- Location: LCCOMB_X19_Y29_N8
\Selector46~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector46~2_combout\ = (!\Selector45~2_combout\ & ((\Selector48~1_combout\ & (\Selector46~1_combout\)) # (!\Selector48~1_combout\ & ((\state.select_state~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector45~2_combout\,
	datab => \Selector46~1_combout\,
	datac => \state.select_state~q\,
	datad => \Selector48~1_combout\,
	combout => \Selector46~2_combout\);

-- Location: FF_X19_Y29_N9
\state.select_state\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector46~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.select_state~q\);

-- Location: LCCOMB_X25_Y28_N26
\number[0]~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \number[0]~1_combout\ = \ticket_account[2]~input_o\ $ (((!\ticket_account[1]~input_o\ & !\ticket_account[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100111001001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_account[1]~input_o\,
	datab => \ticket_account[2]~input_o\,
	datac => \ticket_account[0]~input_o\,
	combout => \number[0]~1_combout\);

-- Location: LCCOMB_X24_Y28_N24
\number[0]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \number[0]~0_combout\ = (\state.initialize_state~q\) # (\sign~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.initialize_state~q\,
	datad => \sign~q\,
	combout => \number[0]~0_combout\);

-- Location: LCCOMB_X25_Y28_N0
\number[0]~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \number[0]~2_combout\ = (\number[0]~0_combout\ & ((\number[0]~1_combout\) # ((\account_temp~q\) # (!\Selector19~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \number[0]~1_combout\,
	datab => \number[0]~0_combout\,
	datac => \Selector19~0_combout\,
	datad => \account_temp~q\,
	combout => \number[0]~2_combout\);

-- Location: FF_X24_Y29_N21
\number[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \Selector27~0_combout\,
	sclr => \ALT_INV_state.select_state~q\,
	sload => VCC,
	ena => \ALT_INV_number[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => number(1));

-- Location: LCCOMB_X24_Y29_N12
\number[2]~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \number[2]~3_combout\ = (\number[0]~2_combout\ & (((number(2))))) # (!\number[0]~2_combout\ & (\state.select_state~q\ & (\ticket_account[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.select_state~q\,
	datab => \ticket_account[2]~input_o\,
	datac => number(2),
	datad => \number[0]~2_combout\,
	combout => \number[2]~3_combout\);

-- Location: FF_X24_Y29_N13
\number[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \number[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => number(2));

-- Location: LCCOMB_X25_Y29_N4
\Selector28~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector28~0_combout\ = (\ticket_account[0]~input_o\) # (!\ticket_account[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ticket_account[1]~input_o\,
	datad => \ticket_account[0]~input_o\,
	combout => \Selector28~0_combout\);

-- Location: LCCOMB_X25_Y29_N22
\~GND\ : cycloneiv_lcell_comb
-- Equation(s):
-- \~GND~combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~GND~combout\);

-- Location: FF_X25_Y29_N5
\number[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector28~0_combout\,
	asdata => \~GND~combout\,
	sclr => \ALT_INV_state.select_state~q\,
	sload => \ticket_account[2]~input_o\,
	ena => \ALT_INV_number[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => number(0));

-- Location: LCCOMB_X23_Y29_N18
\change~12\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~12_combout\ = number(2) $ (((!number(1) & !number(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010100101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => number(1),
	datac => number(2),
	datad => number(0),
	combout => \change~12_combout\);

-- Location: LCCOMB_X23_Y29_N10
\change[1]~22\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[1]~22_combout\ = (\change[4]~21_combout\) # ((\state.ticket_state~q\ & \change~12_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.ticket_state~q\,
	datab => \change~12_combout\,
	datac => \change[4]~21_combout\,
	combout => \change[1]~22_combout\);

-- Location: LCCOMB_X19_Y29_N16
\Add9~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add9~0_combout\ = change(0) $ (VCC)
-- \Add9~1\ = CARRY(change(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => change(0),
	datad => VCC,
	combout => \Add9~0_combout\,
	cout => \Add9~1\);

-- Location: LCCOMB_X26_Y29_N6
\price~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \price~1_combout\ = (\ticket_stop[4]~input_o\ & (\LessThan7~0_combout\)) # (!\ticket_stop[4]~input_o\ & (((\process_0~0_combout\ & \price~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LessThan7~0_combout\,
	datab => \process_0~0_combout\,
	datac => \ticket_stop[4]~input_o\,
	datad => \price~0_combout\,
	combout => \price~1_combout\);

-- Location: LCCOMB_X26_Y29_N24
\LessThan4~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \LessThan4~0_combout\ = ((!\ticket_stop[2]~input_o\ & ((!\ticket_stop[1]~input_o\) # (!\ticket_stop[0]~input_o\)))) # (!\ticket_stop[3]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_stop[0]~input_o\,
	datab => \ticket_stop[1]~input_o\,
	datac => \ticket_stop[2]~input_o\,
	datad => \ticket_stop[3]~input_o\,
	combout => \LessThan4~0_combout\);

-- Location: LCCOMB_X26_Y29_N30
\price~5\ : cycloneiv_lcell_comb
-- Equation(s):
-- \price~5_combout\ = (\ticket_stop[4]~input_o\) # ((\LessThan4~0_combout\ & \process_0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \LessThan4~0_combout\,
	datac => \ticket_stop[4]~input_o\,
	datad => \process_0~0_combout\,
	combout => \price~5_combout\);

-- Location: LCCOMB_X25_Y29_N20
\price~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \price~6_combout\ = (\price~1_combout\ & (((price(0))))) # (!\price~1_combout\ & ((\type_temp~q\ & ((price(0)))) # (!\type_temp~q\ & (\price~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \price~1_combout\,
	datab => \type_temp~q\,
	datac => \price~5_combout\,
	datad => price(0),
	combout => \price~6_combout\);

-- Location: LCCOMB_X22_Y29_N0
\Selector25~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector25~0_combout\ = (\state.select_state~q\ & \price~6_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.select_state~q\,
	datad => \price~6_combout\,
	combout => \Selector25~0_combout\);

-- Location: FF_X22_Y29_N1
\price[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector25~0_combout\,
	ena => \type_temp~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => price(0));

-- Location: IOIBUF_X33_Y28_N1
\note[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_note(1),
	o => \note[1]~input_o\);

-- Location: IOIBUF_X22_Y31_N1
\note[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_note(0),
	o => \note[0]~input_o\);

-- Location: IOIBUF_X20_Y31_N1
\note[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_note(3),
	o => \note[3]~input_o\);

-- Location: IOIBUF_X33_Y28_N8
\note[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_note(2),
	o => \note[2]~input_o\);

-- Location: LCCOMB_X22_Y28_N28
\Mux18~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux18~0_combout\ = (!\note[1]~input_o\ & (\note[0]~input_o\ & (!\note[3]~input_o\ & !\note[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \note[1]~input_o\,
	datab => \note[0]~input_o\,
	datac => \note[3]~input_o\,
	datad => \note[2]~input_o\,
	combout => \Mux18~0_combout\);

-- Location: LCCOMB_X22_Y28_N10
\Add2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add2~0_combout\ = total_insert(0) $ (VCC)
-- \Add2~1\ = CARRY(total_insert(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => total_insert(0),
	datad => VCC,
	combout => \Add2~0_combout\,
	cout => \Add2~1\);

-- Location: LCCOMB_X23_Y28_N6
\Selector38~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector38~0_combout\ = (\state.insert_state~q\ & ((\Mux18~0_combout\ & ((\Add2~0_combout\))) # (!\Mux18~0_combout\ & (total_insert(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.insert_state~q\,
	datab => \Mux18~0_combout\,
	datac => total_insert(0),
	datad => \Add2~0_combout\,
	combout => \Selector38~0_combout\);

-- Location: LCCOMB_X23_Y28_N30
\total_insert[2]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \total_insert[2]~0_combout\ = (\state.initialize_state~q\ & (\state.insert_state~q\)) # (!\state.initialize_state~q\ & ((!\sign~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.insert_state~q\,
	datac => \sign~q\,
	datad => \state.initialize_state~q\,
	combout => \total_insert[2]~0_combout\);

-- Location: FF_X22_Y29_N13
\total_insert[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \Selector38~0_combout\,
	sload => VCC,
	ena => \total_insert[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_insert(0));

-- Location: LCCOMB_X22_Y29_N12
\Add7~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add7~0_combout\ = (total_insert(0) & ((GND) # (!price(0)))) # (!total_insert(0) & (price(0) $ (GND)))
-- \Add7~1\ = CARRY((total_insert(0)) # (!price(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => total_insert(0),
	datab => price(0),
	datad => VCC,
	combout => \Add7~0_combout\,
	cout => \Add7~1\);

-- Location: LCCOMB_X22_Y29_N22
\Add6~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add6~0_combout\ = (price(0) & (\Add7~0_combout\ $ (VCC))) # (!price(0) & ((\Add7~0_combout\) # (GND)))
-- \Add6~1\ = CARRY((\Add7~0_combout\) # (!price(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011011011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => price(0),
	datab => \Add7~0_combout\,
	datad => VCC,
	combout => \Add6~0_combout\,
	cout => \Add6~1\);

-- Location: LCCOMB_X21_Y29_N20
\Add5~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add5~0_combout\ = (price(0) & (\Add6~0_combout\ $ (VCC))) # (!price(0) & ((\Add6~0_combout\) # (GND)))
-- \Add5~1\ = CARRY((\Add6~0_combout\) # (!price(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011011011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => price(0),
	datab => \Add6~0_combout\,
	datad => VCC,
	combout => \Add5~0_combout\,
	cout => \Add5~1\);

-- Location: LCCOMB_X24_Y29_N14
\change~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~6_combout\ = (!number(2) & number(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => number(2),
	datad => number(1),
	combout => \change~6_combout\);

-- Location: LCCOMB_X23_Y29_N2
\change~7\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~7_combout\ = (number(2)) # ((number(1) & number(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => number(1),
	datac => number(2),
	datad => number(0),
	combout => \change~7_combout\);

-- Location: LCCOMB_X23_Y29_N0
\change~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~8_combout\ = (\change~6_combout\ & (((\change~7_combout\)))) # (!\change~6_combout\ & ((\change~7_combout\ & ((total_insert(0)))) # (!\change~7_combout\ & (\Add7~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add7~0_combout\,
	datab => \change~6_combout\,
	datac => total_insert(0),
	datad => \change~7_combout\,
	combout => \change~8_combout\);

-- Location: LCCOMB_X20_Y29_N14
\change~9\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~9_combout\ = (\change~8_combout\ & ((\Add5~0_combout\) # ((!\change~6_combout\)))) # (!\change~8_combout\ & (((\Add6~0_combout\ & \change~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add5~0_combout\,
	datab => \change~8_combout\,
	datac => \Add6~0_combout\,
	datad => \change~6_combout\,
	combout => \change~9_combout\);

-- Location: LCCOMB_X23_Y29_N26
\change[0]~24\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[0]~24_combout\ = (\state.ticket_state~q\ & (number(2) $ (((number(1)) # (number(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => number(1),
	datab => number(2),
	datac => \state.ticket_state~q\,
	datad => number(0),
	combout => \change[0]~24_combout\);

-- Location: LCCOMB_X19_Y29_N2
\change[0]~25\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[0]~25_combout\ = (\Add9~0_combout\ & ((\state.change_state~q\) # ((\change~9_combout\ & \change[0]~24_combout\)))) # (!\Add9~0_combout\ & (((\change~9_combout\ & \change[0]~24_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add9~0_combout\,
	datab => \state.change_state~q\,
	datac => \change~9_combout\,
	datad => \change[0]~24_combout\,
	combout => \change[0]~25_combout\);

-- Location: LCCOMB_X19_Y29_N26
\change[0]~26\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[0]~26_combout\ = (\change[4]~21_combout\ & (\change[1]~22_combout\ & (change(0)))) # (!\change[4]~21_combout\ & ((\change[0]~25_combout\) # ((\change[1]~22_combout\ & change(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change[4]~21_combout\,
	datab => \change[1]~22_combout\,
	datac => change(0),
	datad => \change[0]~25_combout\,
	combout => \change[0]~26_combout\);

-- Location: FF_X19_Y29_N27
\change[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \change[0]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => change(0));

-- Location: LCCOMB_X24_Y29_N28
\change[4]~19\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[4]~19_combout\ = (\state.select_state~q\) # ((\state.insert_state~q\) # ((!\state.initialize_state~q\ & \sign~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.select_state~q\,
	datab => \state.initialize_state~q\,
	datac => \state.insert_state~q\,
	datad => \sign~q\,
	combout => \change[4]~19_combout\);

-- Location: LCCOMB_X23_Y29_N6
\change[2]~20\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[2]~20_combout\ = (\state.change_state~q\ & (!\change[4]~19_combout\ & ((change(4)) # (\LessThan10~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.change_state~q\,
	datab => change(4),
	datac => \LessThan10~0_combout\,
	datad => \change[4]~19_combout\,
	combout => \change[2]~20_combout\);

-- Location: LCCOMB_X19_Y29_N18
\Add9~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add9~2_combout\ = (change(1) & (\Add9~1\ & VCC)) # (!change(1) & (!\Add9~1\))
-- \Add9~3\ = CARRY((!change(1) & !\Add9~1\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => change(1),
	datad => VCC,
	cin => \Add9~1\,
	combout => \Add9~2_combout\,
	cout => \Add9~3\);

-- Location: LCCOMB_X26_Y29_N20
\type_temp~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \type_temp~2_combout\ = (\ticket_stop[2]~input_o\ & (((\ticket_stop[3]~input_o\) # (!\ticket_stop[1]~input_o\)))) # (!\ticket_stop[2]~input_o\ & (((\ticket_stop[0]~input_o\ & \ticket_stop[1]~input_o\)) # (!\ticket_stop[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_stop[0]~input_o\,
	datab => \ticket_stop[1]~input_o\,
	datac => \ticket_stop[2]~input_o\,
	datad => \ticket_stop[3]~input_o\,
	combout => \type_temp~2_combout\);

-- Location: LCCOMB_X26_Y29_N26
\price~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \price~2_combout\ = (\ticket_stop[4]~input_o\) # ((\type_temp~2_combout\ & \process_0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \type_temp~2_combout\,
	datac => \ticket_stop[4]~input_o\,
	datad => \process_0~0_combout\,
	combout => \price~2_combout\);

-- Location: LCCOMB_X25_Y29_N28
\price~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \price~3_combout\ = (\price~1_combout\ & (((price(1))))) # (!\price~1_combout\ & ((\type_temp~q\ & (price(1))) # (!\type_temp~q\ & ((!\price~2_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \price~1_combout\,
	datab => \type_temp~q\,
	datac => price(1),
	datad => \price~2_combout\,
	combout => \price~3_combout\);

-- Location: LCCOMB_X22_Y29_N4
\Selector24~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector24~0_combout\ = (\state.select_state~q\ & \price~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.select_state~q\,
	datad => \price~3_combout\,
	combout => \Selector24~0_combout\);

-- Location: FF_X22_Y29_N5
\price[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector24~0_combout\,
	ena => \type_temp~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => price(1));

-- Location: LCCOMB_X22_Y28_N30
\Mux14~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux14~1_combout\ = (\note[1]~input_o\) # ((\note[2]~input_o\) # (\note[0]~input_o\ $ (!\note[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \note[1]~input_o\,
	datab => \note[0]~input_o\,
	datac => \note[3]~input_o\,
	datad => \note[2]~input_o\,
	combout => \Mux14~1_combout\);

-- Location: LCCOMB_X22_Y28_N12
\Add2~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add2~2_combout\ = (total_insert(1) & (!\Add2~1\)) # (!total_insert(1) & ((\Add2~1\) # (GND)))
-- \Add2~3\ = CARRY((!\Add2~1\) # (!total_insert(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => total_insert(1),
	datad => VCC,
	cin => \Add2~1\,
	combout => \Add2~2_combout\,
	cout => \Add2~3\);

-- Location: LCCOMB_X22_Y28_N6
\Mux17~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux17~0_combout\ = (\Mux14~1_combout\ & (total_insert(1))) # (!\Mux14~1_combout\ & ((\note[3]~input_o\ & (!total_insert(1))) # (!\note[3]~input_o\ & ((\Add2~2_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001110110011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~1_combout\,
	datab => total_insert(1),
	datac => \note[3]~input_o\,
	datad => \Add2~2_combout\,
	combout => \Mux17~0_combout\);

-- Location: LCCOMB_X22_Y29_N10
\Selector37~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector37~0_combout\ = (\state.insert_state~q\ & \Mux17~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.insert_state~q\,
	datad => \Mux17~0_combout\,
	combout => \Selector37~0_combout\);

-- Location: FF_X22_Y29_N11
\total_insert[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector37~0_combout\,
	ena => \total_insert[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_insert(1));

-- Location: LCCOMB_X22_Y29_N14
\Add7~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add7~2_combout\ = (total_insert(1) & ((price(1) & (!\Add7~1\)) # (!price(1) & (\Add7~1\ & VCC)))) # (!total_insert(1) & ((price(1) & ((\Add7~1\) # (GND))) # (!price(1) & (!\Add7~1\))))
-- \Add7~3\ = CARRY((total_insert(1) & (price(1) & !\Add7~1\)) # (!total_insert(1) & ((price(1)) # (!\Add7~1\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100101001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => total_insert(1),
	datab => price(1),
	datad => VCC,
	cin => \Add7~1\,
	combout => \Add7~2_combout\,
	cout => \Add7~3\);

-- Location: LCCOMB_X22_Y29_N24
\Add6~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add6~2_combout\ = (price(1) & ((\Add7~2_combout\ & (!\Add6~1\)) # (!\Add7~2_combout\ & ((\Add6~1\) # (GND))))) # (!price(1) & ((\Add7~2_combout\ & (\Add6~1\ & VCC)) # (!\Add7~2_combout\ & (!\Add6~1\))))
-- \Add6~3\ = CARRY((price(1) & ((!\Add6~1\) # (!\Add7~2_combout\))) # (!price(1) & (!\Add7~2_combout\ & !\Add6~1\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => price(1),
	datab => \Add7~2_combout\,
	datad => VCC,
	cin => \Add6~1\,
	combout => \Add6~2_combout\,
	cout => \Add6~3\);

-- Location: LCCOMB_X21_Y29_N22
\Add5~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add5~2_combout\ = (price(1) & ((\Add6~2_combout\ & (!\Add5~1\)) # (!\Add6~2_combout\ & ((\Add5~1\) # (GND))))) # (!price(1) & ((\Add6~2_combout\ & (\Add5~1\ & VCC)) # (!\Add6~2_combout\ & (!\Add5~1\))))
-- \Add5~3\ = CARRY((price(1) & ((!\Add5~1\) # (!\Add6~2_combout\))) # (!price(1) & (!\Add6~2_combout\ & !\Add5~1\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => price(1),
	datab => \Add6~2_combout\,
	datad => VCC,
	cin => \Add5~1\,
	combout => \Add5~2_combout\,
	cout => \Add5~3\);

-- Location: LCCOMB_X23_Y29_N16
\change~17\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~17_combout\ = (\change~7_combout\ & (((\change~6_combout\)))) # (!\change~7_combout\ & ((\change~6_combout\ & ((\Add6~2_combout\))) # (!\change~6_combout\ & (\Add7~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add7~2_combout\,
	datab => \change~7_combout\,
	datac => \change~6_combout\,
	datad => \Add6~2_combout\,
	combout => \change~17_combout\);

-- Location: LCCOMB_X20_Y29_N16
\change~18\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~18_combout\ = (\change~7_combout\ & ((\change~17_combout\ & (\Add5~2_combout\)) # (!\change~17_combout\ & ((total_insert(1)))))) # (!\change~7_combout\ & (((\change~17_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change~7_combout\,
	datab => \Add5~2_combout\,
	datac => total_insert(1),
	datad => \change~17_combout\,
	combout => \change~18_combout\);

-- Location: LCCOMB_X19_Y29_N6
\change[1]~27\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[1]~27_combout\ = (\Add9~2_combout\ & ((\state.change_state~q\) # ((\change[0]~24_combout\ & \change~18_combout\)))) # (!\Add9~2_combout\ & (\change[0]~24_combout\ & ((\change~18_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add9~2_combout\,
	datab => \change[0]~24_combout\,
	datac => \state.change_state~q\,
	datad => \change~18_combout\,
	combout => \change[1]~27_combout\);

-- Location: LCCOMB_X19_Y29_N12
\change[1]~28\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[1]~28_combout\ = (\change[4]~21_combout\ & (\change[1]~22_combout\ & (change(1)))) # (!\change[4]~21_combout\ & ((\change[1]~27_combout\) # ((\change[1]~22_combout\ & change(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change[4]~21_combout\,
	datab => \change[1]~22_combout\,
	datac => change(1),
	datad => \change[1]~27_combout\,
	combout => \change[1]~28_combout\);

-- Location: FF_X19_Y29_N13
\change[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \change[1]~28_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => change(1));

-- Location: LCCOMB_X19_Y29_N20
\Add9~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add9~4_combout\ = (change(2) & (\Add9~3\ $ (GND))) # (!change(2) & (!\Add9~3\ & VCC))
-- \Add9~5\ = CARRY((change(2) & !\Add9~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => change(2),
	datad => VCC,
	cin => \Add9~3\,
	combout => \Add9~4_combout\,
	cout => \Add9~5\);

-- Location: LCCOMB_X19_Y29_N4
\change[2]~29\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[2]~29_combout\ = (\change[2]~20_combout\ & ((\Add9~4_combout\) # ((change(2) & \change[1]~22_combout\)))) # (!\change[2]~20_combout\ & (((change(2) & \change[1]~22_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change[2]~20_combout\,
	datab => \Add9~4_combout\,
	datac => change(2),
	datad => \change[1]~22_combout\,
	combout => \change[2]~29_combout\);

-- Location: LCCOMB_X25_Y29_N18
\price~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \price~4_combout\ = (\price~1_combout\ & (((price(2))))) # (!\price~1_combout\ & ((\type_temp~q\ & (price(2))) # (!\type_temp~q\ & ((\price~2_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \price~1_combout\,
	datab => \type_temp~q\,
	datac => price(2),
	datad => \price~2_combout\,
	combout => \price~4_combout\);

-- Location: LCCOMB_X22_Y29_N6
\Selector23~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector23~0_combout\ = (\price~4_combout\ & \state.select_state~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \price~4_combout\,
	datad => \state.select_state~q\,
	combout => \Selector23~0_combout\);

-- Location: FF_X22_Y29_N7
\price[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector23~0_combout\,
	ena => \type_temp~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => price(2));

-- Location: LCCOMB_X22_Y28_N14
\Add2~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add2~4_combout\ = (total_insert(2) & (\Add2~3\ $ (GND))) # (!total_insert(2) & (!\Add2~3\ & VCC))
-- \Add2~5\ = CARRY((total_insert(2) & !\Add2~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => total_insert(2),
	datad => VCC,
	cin => \Add2~3\,
	combout => \Add2~4_combout\,
	cout => \Add2~5\);

-- Location: LCCOMB_X22_Y28_N24
\Mux16~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux16~0_combout\ = (\note[3]~input_o\ & (total_insert(1) $ (((total_insert(2)))))) # (!\note[3]~input_o\ & (((\Add2~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => total_insert(1),
	datab => \note[3]~input_o\,
	datac => \Add2~4_combout\,
	datad => total_insert(2),
	combout => \Mux16~0_combout\);

-- Location: LCCOMB_X22_Y29_N8
\Selector36~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector36~0_combout\ = (\state.insert_state~q\ & ((\Mux14~1_combout\ & ((total_insert(2)))) # (!\Mux14~1_combout\ & (\Mux16~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux16~0_combout\,
	datab => \state.insert_state~q\,
	datac => total_insert(2),
	datad => \Mux14~1_combout\,
	combout => \Selector36~0_combout\);

-- Location: FF_X22_Y29_N9
\total_insert[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector36~0_combout\,
	ena => \total_insert[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_insert(2));

-- Location: LCCOMB_X22_Y29_N16
\Add7~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add7~4_combout\ = ((price(2) $ (total_insert(2) $ (\Add7~3\)))) # (GND)
-- \Add7~5\ = CARRY((price(2) & (total_insert(2) & !\Add7~3\)) # (!price(2) & ((total_insert(2)) # (!\Add7~3\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => price(2),
	datab => total_insert(2),
	datad => VCC,
	cin => \Add7~3\,
	combout => \Add7~4_combout\,
	cout => \Add7~5\);

-- Location: LCCOMB_X22_Y29_N26
\Add6~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add6~4_combout\ = ((price(2) $ (\Add7~4_combout\ $ (\Add6~3\)))) # (GND)
-- \Add6~5\ = CARRY((price(2) & (\Add7~4_combout\ & !\Add6~3\)) # (!price(2) & ((\Add7~4_combout\) # (!\Add6~3\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => price(2),
	datab => \Add7~4_combout\,
	datad => VCC,
	cin => \Add6~3\,
	combout => \Add6~4_combout\,
	cout => \Add6~5\);

-- Location: LCCOMB_X22_Y29_N2
\change~10\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~10_combout\ = (\change~7_combout\ & (((\change~6_combout\)))) # (!\change~7_combout\ & ((\change~6_combout\ & (\Add6~4_combout\)) # (!\change~6_combout\ & ((\Add7~4_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add6~4_combout\,
	datab => \Add7~4_combout\,
	datac => \change~7_combout\,
	datad => \change~6_combout\,
	combout => \change~10_combout\);

-- Location: LCCOMB_X21_Y29_N24
\Add5~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add5~4_combout\ = ((price(2) $ (\Add6~4_combout\ $ (\Add5~3\)))) # (GND)
-- \Add5~5\ = CARRY((price(2) & (\Add6~4_combout\ & !\Add5~3\)) # (!price(2) & ((\Add6~4_combout\) # (!\Add5~3\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => price(2),
	datab => \Add6~4_combout\,
	datad => VCC,
	cin => \Add5~3\,
	combout => \Add5~4_combout\,
	cout => \Add5~5\);

-- Location: LCCOMB_X21_Y29_N10
\Add4~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add4~1_cout\ = CARRY((\Add5~0_combout\) # (!price(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add5~0_combout\,
	datab => price(0),
	datad => VCC,
	cout => \Add4~1_cout\);

-- Location: LCCOMB_X21_Y29_N12
\Add4~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add4~3_cout\ = CARRY((\Add5~2_combout\ & (price(1) & !\Add4~1_cout\)) # (!\Add5~2_combout\ & ((price(1)) # (!\Add4~1_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add5~2_combout\,
	datab => price(1),
	datad => VCC,
	cin => \Add4~1_cout\,
	cout => \Add4~3_cout\);

-- Location: LCCOMB_X21_Y29_N14
\Add4~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add4~4_combout\ = ((price(2) $ (\Add5~4_combout\ $ (\Add4~3_cout\)))) # (GND)
-- \Add4~5\ = CARRY((price(2) & (\Add5~4_combout\ & !\Add4~3_cout\)) # (!price(2) & ((\Add5~4_combout\) # (!\Add4~3_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => price(2),
	datab => \Add5~4_combout\,
	datad => VCC,
	cin => \Add4~3_cout\,
	combout => \Add4~4_combout\,
	cout => \Add4~5\);

-- Location: LCCOMB_X21_Y29_N30
\change~11\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~11_combout\ = (\change~10_combout\ & (((\Add5~4_combout\)) # (!\change~7_combout\))) # (!\change~10_combout\ & (\change~7_combout\ & (\Add4~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change~10_combout\,
	datab => \change~7_combout\,
	datac => \Add4~4_combout\,
	datad => \Add5~4_combout\,
	combout => \change~11_combout\);

-- Location: LCCOMB_X20_Y29_N12
\change[2]~32\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[2]~32_combout\ = (\change[2]~29_combout\) # ((!\change[4]~21_combout\ & (\change[0]~24_combout\ & \change~11_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change[4]~21_combout\,
	datab => \change[2]~29_combout\,
	datac => \change[0]~24_combout\,
	datad => \change~11_combout\,
	combout => \change[2]~32_combout\);

-- Location: FF_X20_Y29_N13
\change[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \change[2]~32_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => change(2));

-- Location: LCCOMB_X22_Y28_N20
\Mux15~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux15~0_combout\ = total_insert(3) $ (((!\Mux14~1_combout\ & (total_insert(1) & total_insert(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~1_combout\,
	datab => total_insert(3),
	datac => total_insert(1),
	datad => total_insert(2),
	combout => \Mux15~0_combout\);

-- Location: LCCOMB_X22_Y28_N16
\Add2~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add2~6_combout\ = (total_insert(3) & (!\Add2~5\)) # (!total_insert(3) & ((\Add2~5\) # (GND)))
-- \Add2~7\ = CARRY((!\Add2~5\) # (!total_insert(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => total_insert(3),
	datad => VCC,
	cin => \Add2~5\,
	combout => \Add2~6_combout\,
	cout => \Add2~7\);

-- Location: LCCOMB_X22_Y28_N2
\Mux15~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux15~1_combout\ = (\Mux14~1_combout\ & (\Mux15~0_combout\)) # (!\Mux14~1_combout\ & ((\note[3]~input_o\ & (!\Mux15~0_combout\)) # (!\note[3]~input_o\ & ((\Add2~6_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001110110011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~1_combout\,
	datab => \Mux15~0_combout\,
	datac => \note[3]~input_o\,
	datad => \Add2~6_combout\,
	combout => \Mux15~1_combout\);

-- Location: LCCOMB_X23_Y28_N4
\Selector35~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector35~0_combout\ = (\state.insert_state~q\ & \Mux15~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.insert_state~q\,
	datad => \Mux15~1_combout\,
	combout => \Selector35~0_combout\);

-- Location: FF_X22_Y29_N19
\total_insert[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \Selector35~0_combout\,
	sload => VCC,
	ena => \total_insert[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_insert(3));

-- Location: LCCOMB_X22_Y29_N18
\Add7~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add7~6_combout\ = (total_insert(3) & (\Add7~5\ & VCC)) # (!total_insert(3) & (!\Add7~5\))
-- \Add7~7\ = CARRY((!total_insert(3) & !\Add7~5\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => total_insert(3),
	datad => VCC,
	cin => \Add7~5\,
	combout => \Add7~6_combout\,
	cout => \Add7~7\);

-- Location: LCCOMB_X22_Y29_N28
\Add6~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add6~6_combout\ = (\Add7~6_combout\ & (\Add6~5\ & VCC)) # (!\Add7~6_combout\ & (!\Add6~5\))
-- \Add6~7\ = CARRY((!\Add7~6_combout\ & !\Add6~5\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \Add7~6_combout\,
	datad => VCC,
	cin => \Add6~5\,
	combout => \Add6~6_combout\,
	cout => \Add6~7\);

-- Location: LCCOMB_X21_Y29_N26
\Add5~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add5~6_combout\ = (\Add6~6_combout\ & (\Add5~5\ & VCC)) # (!\Add6~6_combout\ & (!\Add5~5\))
-- \Add5~7\ = CARRY((!\Add6~6_combout\ & !\Add5~5\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \Add6~6_combout\,
	datad => VCC,
	cin => \Add5~5\,
	combout => \Add5~6_combout\,
	cout => \Add5~7\);

-- Location: LCCOMB_X23_Y29_N8
\change~13\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~13_combout\ = (\change~7_combout\ & (((\change~6_combout\)))) # (!\change~7_combout\ & ((\change~6_combout\ & ((\Add6~6_combout\))) # (!\change~6_combout\ & (\Add7~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add7~6_combout\,
	datab => \change~7_combout\,
	datac => \change~6_combout\,
	datad => \Add6~6_combout\,
	combout => \change~13_combout\);

-- Location: LCCOMB_X21_Y29_N16
\Add4~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add4~6_combout\ = (\Add5~6_combout\ & (\Add4~5\ & VCC)) # (!\Add5~6_combout\ & (!\Add4~5\))
-- \Add4~7\ = CARRY((!\Add5~6_combout\ & !\Add4~5\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add5~6_combout\,
	datad => VCC,
	cin => \Add4~5\,
	combout => \Add4~6_combout\,
	cout => \Add4~7\);

-- Location: LCCOMB_X21_Y29_N0
\change~14\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~14_combout\ = (\change~7_combout\ & ((\change~13_combout\ & (\Add5~6_combout\)) # (!\change~13_combout\ & ((\Add4~6_combout\))))) # (!\change~7_combout\ & (((\change~13_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add5~6_combout\,
	datab => \change~7_combout\,
	datac => \change~13_combout\,
	datad => \Add4~6_combout\,
	combout => \change~14_combout\);

-- Location: LCCOMB_X19_Y29_N22
\Add9~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add9~6_combout\ = (change(3) & (\Add9~5\ & VCC)) # (!change(3) & (!\Add9~5\))
-- \Add9~7\ = CARRY((!change(3) & !\Add9~5\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => change(3),
	datad => VCC,
	cin => \Add9~5\,
	combout => \Add9~6_combout\,
	cout => \Add9~7\);

-- Location: LCCOMB_X19_Y29_N10
\change[3]~30\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[3]~30_combout\ = (change(3) & ((\change[1]~22_combout\) # ((\Add9~6_combout\ & \change[2]~20_combout\)))) # (!change(3) & (\Add9~6_combout\ & ((\change[2]~20_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => change(3),
	datab => \Add9~6_combout\,
	datac => \change[1]~22_combout\,
	datad => \change[2]~20_combout\,
	combout => \change[3]~30_combout\);

-- Location: LCCOMB_X20_Y29_N30
\change[3]~33\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[3]~33_combout\ = (\change[3]~30_combout\) # ((!\change[4]~21_combout\ & (\change~14_combout\ & \change[0]~24_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change[4]~21_combout\,
	datab => \change~14_combout\,
	datac => \change[0]~24_combout\,
	datad => \change[3]~30_combout\,
	combout => \change[3]~33_combout\);

-- Location: FF_X20_Y29_N31
\change[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \change[3]~33_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => change(3));

-- Location: LCCOMB_X19_Y29_N30
\LessThan10~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \LessThan10~0_combout\ = (change(0)) # ((change(2)) # ((change(3)) # (change(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => change(0),
	datab => change(2),
	datac => change(3),
	datad => change(1),
	combout => \LessThan10~0_combout\);

-- Location: LCCOMB_X20_Y29_N22
\Selector45~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector45~8_combout\ = (\change~12_combout\ & (!change(4) & (!\LessThan10~0_combout\))) # (!\change~12_combout\ & (((!\change~18_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => change(4),
	datab => \LessThan10~0_combout\,
	datac => \change~12_combout\,
	datad => \change~18_combout\,
	combout => \Selector45~8_combout\);

-- Location: LCCOMB_X24_Y29_N16
\Selector45~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector45~3_combout\ = (\state.select_state~q\ & (((\cancel~input_o\)))) # (!\state.select_state~q\ & (\select_start~input_o\ & ((\sign~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.select_state~q\,
	datab => \select_start~input_o\,
	datac => \cancel~input_o\,
	datad => \sign~q\,
	combout => \Selector45~3_combout\);

-- Location: LCCOMB_X24_Y29_N22
\Selector45~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector45~4_combout\ = (\Selector45~3_combout\ & (\state.select_state~q\)) # (!\Selector45~3_combout\ & (!\state.initialize_state~q\ & ((!\Selector48~0_combout\) # (!\state.select_state~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100110001011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.select_state~q\,
	datab => \Selector45~3_combout\,
	datac => \state.initialize_state~q\,
	datad => \Selector48~0_combout\,
	combout => \Selector45~4_combout\);

-- Location: LCCOMB_X20_Y29_N26
\Selector45~5\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector45~5_combout\ = (\state.insert_state~q\ & (!\temp~q\ & ((\cancel~input_o\) # (\Selector45~4_combout\)))) # (!\state.insert_state~q\ & (((\Selector45~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \cancel~input_o\,
	datab => \state.insert_state~q\,
	datac => \Selector45~4_combout\,
	datad => \temp~q\,
	combout => \Selector45~5_combout\);

-- Location: LCCOMB_X20_Y29_N4
\Selector45~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector45~6_combout\ = (\Selector45~2_combout\) # ((!\state.ticket_state~q\ & \Selector45~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.ticket_state~q\,
	datac => \Selector45~5_combout\,
	datad => \Selector45~2_combout\,
	combout => \Selector45~6_combout\);

-- Location: LCCOMB_X20_Y29_N8
\LessThan9~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \LessThan9~0_combout\ = (!\change~12_combout\ & ((\change~9_combout\) # (\change~11_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \change~12_combout\,
	datac => \change~9_combout\,
	datad => \change~11_combout\,
	combout => \LessThan9~0_combout\);

-- Location: LCCOMB_X22_Y28_N22
\Add3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add3~0_combout\ = (total_insert(3)) # ((total_insert(1) & total_insert(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => total_insert(3),
	datac => total_insert(1),
	datad => total_insert(2),
	combout => \Add3~0_combout\);

-- Location: LCCOMB_X22_Y28_N18
\Add2~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add2~8_combout\ = \Add2~7\ $ (!total_insert(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => total_insert(4),
	cin => \Add2~7\,
	combout => \Add2~8_combout\);

-- Location: LCCOMB_X22_Y28_N8
\Mux14~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux14~0_combout\ = (\note[3]~input_o\ & (\Add3~0_combout\ $ ((total_insert(4))))) # (!\note[3]~input_o\ & (((\Add2~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110111101100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add3~0_combout\,
	datab => total_insert(4),
	datac => \note[3]~input_o\,
	datad => \Add2~8_combout\,
	combout => \Mux14~0_combout\);

-- Location: LCCOMB_X22_Y28_N0
\Selector34~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector34~0_combout\ = (\state.insert_state~q\ & ((\Mux14~1_combout\ & ((total_insert(4)))) # (!\Mux14~1_combout\ & (\Mux14~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~1_combout\,
	datab => \Mux14~0_combout\,
	datac => total_insert(4),
	datad => \state.insert_state~q\,
	combout => \Selector34~0_combout\);

-- Location: FF_X22_Y28_N1
\total_insert[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector34~0_combout\,
	ena => \total_insert[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_insert(4));

-- Location: LCCOMB_X22_Y29_N20
\Add7~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add7~8_combout\ = \Add7~7\ $ (total_insert(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => total_insert(4),
	cin => \Add7~7\,
	combout => \Add7~8_combout\);

-- Location: LCCOMB_X22_Y29_N30
\Add6~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add6~8_combout\ = \Add6~7\ $ (\Add7~8_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \Add7~8_combout\,
	cin => \Add6~7\,
	combout => \Add6~8_combout\);

-- Location: LCCOMB_X23_Y29_N22
\change~15\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~15_combout\ = (\change~7_combout\ & (((\change~6_combout\)))) # (!\change~7_combout\ & ((\change~6_combout\ & ((\Add6~8_combout\))) # (!\change~6_combout\ & (\Add7~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add7~8_combout\,
	datab => \change~7_combout\,
	datac => \change~6_combout\,
	datad => \Add6~8_combout\,
	combout => \change~15_combout\);

-- Location: LCCOMB_X21_Y29_N28
\Add5~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add5~8_combout\ = \Add5~7\ $ (\Add6~8_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \Add6~8_combout\,
	cin => \Add5~7\,
	combout => \Add5~8_combout\);

-- Location: LCCOMB_X21_Y29_N18
\Add4~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add4~8_combout\ = \Add4~7\ $ (\Add5~8_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \Add5~8_combout\,
	cin => \Add4~7\,
	combout => \Add4~8_combout\);

-- Location: LCCOMB_X21_Y29_N6
\change~16\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change~16_combout\ = (\change~15_combout\ & ((\Add5~8_combout\) # ((!\change~7_combout\)))) # (!\change~15_combout\ & (((\change~7_combout\ & \Add4~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101010001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change~15_combout\,
	datab => \Add5~8_combout\,
	datac => \change~7_combout\,
	datad => \Add4~8_combout\,
	combout => \change~16_combout\);

-- Location: LCCOMB_X20_Y29_N2
\LessThan9~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \LessThan9~1_combout\ = (\LessThan9~0_combout\) # ((!\change~12_combout\ & ((\change~14_combout\) # (\change~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010111110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change~12_combout\,
	datab => \change~14_combout\,
	datac => \LessThan9~0_combout\,
	datad => \change~16_combout\,
	combout => \LessThan9~1_combout\);

-- Location: LCCOMB_X20_Y29_N10
\Selector45~7\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector45~7_combout\ = (!\Selector45~6_combout\ & (((\LessThan9~1_combout\) # (!\state.ticket_state~q\)) # (!\Selector45~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector45~8_combout\,
	datab => \state.ticket_state~q\,
	datac => \Selector45~6_combout\,
	datad => \LessThan9~1_combout\,
	combout => \Selector45~7_combout\);

-- Location: FF_X20_Y29_N11
\state.initialize_state\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector45~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.initialize_state~q\);

-- Location: FF_X24_Y28_N1
sign : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \sign~0_combout\,
	asdata => VCC,
	sload => \ALT_INV_sign~q\,
	ena => \ALT_INV_state.initialize_state~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sign~q\);

-- Location: LCCOMB_X25_Y28_N12
\Mux8~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux8~1_combout\ = (\ticket_account[1]~input_o\ & (!\ticket_account[2]~input_o\ & \ticket_account[0]~input_o\)) # (!\ticket_account[1]~input_o\ & (\ticket_account[2]~input_o\ & !\ticket_account[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010010000100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_account[1]~input_o\,
	datab => \ticket_account[2]~input_o\,
	datac => \ticket_account[0]~input_o\,
	combout => \Mux8~1_combout\);

-- Location: LCCOMB_X25_Y28_N2
\Mux8~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux8~0_combout\ = (\ticket_account[1]~input_o\ & ((\ticket_account[2]~input_o\ & ((total_price(4)))) # (!\ticket_account[2]~input_o\ & (\ticket_account[0]~input_o\)))) # (!\ticket_account[1]~input_o\ & (total_price(4) & (\ticket_account[2]~input_o\ $ 
-- (!\ticket_account[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_account[1]~input_o\,
	datab => \ticket_account[2]~input_o\,
	datac => \ticket_account[0]~input_o\,
	datad => total_price(4),
	combout => \Mux8~0_combout\);

-- Location: LCCOMB_X25_Y28_N8
\Mux8~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux8~2_combout\ = (\Mux8~1_combout\ & (\price~4_combout\ & ((\price~3_combout\) # (!\Mux8~0_combout\)))) # (!\Mux8~1_combout\ & (((\Mux8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux8~1_combout\,
	datab => \price~3_combout\,
	datac => \price~4_combout\,
	datad => \Mux8~0_combout\,
	combout => \Mux8~2_combout\);

-- Location: LCCOMB_X25_Y28_N14
\Selector29~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector29~2_combout\ = (\state.initialize_state~q\ & (((\Selector19~0_combout\ & !\account_temp~q\)))) # (!\state.initialize_state~q\ & (!\sign~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000110110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.initialize_state~q\,
	datab => \sign~q\,
	datac => \Selector19~0_combout\,
	datad => \account_temp~q\,
	combout => \Selector29~2_combout\);

-- Location: FF_X25_Y28_N9
\total_price[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Mux8~2_combout\,
	sclr => \ALT_INV_state.initialize_state~q\,
	ena => \Selector29~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_price(4));

-- Location: LCCOMB_X22_Y28_N4
\Mux14~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux14~2_combout\ = (\Mux14~1_combout\ & (total_insert(4))) # (!\Mux14~1_combout\ & ((\Mux14~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~1_combout\,
	datab => total_insert(4),
	datac => \Mux14~0_combout\,
	combout => \Mux14~2_combout\);

-- Location: LCCOMB_X23_Y28_N28
\Selector30~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector30~0_combout\ = (\price~3_combout\ & (\ticket_account[1]~input_o\ $ (!\ticket_account[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \price~3_combout\,
	datac => \ticket_account[1]~input_o\,
	datad => \ticket_account[0]~input_o\,
	combout => \Selector30~0_combout\);

-- Location: LCCOMB_X23_Y28_N0
\Selector30~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector30~1_combout\ = (\ticket_account[1]~input_o\ & ((\price~4_combout\ & ((!\Selector30~0_combout\))) # (!\price~4_combout\ & (\price~6_combout\ & \Selector30~0_combout\)))) # (!\ticket_account[1]~input_o\ & (((\Selector30~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \price~6_combout\,
	datab => \ticket_account[1]~input_o\,
	datac => \price~4_combout\,
	datad => \Selector30~0_combout\,
	combout => \Selector30~1_combout\);

-- Location: FF_X23_Y28_N1
\total_price[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector30~1_combout\,
	sclr => \ALT_INV_state.select_state~q\,
	ena => \ALT_INV_number[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_price(3));

-- Location: LCCOMB_X23_Y28_N10
\Selector31~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector31~0_combout\ = (\ticket_account[1]~input_o\ & (\price~3_combout\ $ (\price~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \price~3_combout\,
	datac => \ticket_account[1]~input_o\,
	datad => \price~6_combout\,
	combout => \Selector31~0_combout\);

-- Location: LCCOMB_X23_Y28_N22
\Selector31~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector31~1_combout\ = (\ticket_account[0]~input_o\ & (\price~4_combout\ $ (((\Selector31~0_combout\ & !\price~6_combout\))))) # (!\ticket_account[0]~input_o\ & (\Selector31~0_combout\ $ (((\price~6_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000101101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector31~0_combout\,
	datab => \ticket_account[0]~input_o\,
	datac => \price~4_combout\,
	datad => \price~6_combout\,
	combout => \Selector31~1_combout\);

-- Location: FF_X23_Y28_N23
\total_price[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector31~1_combout\,
	sclr => \ALT_INV_state.select_state~q\,
	ena => \ALT_INV_number[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_price(2));

-- Location: LCCOMB_X22_Y28_N26
\Mux16~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux16~1_combout\ = (\Mux14~1_combout\ & (total_insert(2))) # (!\Mux14~1_combout\ & ((\Mux16~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => total_insert(2),
	datac => \Mux14~1_combout\,
	datad => \Mux16~0_combout\,
	combout => \Mux16~1_combout\);

-- Location: LCCOMB_X25_Y28_N22
\Mux11~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux11~1_combout\ = (\ticket_account[1]~input_o\ & (\price~6_combout\ $ (((\price~3_combout\ & \ticket_account[0]~input_o\))))) # (!\ticket_account[1]~input_o\ & (\price~3_combout\ & (\ticket_account[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_account[1]~input_o\,
	datab => \price~3_combout\,
	datac => \ticket_account[0]~input_o\,
	datad => \price~6_combout\,
	combout => \Mux11~1_combout\);

-- Location: LCCOMB_X24_Y28_N14
\Mux11~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux11~0_combout\ = (\ticket_account[0]~input_o\ & (\price~3_combout\ $ (((!\price~6_combout\) # (!\ticket_account[1]~input_o\))))) # (!\ticket_account[0]~input_o\ & (((\ticket_account[1]~input_o\ & !\price~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000001001110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_account[0]~input_o\,
	datab => \price~3_combout\,
	datac => \ticket_account[1]~input_o\,
	datad => \price~6_combout\,
	combout => \Mux11~0_combout\);

-- Location: LCCOMB_X25_Y28_N10
\Mux11~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux11~2_combout\ = (\Mux11~1_combout\ & ((\ticket_account[2]~input_o\ & (total_price(1) & !\Mux11~0_combout\)) # (!\ticket_account[2]~input_o\ & ((total_price(1)) # (!\Mux11~0_combout\))))) # (!\Mux11~1_combout\ & (total_price(1) & 
-- (\ticket_account[2]~input_o\ $ (!\Mux11~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110000010110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux11~1_combout\,
	datab => \ticket_account[2]~input_o\,
	datac => total_price(1),
	datad => \Mux11~0_combout\,
	combout => \Mux11~2_combout\);

-- Location: FF_X25_Y28_N11
\total_price[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Mux11~2_combout\,
	sclr => \ALT_INV_state.initialize_state~q\,
	ena => \Selector29~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_price(1));

-- Location: LCCOMB_X25_Y28_N20
\Mux12~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux12~0_combout\ = (total_price(0) & (\ticket_account[2]~input_o\ $ (((!\ticket_account[1]~input_o\ & !\ticket_account[0]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ticket_account[1]~input_o\,
	datab => \ticket_account[2]~input_o\,
	datac => \ticket_account[0]~input_o\,
	datad => total_price(0),
	combout => \Mux12~0_combout\);

-- Location: LCCOMB_X25_Y28_N24
\Mux12~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Mux12~1_combout\ = (\Mux12~0_combout\) # ((\price~6_combout\ & (!\ticket_account[2]~input_o\ & \ticket_account[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \price~6_combout\,
	datab => \ticket_account[2]~input_o\,
	datac => \ticket_account[0]~input_o\,
	datad => \Mux12~0_combout\,
	combout => \Mux12~1_combout\);

-- Location: FF_X25_Y28_N25
\total_price[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Mux12~1_combout\,
	sclr => \ALT_INV_state.initialize_state~q\,
	ena => \Selector29~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => total_price(0));

-- Location: LCCOMB_X23_Y28_N2
\LessThan8~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \LessThan8~0_combout\ = (total_price(0) & ((\Mux18~0_combout\ & ((!\Add2~0_combout\))) # (!\Mux18~0_combout\ & (!total_insert(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001010001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => total_price(0),
	datab => \Mux18~0_combout\,
	datac => total_insert(0),
	datad => \Add2~0_combout\,
	combout => \LessThan8~0_combout\);

-- Location: LCCOMB_X23_Y28_N16
\LessThan8~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \LessThan8~1_combout\ = (total_price(1) & ((\LessThan8~0_combout\) # (!\Mux17~0_combout\))) # (!total_price(1) & (!\Mux17~0_combout\ & \LessThan8~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => total_price(1),
	datac => \Mux17~0_combout\,
	datad => \LessThan8~0_combout\,
	combout => \LessThan8~1_combout\);

-- Location: LCCOMB_X23_Y28_N26
\Selector44~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector44~2_combout\ = (total_price(2) & ((\LessThan8~1_combout\) # (!\Mux16~1_combout\))) # (!total_price(2) & (!\Mux16~1_combout\ & \LessThan8~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => total_price(2),
	datac => \Mux16~1_combout\,
	datad => \LessThan8~1_combout\,
	combout => \Selector44~2_combout\);

-- Location: LCCOMB_X23_Y28_N20
\Selector44~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector44~3_combout\ = (total_price(3) & ((\Selector44~2_combout\) # (!\Mux15~1_combout\))) # (!total_price(3) & (\Selector44~2_combout\ & !\Mux15~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => total_price(3),
	datac => \Selector44~2_combout\,
	datad => \Mux15~1_combout\,
	combout => \Selector44~3_combout\);

-- Location: LCCOMB_X23_Y28_N24
\temp~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \temp~0_combout\ = (\state.insert_state~q\ & ((total_price(4) & (\Mux14~2_combout\ & !\Selector44~3_combout\)) # (!total_price(4) & ((\Mux14~2_combout\) # (!\Selector44~3_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.insert_state~q\,
	datab => total_price(4),
	datac => \Mux14~2_combout\,
	datad => \Selector44~3_combout\,
	combout => \temp~0_combout\);

-- Location: LCCOMB_X24_Y28_N10
\temp~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \temp~1_combout\ = (\state.initialize_state~q\ & (((\temp~q\) # (\temp~0_combout\)))) # (!\state.initialize_state~q\ & (\sign~q\ & (\temp~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sign~q\,
	datab => \state.initialize_state~q\,
	datac => \temp~q\,
	datad => \temp~0_combout\,
	combout => \temp~1_combout\);

-- Location: FF_X24_Y28_N11
temp : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \temp~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \temp~q\);

-- Location: LCCOMB_X20_Y29_N24
\Selector48~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector48~2_combout\ = (\temp~q\ & (!\Selector45~2_combout\ & (\state.insert_state~q\ & \Selector48~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \temp~q\,
	datab => \Selector45~2_combout\,
	datac => \state.insert_state~q\,
	datad => \Selector48~1_combout\,
	combout => \Selector48~2_combout\);

-- Location: FF_X20_Y29_N25
\state.ticket_state\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector48~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.ticket_state~q\);

-- Location: LCCOMB_X21_Y28_N0
\LessThan10~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \LessThan10~1_combout\ = (change(4)) # (\LessThan10~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => change(4),
	datad => \LessThan10~0_combout\,
	combout => \LessThan10~1_combout\);

-- Location: LCCOMB_X21_Y29_N4
\Selector49~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector49~0_combout\ = (\change~18_combout\) # ((\change~9_combout\) # ((\change~11_combout\) # (\change~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change~18_combout\,
	datab => \change~9_combout\,
	datac => \change~11_combout\,
	datad => \change~14_combout\,
	combout => \Selector49~0_combout\);

-- Location: LCCOMB_X21_Y29_N2
\Selector49~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector49~1_combout\ = (\change~12_combout\ & (\LessThan10~1_combout\)) # (!\change~12_combout\ & (((\Selector49~0_combout\) # (\change~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110111011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change~12_combout\,
	datab => \LessThan10~1_combout\,
	datac => \Selector49~0_combout\,
	datad => \change~16_combout\,
	combout => \Selector49~1_combout\);

-- Location: LCCOMB_X21_Y29_N8
\Selector49~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector49~2_combout\ = (\state.ticket_state~q\ & (\Selector49~1_combout\ & ((\LessThan10~1_combout\) # (!\state.change_state~q\)))) # (!\state.ticket_state~q\ & (\LessThan10~1_combout\ & (\state.change_state~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.ticket_state~q\,
	datab => \LessThan10~1_combout\,
	datac => \state.change_state~q\,
	datad => \Selector49~1_combout\,
	combout => \Selector49~2_combout\);

-- Location: FF_X21_Y29_N9
\state.change_state\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector49~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.change_state~q\);

-- Location: LCCOMB_X23_Y29_N4
\change[4]~21\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[4]~21_combout\ = (\change[4]~19_combout\) # ((\state.change_state~q\ & (!change(4) & !\LessThan10~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.change_state~q\,
	datab => change(4),
	datac => \LessThan10~0_combout\,
	datad => \change[4]~19_combout\,
	combout => \change[4]~21_combout\);

-- Location: LCCOMB_X19_Y29_N24
\Add9~8\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add9~8_combout\ = \Add9~7\ $ (change(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => change(4),
	cin => \Add9~7\,
	combout => \Add9~8_combout\);

-- Location: LCCOMB_X23_Y29_N20
\change[4]~23\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[4]~23_combout\ = (\change[2]~20_combout\ & ((\Add9~8_combout\) # ((change(4) & \change[1]~22_combout\)))) # (!\change[2]~20_combout\ & (((change(4) & \change[1]~22_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change[2]~20_combout\,
	datab => \Add9~8_combout\,
	datac => change(4),
	datad => \change[1]~22_combout\,
	combout => \change[4]~23_combout\);

-- Location: LCCOMB_X20_Y29_N6
\change[4]~31\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change[4]~31_combout\ = (\change[4]~23_combout\) # ((!\change[4]~21_combout\ & (\change[0]~24_combout\ & \change~16_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change[4]~21_combout\,
	datab => \change[4]~23_combout\,
	datac => \change[0]~24_combout\,
	datad => \change~16_combout\,
	combout => \change[4]~31_combout\);

-- Location: FF_X20_Y29_N7
\change[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \change[4]~31_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => change(4));

-- Location: LCCOMB_X20_Y29_N20
\Selector45~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector45~2_combout\ = (!change(4) & (\state.change_state~q\ & !\LessThan10~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => change(4),
	datab => \state.change_state~q\,
	datad => \LessThan10~0_combout\,
	combout => \Selector45~2_combout\);

-- Location: LCCOMB_X19_Y29_N14
\Selector47~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector47~0_combout\ = (\state.select_state~q\ & (!\cancel~input_o\ & \Selector48~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.select_state~q\,
	datac => \cancel~input_o\,
	datad => \Selector48~0_combout\,
	combout => \Selector47~0_combout\);

-- Location: LCCOMB_X19_Y29_N28
\Selector47~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector47~1_combout\ = (!\Selector45~2_combout\ & ((\Selector47~0_combout\) # ((\state.insert_state~q\ & !\Selector48~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010001010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector45~2_combout\,
	datab => \Selector47~0_combout\,
	datac => \state.insert_state~q\,
	datad => \Selector48~1_combout\,
	combout => \Selector47~1_combout\);

-- Location: FF_X19_Y29_N29
\state.insert_state\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector47~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.insert_state~q\);

-- Location: LCCOMB_X20_Y28_N0
\Selector1~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = (\money_gate[0]~reg0_q\ & ((!\temp~q\) # (!\state.insert_state~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.insert_state~q\,
	datac => \money_gate[0]~reg0_q\,
	datad => \temp~q\,
	combout => \Selector1~0_combout\);

-- Location: FF_X20_Y28_N1
\money_gate[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector1~0_combout\,
	asdata => \sign~q\,
	sload => \ALT_INV_state.initialize_state~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \money_gate[0]~reg0_q\);

-- Location: LCCOMB_X24_Y28_N18
\Selector0~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = (\state.insert_state~q\ & (((\money_gate[1]~reg0_q\) # (\temp~q\)))) # (!\state.insert_state~q\ & (\state.initialize_state~q\ & (\money_gate[1]~reg0_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.insert_state~q\,
	datab => \state.initialize_state~q\,
	datac => \money_gate[1]~reg0_q\,
	datad => \temp~q\,
	combout => \Selector0~0_combout\);

-- Location: FF_X24_Y28_N19
\money_gate[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \money_gate[1]~reg0_q\);

-- Location: LCCOMB_X23_Y29_N28
\Selector6~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector6~0_combout\ = (\state.ticket_state~q\ & number(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \state.ticket_state~q\,
	datad => number(0),
	combout => \Selector6~0_combout\);

-- Location: LCCOMB_X24_Y29_N26
\ticket_out[0]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \ticket_out[0]~0_combout\ = (\state.initialize_state~q\ & (\state.ticket_state~q\)) # (!\state.initialize_state~q\ & ((!\sign~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.ticket_state~q\,
	datac => \state.initialize_state~q\,
	datad => \sign~q\,
	combout => \ticket_out[0]~0_combout\);

-- Location: FF_X23_Y29_N29
\ticket_out[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector6~0_combout\,
	ena => \ticket_out[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ticket_out[0]~reg0_q\);

-- Location: LCCOMB_X23_Y29_N14
\Selector5~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector5~0_combout\ = (number(1) & \state.ticket_state~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => number(1),
	datac => \state.ticket_state~q\,
	combout => \Selector5~0_combout\);

-- Location: FF_X23_Y29_N15
\ticket_out[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector5~0_combout\,
	ena => \ticket_out[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ticket_out[1]~reg0_q\);

-- Location: LCCOMB_X23_Y29_N12
\Selector4~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector4~0_combout\ = (number(2) & \state.ticket_state~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => number(2),
	datac => \state.ticket_state~q\,
	combout => \Selector4~0_combout\);

-- Location: FF_X23_Y29_N13
\ticket_out[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector4~0_combout\,
	ena => \ticket_out[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ticket_out[2]~reg0_q\);

-- Location: LCCOMB_X26_Y29_N8
\Selector10~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector10~0_combout\ = (!\process_0~0_combout\ & (!\ticket_stop[4]~input_o\ & \state.select_state~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \process_0~0_combout\,
	datac => \ticket_stop[4]~input_o\,
	datad => \state.select_state~q\,
	combout => \Selector10~0_combout\);

-- Location: LCCOMB_X25_Y29_N6
\temp_type[4]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \temp_type[4]~0_combout\ = ((!\type_temp~q\ & (\state.select_state~q\ & !\price~1_combout\))) # (!\number[0]~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \number[0]~0_combout\,
	datab => \type_temp~q\,
	datac => \state.select_state~q\,
	datad => \price~1_combout\,
	combout => \temp_type[4]~0_combout\);

-- Location: FF_X26_Y29_N9
\temp_type[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector10~0_combout\,
	ena => \temp_type[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => temp_type(3));

-- Location: LCCOMB_X23_Y29_N30
\Selector3~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = (\state.ticket_state~q\ & temp_type(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \state.ticket_state~q\,
	datad => temp_type(3),
	combout => \Selector3~0_combout\);

-- Location: FF_X23_Y29_N31
\ticket_out[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector3~0_combout\,
	ena => \ticket_out[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ticket_out[3]~reg0_q\);

-- Location: LCCOMB_X26_Y29_N10
\Selector9~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector9~0_combout\ = (\state.select_state~q\ & ((\process_0~0_combout\) # (\ticket_stop[4]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \process_0~0_combout\,
	datac => \ticket_stop[4]~input_o\,
	datad => \state.select_state~q\,
	combout => \Selector9~0_combout\);

-- Location: FF_X26_Y29_N11
\temp_type[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector9~0_combout\,
	ena => \temp_type[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => temp_type(4));

-- Location: LCCOMB_X23_Y29_N24
\Selector2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = (temp_type(4) & \state.ticket_state~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => temp_type(4),
	datac => \state.ticket_state~q\,
	combout => \Selector2~0_combout\);

-- Location: FF_X23_Y29_N25
\ticket_out[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector2~0_combout\,
	ena => \ticket_out[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ticket_out[4]~reg0_q\);

-- Location: LCCOMB_X20_Y29_N0
\Selector7~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Selector7~0_combout\ = (\state.initialize_state~q\ & ((\state.ticket_state~q\) # ((\ticket_gate~reg0_q\)))) # (!\state.initialize_state~q\ & (((\ticket_gate~reg0_q\ & \sign~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.initialize_state~q\,
	datab => \state.ticket_state~q\,
	datac => \ticket_gate~reg0_q\,
	datad => \sign~q\,
	combout => \Selector7~0_combout\);

-- Location: FF_X20_Y29_N1
\ticket_gate~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ticket_gate~reg0_q\);

-- Location: LCCOMB_X23_Y28_N12
\change_gate~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change_gate~0_combout\ = (\state.initialize_state~q\ & \state.change_state~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.initialize_state~q\,
	datad => \state.change_state~q\,
	combout => \change_gate~0_combout\);

-- Location: LCCOMB_X24_Y28_N8
\change_gate~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \change_gate~1_combout\ = (\change_gate~0_combout\ & (\LessThan10~1_combout\)) # (!\change_gate~0_combout\ & (((\change_gate~reg0_q\ & \number[0]~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \change_gate~0_combout\,
	datab => \LessThan10~1_combout\,
	datac => \change_gate~reg0_q\,
	datad => \number[0]~0_combout\,
	combout => \change_gate~1_combout\);

-- Location: FF_X24_Y28_N9
\change_gate~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \change_gate~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \change_gate~reg0_q\);

ww_money_gate(0) <= \money_gate[0]~output_o\;

ww_money_gate(1) <= \money_gate[1]~output_o\;

ww_ticket_out(0) <= \ticket_out[0]~output_o\;

ww_ticket_out(1) <= \ticket_out[1]~output_o\;

ww_ticket_out(2) <= \ticket_out[2]~output_o\;

ww_ticket_out(3) <= \ticket_out[3]~output_o\;

ww_ticket_out(4) <= \ticket_out[4]~output_o\;

ww_ticket_gate <= \ticket_gate~output_o\;

ww_change_gate <= \change_gate~output_o\;
END structure;


