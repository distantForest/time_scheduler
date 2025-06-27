-------------------------------------------------------------------------------
-- Title      : timer function
-- Project    : 
-------------------------------------------------------------------------------
-- File       : timer_function.vhd
-- Author     : Igor Parchakov  <igor@fedora>
-- Company    : AGSTU
-- Created    : 2025-06-24
-- Last update: 2025-06-24
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Counting system clock pulses
-------------------------------------------------------------------------------
-- Copyright (c) 2025 AGSTU
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2025-06-24  1.0      igor	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
-- use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- connects to the registers
entity timer_function is
  port
    (
      Control_timer : in  std_logic_vector(1 downto 0);
      clk           : in  std_logic;
      reset_n       : in  std_logic;
      timer_data    : out std_logic_vector(31 downto 0)
      );
end timer_function;




-- HW_function_process handled the function in timer component
architecture timer_top_rtl of timer_function is
  signal counter, counter_on_clk : unsigned(31 downto 0) := (others => '0');

begin


  process(clk, reset_n)
  begin
    if reset_n = '0' then
      counter <= (others => '0');
    elsif rising_edge(clk) then
      if Control_timer /= "01" then
        if Control_timer = "10" then
          counter <= counter + 1;
        elsif Control_timer = "00" then
          counter <= (others => '0');
        end if;
      end if;
    end if;
  end process;

  
  timer_data <= std_logic_vector(counter);

end timer_top_rtl;
