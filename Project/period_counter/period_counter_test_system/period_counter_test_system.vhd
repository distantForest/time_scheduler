-------------------------------------------------------------------------------
-- Title      : period counter test system
-- Project    : 
-------------------------------------------------------------------------------
-- File       : period_counter_test_system.vhd
-- Author     : Igor Parchakov  <igor@fedora>
-- Company    : AGSTU
-- Created    : 2025-01-24
-- Last update: 2025-01-24
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: A simple NIOS II based system with time scheduler component
-------------------------------------------------------------------------------
-- Copyright (c) 2025 AGSTU
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2025-01-24  1.0      igor	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity period_counter_test_system is
  
  port (
    clock_50 : in std_logic;            -- system clock 50 MHz
    reset_n  : in std_logic);           -- system reset push button

end entity period_counter_test_system;

architecture rtl of period_counter_test_system is

  component period_counter is
    port (
      clk_clk       : in std_logic := '0';
      reset_reset_n : in std_logic := '0');
  end component period_counter;
  
begin  -- architecture rtl

  period_counter_1: period_counter
    port map (
      clk_clk       => clock_50,
      reset_reset_n => reset_n);

end architecture rtl;
