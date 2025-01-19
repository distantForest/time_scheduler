-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "01/17/2025 21:25:54"
                                                            
-- Vhdl Test Bench template for design  :  tick_function
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY tick_function_vhd_tst IS
END tick_function_vhd_tst;
ARCHITECTURE tick_function_arch OF tick_function_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL counter_en : STD_LOGIC;
SIGNAL reset_n : STD_LOGIC;
SIGNAL reset_timer : STD_LOGIC;
SIGNAL tick : STD_LOGIC;
SIGNAL timer_data : STD_LOGIC_VECTOR(31 DOWNTO 0);
COMPONENT tick_function
   generic (g_timer_limit : integer);
	PORT (
	clk : IN STD_LOGIC;
	counter_en : IN STD_LOGIC;
	reset_n : IN STD_LOGIC;
	reset_timer : IN STD_LOGIC;
	tick : OUT STD_LOGIC;
	timer_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : tick_function
	generic map (g_timer_limit => 7)
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	counter_en => counter_en,
	reset_n => reset_n,
	reset_timer => reset_timer,
	tick => tick,
	timer_data => timer_data
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once  
    counter_en <= '0';
    reset_n <= '0'; 
    reset_timer <= '1';                   

   wait for 122 ns;
   reset_n <= '1';
   counter_en <= '1';

WAIT;                                                       
END PROCESS init; 
                                          
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;  

clock : process
-- system clock
begin
    clk <= '0';
    wait for 20 ns;
    clk <= '1' ;
    wait for 20 ns;
end process clock;

start_timer : process
begin
   wait;
end process start_timer;

END tick_function_arch;
