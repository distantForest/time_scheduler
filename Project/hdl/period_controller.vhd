-------------------------------------------------------------------------------
-- Title      : Period controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : period_controller.vhd
-- Author     : Igor Parchakov  
-- Company    : 
-- Created    : 2025-01-20
-- Last update: 2025-01-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Period controller manages period counter on tick
-- positive front.
-------------------------------------------------------------------------------
-- Copyright (c) 2025 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2025-01-20  1.0      igor    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity period_controller is

  generic (
    counter_heght : integer := 4);      -- number of periodes
  port (
    clk     : in  std_logic;            -- system clock
    reset_n : in  std_logic;            -- system reset
    p0      : out std_logic;            -- period 0 out
    p1      : out std_logic;            -- period 1 out
    p2      : out std_logic;            -- period 2 out
    p3      : out std_logic);           -- period 3 out
end entity period_controller;
architecture count_ticks_rtl of period_controller is

  component tick_function is
    generic (
      g_timer_limit : integer);
    port (
      reset_timer_n : in  std_logic;
      clk           : in  std_logic;
      reset_n       : in  std_logic;
      counter_en    : in  std_logic;
      tick          : out std_logic;
      timer_data    : out std_logic_vector(31 downto 0));
  end component tick_function;

  signal counter_p0                      : integer := 0;
  signal timer_data                      : std_logic_vector(31 downto 0);
  signal tick, tick_front, tick_ack, p0b : std_logic;

begin  -- architecture count_ticks

-------------------------------------------------------------------------------

  -- instance "tick_function_1"
  tick_function_1 : entity work.tick_function
    generic map (
      g_timer_limit => 7)
    port map (
      reset_timer_n => '1',
      clk           => clk,
      reset_n       => reset_n,
      counter_en    => '1',
      tick          => tick,
      timer_data    => timer_data);

  -----------------------------------------------------------------------------

  -- tick positive front extraction
  front_extraction : process (tick, tick_ack, reset_n)
  begin
    if reset_n = '0' then
      tick_front <= '0';
    elsif tick_ack = '1' then
      tick_front <= '0';
    elsif rising_edge(tick) then
      tick_front <= '1';
    end if;
  end process front_extraction;

  -- count ticks
  count_ticks : process (clk, reset_n)
  begin
    if reset_n = '0' then
      tick_ack   <= '0';
      counter_p0 <= 0;
      p0b        <= '1';
    elsif rising_edge(clk) then
      tick_ack <= '0';
      if tick_front = '1' then
        tick_ack <= '1';
        if counter_p0 > 8 then
          counter_p0 <= 0;
          p0b        <= not p0b;
        else
          counter_p0 <= counter_p0 + 1;
        end if;
      else
        tick_ack <= '0';
      end if;
    end if;
  end process count_ticks;

  p0 <= p0b;

end architecture count_ticks_rtl;
