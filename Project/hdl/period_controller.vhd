-------------------------------------------------------------------------------
-- Title      : Period controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : period_controller.vhd
-- Author     : Igor Parchakov  
-- Company    : 
-- Created    : 2025-01-20
-- Last update: 2025-02-02
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
    counter_heght : integer := 4; -- number of periodes
	 tick_length : integer := 25 * 1000 * 1000; -- tick length
	 -- period_0_length : integer := 4;   -- period 0 
	 per0 : integer := 1;
	 per1 : integer := 2;
	 per2 : integer := 3;
	 per3 : integer := 4;
	 per4 : integer := 5;
	 per5 : integer := 6;
	 per6 : integer := 7;
	 per7 : integer := 8;
	 per8 : integer := 9;
	 per9 : integer := 10;
	 per10 : integer := 11;
	 per11 : integer := 12;
	 per12 : integer := 13;
	 per13 : integer := 14;
	 per14 : integer := 15;
	 per15 : integer := 16
		);
  port (
    clk        : in  std_logic;         -- system clock
    reset_n    : in  std_logic;         -- system reset
    p0_irq_out : out std_logic_vector(counter_heght - 1 downto 0);
    -- avalon bus ports
    -- clk     : in  std_logic;
    cs_n       : in  std_logic;         --IP component address
    addr       : in  std_logic_vector(1 downto 0);  --offset address 4 32 bit registers
    write_n    : in  std_logic;
    read_n     : in  std_logic;
    din        : in  std_logic_vector(31 downto 0);
    dout       : out std_logic_vector(31 downto 0)

    );
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
type period_array is array (natural range 0  to counter_heght - 1) of natural;
type integer_array is array (natural range 0  to 15) of natural;
  signal period_counters : period_array;
  signal period_length : period_array;
  constant period_init: integer_array := ( -- fill 
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
  signal counter_p0                      : integer   := 0;
  signal timer_data                      : std_logic_vector(31 downto 0);
  signal tick, tick_front, tick_ack, p0b : std_logic;
  signal p0_counter_irq, p0_irq          : std_logic := '0';  --IRQ channel 0
  signal p_counter_irq, p_irq, p_irq_ack : std_logic_vector(counter_heght - 1 downto 0) := (others => '0');

  signal p_irq_ack_reg        : std_logic_vector(31 downto 0);
  signal p_irq_enable_reg     : std_logic_vector(31 downto 0);
  signal write_irq_enable_reg : std_logic;
  signal write_irq_ack_reg    : std_logic;
  signal p0_irq_ack           : std_logic;

  -- alias tick_for_sim : std_logic is tick;
begin  --architecture count_ticks

  -- instance "tick_function_1"
  tick_function_1 : entity work.tick_function
    generic map (
      g_timer_limit => tick_length)
    port map (
      reset_timer_n => '1',
      clk           => clk,
      reset_n       => reset_n,
      counter_en    => '1',
      tick          => tick,
      timer_data    => timer_data);



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
      tick_ack        <= '0';
      period_counters <= (others => 0);
      p_counter_irq <= (others => '0');
    elsif rising_edge(clk) then
      tick_ack       <= '0';
      p_counter_irq <= (others => '0');
      if tick_front = '1' then
        tick_ack <= '1';
        -- update counters
        update_counters :
        for i in period_counters'range loop
          if period_counters(i) > period_init(i) then  --issue irq
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
        if (p_counter_irq(i) = '1') and (p_irq_enable_reg(i) = '1') then
          p_irq(i) <= '1';
        end if;
        if p_irq_ack(i) = '1' then
          p_irq(i) <= '0';
        end if;
      end loop check_irq;
    end if;

  end process manage_irq;

  p0_irq_out <= p_irq;

  --avalon bus interface
  write_irq_enable_reg <= '1' when (cs_n = '0' and write_n = '0' and addr = "00") else
                          '0';
  irq_enable_register : process(reset_n, clk)

  begin
    if reset_n = '0' then
      p_irq_enable_reg <= (others => '0');
    elsif rising_edge(clk) then
      if write_irq_enable_reg = '1' then
        p_irq_enable_reg <= din;
      end if;
    end if;

  end process irq_enable_register;

  write_irq_ack_reg <= '1' when (cs_n = '0' and write_n = '0' and addr = "01") else
                       '0';
  irq_ack_register : process(reset_n, clk)

  begin
    if reset_n = '0' then
      p_irq_ack_reg <= (others => '0');
		p_irq_ack <= (others => '0');
    elsif rising_edge(clk) then
      p_irq_ack <= (others => '0');
      if write_irq_ack_reg = '1' then
        check_ack :
        for i in period_counters'range loop
          if (din(i) = '1') then
            p_irq_ack(i) <= '1';
          end if;
        end loop check_ack;
      end if;
    end if;

  end process irq_ack_register;


end architecture count_ticks_rtl;
