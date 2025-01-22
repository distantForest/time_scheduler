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

library ieee;
use ieee.std_logic_1164.all;

entity period_controller_vhd_tst is
end period_controller_vhd_tst;
architecture period_controller_arch of period_controller_vhd_tst is
-- constants                                                 
-- signals                                                   
  signal clk        : std_logic;
  signal reset_n    : std_logic;
  signal p0_irq_ack : std_logic;
  signal p0_irq_out : std_logic;
  signal p0         : std_logic;
  signal p1         : std_logic;
  signal p2         : std_logic;
  signal p3         : std_logic;

  signal ack_0, ack_1, ack_2 : std_logic := '0';  -- ack delay

  component period_controller is
    generic (
      counter_heght : integer);
    port (
      clk        : in  std_logic;
      reset_n    : in  std_logic;
      p0_irq_ack : in  std_logic;
      p0_irq_out : out std_logic;
      p0         : out std_logic;
      p1         : out std_logic;
      p2         : out std_logic;
      p3         : out std_logic);
  end component period_controller;
begin
  i1 : period_controller
    generic map (
      counter_heght => 4)
    port map (
      clk        => clk,
      reset_n    => reset_n,
      p0_irq_ack => p0_irq_ack,
      p0_irq_out => p0_irq_out,
      p0         => p0,
      p1         => p1,
      p2         => p2,
      p3         => p3);

  init : process
-- variable declarations                                     
  begin
    -- code that executes only once
    --
    reset_n <= '0';
    --p0_irq_ack <= '0';
    wait for 122 ns;
    reset_n <= '1';

    wait;
  end process init;
  always : process
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
  begin
    -- code executes for every event on sensitivity list  
    wait;
  end process always;

  clock : process
-- system clock
  begin
    clk <= '0';
    wait for 20 ns;
    clk <= '1';
    wait for 20 ns;
  end process clock;

-- irq management
  irq_management : process(reset_n, clk)
  begin
    if reset_n = '0' then
      p0_irq_ack <= '0';
      ack_0      <= '0';
      ack_1      <= '0';
      ack_2      <= '0';
    elsif rising_edge(clk) then
      if p0_irq_out = '1' then
        p0_irq_ack <= '0';
        if p0_irq_ack = '0' then
          if ack_0 = '1' then
            if ack_1 = '1' then
              if ack_2 = '1' then
                ack_0      <= '0';
                ack_1      <= '0';
                ack_2      <= '0';
                p0_irq_ack <= '1';
              else
                ack_2 <= '1';
              end if;
            else
              ack_1 <= '1';
            end if;
          else
            ack_0 <= '1';
          end if;
        end if;
      end if;
    end if;
  end process irq_management;

end period_controller_arch;
