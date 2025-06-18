-------------------------------------------------------------------------------
-- Title      : Period Counter component
-- Project    : 
-------------------------------------------------------------------------------
-- File       : period_counter.vhd
-- Author     : Igor Parchakov  <igor@fedora>
-- Company    : AGSTU
-- Created    : 2025-06-18
-- Last update: 2025-06-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This component counts ticks in predefined number of counters.
--            : When a counter reaches its limit (period_length) it is reset 
--            : and issuing an IRQ puls of system clock period length.
-------------------------------------------------------------------------------
-- Copyright (c) 2025 AGSTU
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2025-06-18  1.0      igor	Created
-------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pack_period.ALL;

entity period_counter_block is
  generic (
    counter_height   : natural := 4
  );
  port (
    clk            : in  std_logic;
    reset_n        : in  std_logic;
    tick_front     : in  std_logic;
    period_length  : in  counter_array(0 to counter_height - 1);
    tick_ack       : out std_logic;
    p_counter_irq  : out std_logic_vector(counter_height - 1 downto 0)
  );
end entity;

architecture rtl of period_counter_block is
  signal counters :counter_array(0 to counter_height - 1);
begin
  process(clk, reset_n)
  begin
    if reset_n = '0' then
      tick_ack       <= '0';
      counters       <= (others => 0);--(others => '0'));
      p_counter_irq  <= (others => '0');
    elsif rising_edge(clk) then
      tick_ack      <= '0';
      p_counter_irq <= (others => '0');
      if tick_front = '1' then
        tick_ack <= '1';
        for i in 0 to counter_height - 1 loop
          if counters(i) >= period_length(i) then
            counters(i)      <= 0;--(others => '0');
            p_counter_irq(i) <= '1';
          else
            counters(i) <= counters(i) + 1;
          end if;
        end loop;
      end if;
    end if;
  end process;

end architecture;
