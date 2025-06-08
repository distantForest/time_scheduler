-------------------------------------------------------------------------------
-- Title      : Period controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : period_controller.vhd
-- Author     : Igor Parchakov  
-- Company    : 
-- Created    : 2025-01-20
-- Last update: 2025-05-11
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;

package pack_period is
function log2ceil(
	arg : natural )
	return natural;
	end package pack_period;
	
package body pack_period is

function log2ceil(arg : natural) return natural is
    variable tmp : positive     := 1;
    variable log : natural      := 0;
begin
    if arg = 1 then return 0; end if;
    while arg > tmp loop
        tmp := tmp * 2;
        log := log + 1;
    end loop;
    return log;
end function;
end package body pack_period;

use work.pack_period.ALL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity period_controller is
  generic (
    counter_height : natural := 4;      -- number of periods
    tick_length    : natural := 25 * 1000 * 1000;   -- tick length
    per0           : natural := 1;
    per1           : natural := 2;
    per2           : natural := 3;
    per3           : natural := 4;
    per4           : natural := 5;
    per5           : natural := 6;
    per6           : natural := 7;
    per7           : natural := 8;
    per8           : natural := 9;
    per9           : natural := 10;
    per10          : natural := 11;
    per11          : natural := 12;
    per12          : natural := 13;
    per13          : natural := 14;
    per14          : natural := 15;
    per15          : natural := 16
  );
  port (
    clk        : in  std_logic;         -- system clock
    reset_n    : in  std_logic;         -- system reset
    p0_irq_out : out std_logic;         -- IRQ output
    cs_n       : in  std_logic;         -- IP component address
    addr       : in  std_logic_vector(log2ceil(counter_height + 4) - 1 downto 0);  -- Using addr_width here
    write_n    : in  std_logic;
    read_n     : in  std_logic;
    din        : in  std_logic_vector(31 downto 0);
    dout       : out std_logic_vector(31 downto 0)
  );
end entity period_controller;

architecture count_ticks_rtl of period_controller is

  component tick_function is
    generic (
      g_timer_limit : natural);
    port (
      reset_timer_n : in  std_logic;
      clk           : in  std_logic;
      reset_n       : in  std_logic;
      counter_en    : in  std_logic;
      tick          : out std_logic;
      timer_data    : out std_logic_vector(31 downto 0));
  end component tick_function;

  component irq_selector is
    generic (
      height : natural                  -- number of input irq lines
      );
    port(
      clk    : in  std_logic
; reset_n    : in  std_logic
                                        -- 
; irq_in_mx  : in  std_logic_vector (height - 1 downto 0)
; ack_in_mx  : in  std_logic_vector (height - 1 downto 0)
; ack_in     : in  std_logic
; p_irq_out  : out std_logic
; vector_out : out natural range 0 to height - 1
      );
  end component irq_selector;

  subtype p_index_range is natural range 0 to counter_height - 1;
  type period_array is array (p_index_range) of natural;      
  type integer_array is array (natural range 0 to 15) of natural;
  signal period_counters : period_array;
  signal period_length   : period_array;
  signal period_index : p_index_range;
  signal p_vector : p_index_range; -- natural range 0 to counter_height - 1;
  
  constant p_irq_enable_reg_addr : natural := 0;
  constant p_irq_ack_reg_addr : natural := 1;
  constant p_irq_vector_reg_addr : natural := 2;
  constant p_irq_cs_reg_addr : natural := 3;
  constant p_limits_addr : natural := 4;
  constant period_init : integer_array := (  -- fill 
-- constants period length
    per0,
    per1,
    per2,
    per3,
    per4,
    per5,
    per6,
    per7,
    per8,
    per9,
    per10,
    per11,
    per12,
    per13,
    per14,
    per15
    );
  signal timer_data                      : std_logic_vector(31 downto 0);
  signal tick, tick_front, tick_ack, p0b : std_logic;
  signal p0_counter_irq, p0_irq          : std_logic                                     := '0';  --IRQ channel 0
  signal p_counter_irq, p_irq, p_irq_ack : std_logic_vector(counter_height - 1 downto 0) := (others => '0');

  signal p_irq_ack_reg        : std_logic_vector(31 downto 0);
  signal p_irq_enable_reg     : std_logic_vector(31 downto 0);
  signal p_irq_vector_reg     : std_logic_vector(31 downto 0);
  signal p_irq_ack_gl         : std_logic;

  signal read_irq_enable_reg : std_logic;
  signal read_irq_vector_reg  : std_logic;
  
  signal write_regs : std_logic;
  
  signal p_counter_run : std_logic := '0';


