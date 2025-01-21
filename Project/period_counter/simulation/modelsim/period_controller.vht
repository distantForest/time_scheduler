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
-- Generated on "01/21/2025 22:21:01"
                                                            
-- Vhdl Test Bench template for design  :  period_controller
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY period_controller_vhd_tst IS
END period_controller_vhd_tst;
ARCHITECTURE period_controller_arch OF period_controller_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL p0 : STD_LOGIC;
SIGNAL p1 : STD_LOGIC;
SIGNAL p2 : STD_LOGIC;
SIGNAL p3 : STD_LOGIC;
SIGNAL reset_n : STD_LOGIC;
COMPONENT period_controller
	PORT (
	clk : IN STD_LOGIC;
	p0 : OUT STD_LOGIC;
	p1 : OUT STD_LOGIC;
	p2 : OUT STD_LOGIC;
	p3 : OUT STD_LOGIC;
	reset_n : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : period_controller
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	p0 => p0,
	p1 => p1,
	p2 => p2,
	p3 => p3,
	reset_n => reset_n
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once
        --
  reset_n <= '0';
  wait for 122 ns;
  reset_n <= '1';
  
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


END period_controller_arch;