begin  --architecture count_ticks

  -- instance "tick_function_1"
  tick_function_1 : entity work.tick_function
    generic map (
      g_timer_limit => tick_length)
    port map (
      reset_timer_n => '1',
      clk           => clk,
      reset_n       => reset_n,
      counter_en    => p_counter_run, --'1',
      tick          => tick,
      timer_data    => timer_data);

  irq_selector_1 : irq_selector
    generic map (
      height => counter_height)
    port map (
      clk        => clk,
      reset_n    => reset_n,
      irq_in_mx  => p_irq,
      ack_in_mx  => p_irq_ack,
      ack_in     => p_irq_ack_gl,
      p_irq_out  => p0_irq_out,
      vector_out => p_vector);

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
  
  -- avalon bus write operations
  write_regs <= '1' when cs_n = '0' and write_n = '0'else
                '0';
  write_registers : process (clk, reset_n, write_regs)
  begin
    if reset_n = '0' then
      p_counter_run    <= '0';
      p_irq_enable_reg <= (others => '0');
      for i in period_length'range loop
        period_length(i) <= period_init(i);
      end loop;
      p_irq_ack        <= (others => '0');
      p_irq_vector_reg <= (others => '0');
      p_irq_ack_gl     <= '0';

    elsif rising_edge(clk) then
      p_irq_ack    <= (others => '0');
      p_irq_ack_gl <= '0';
      if write_regs = '1' then
        case to_integer(unsigned(addr)) is

          -- write control status register
          when p_irq_cs_reg_addr =>
            p_counter_run <= din(0);

          -- write period limits
          when p_limits_addr to (p_limits_addr + counter_height) =>
            if p_counter_run = '1' then
              period_length(to_integer(unsigned(addr)) - p_limits_addr) <= to_integer(unsigned(din));
            end if;

          -- write irq enable register
          when p_irq_enable_reg_addr =>
            p_irq_enable_reg <= din;

          -- write irq acknowlege 
          when p_irq_ack_reg_addr =>
            check_ack :
            for i in period_counters'range loop
              if din(i) = '1' then
                p_irq_ack(i) <= '1';  -- give positive pulse one clk in length
              end if;
            end loop check_ack;

          -- write global acknowlege
          when p_irq_vector_reg_addr =>
            p_irq_ack_gl     <= '1';
            p_irq_vector_reg <= din;

          when others =>
            null;
        end case;
      end if;
    end if;
  end process write_registers;
      
  -- count ticks
  count_ticks : process (clk, reset_n)

  begin
    if reset_n = '0' then
      tick_ack        <= '0';
      period_counters <= (others => 0);
      p_counter_irq   <= (others => '0');
    elsif rising_edge(clk) then
      tick_ack      <= '0';
      p_counter_irq <= (others => '0');
      if tick_front = '1' then
        tick_ack <= '1';
        -- update counters
        update_counters :
        for i in period_counters'range loop
          if period_counters(i) = period_length(i) then  --issue irq
            period_counters(i) <= 0;
            p_counter_irq(i)   <= '1';
          else
            period_counters(i) <= period_counters(i) + 1;
          end if;
        end loop update_counters;
      else
        tick_ack <= '0';
      end if;
    end if;

  end process count_ticks;

  -- manage interrupt request
  manage_irq : process(clk, reset_n)

  begin
    if reset_n = '0' then
      p_irq <= (others => '0');
    elsif rising_edge(clk) then
      check_irq :
      for i in period_counters'range loop
        if (p_irq_enable_reg(i) = '1') then
          if (p_counter_irq(i) = '1') then
            p_irq(i) <= '1';
          end if;
          if p_irq_ack(i) = '1' then
            p_irq(i) <= '0';
          end if;
        else
          p_irq(i) <= '0';
        end if;
      end loop check_irq;
    end if;

  end process manage_irq;

  --avalon bus read interface
  read_irq_enable_reg <= '1' when (cs_n = '0' and read_n = '0' and
                                   to_integer(unsigned(addr)) = p_irq_enable_reg_addr) else
                          '0';
  
  read_irq_vector_reg <= '1' when (cs_n = '0' and read_n = '0' and
                                   to_integer(unsigned(addr)) = p_irq_vector_reg_addr) else
                         '0';
  dout <= p_irq_enable_reg when read_irq_enable_reg = '1' else
          std_logic_vector(to_unsigned(p_vector, dout'length)) when read_irq_vector_reg = '1' else
          (others => '0');

end architecture count_ticks_rtl;
