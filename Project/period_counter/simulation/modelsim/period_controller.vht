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
use ieee.numeric_std.all;
use std.env.all;

library modelsim_lib;
use modelsim_lib.util.all;

entity period_controller_vhd_tst is
end period_controller_vhd_tst;
architecture period_controller_arch of period_controller_vhd_tst is
-- constants                                                 
  constant CLK_PERIOD : time := 20 ns;
  constant tst_counter_height : integer := 4;
-- signals                                                   
  signal clk        : std_logic := '0';
  signal reset_n    : std_logic;
  signal p0_irq_out : std_logic_vector(tst_counter_height - 1 downto 0);
  signal cs_n       : std_logic;
  signal addr       : std_logic_vector(1 downto 0);
  signal write_n    : std_logic;
  signal read_n     : std_logic;
  signal din        : std_logic_vector(31 downto 0);
  signal dout       : std_logic_vector(31 downto 0);
  signal irq_number : integer := 0;

  signal ack_put_data_on, ack_processing :
    std_logic := '0';  -- ack delay

  signal irq_enable_ph_1, irq_enable_ph_2, write_irq_enable : std_logic := '0';
  -----------------------------------------------------------------------------
  signal tick_length_in_clk_cycles : integer   := 0;
  signal start_measurement         : std_logic := '0';

  -- Signal to retain the start of the tick pulse across clock cycles
  signal tick_start : integer := 0;
  signal tick_for_sim : std_logic := '0';
  -- alias tick_for_sim is << signal period_controller_vhd_tst.i1.tick_function_1.tick : std_logic >>;

  -- alias tick_for_sim is
  --    <<signal .period_controller_vhd_tst.i1.tick_function_1.tick_local : std_logic>>;

-------------------------------------------------------------------------------
begin
  i1: entity work.period_controller
    generic map (
      counter_heght   => tst_counter_height,
      tick_length     => 3,
      -- period_0_length => period_0_length,
      per0            => 1
      ,per1            => 2
      ,per2            => 3
      ,per3            => 5
      -- per4            => per4,
      -- per5            => per5,
      -- per6            => per6,
      -- per7            => per7,
      -- per8            => per8,
      -- per9            => per9,
      -- per10           => per10,
      -- per11           => per11,
      -- per12           => per12,
      -- per13           => per13,
      -- per14           => per14,
      -- per15           => per15
      )
    port map (
      clk        => clk,
      reset_n    => reset_n,
      p0_irq_out => p0_irq_out,
      cs_n       => cs_n,
      addr       => addr,
      write_n    => write_n,
      read_n     => read_n,
      din        => din,
      dout       => open);

  spy_process : process
  begin
    init_signal_spy("/period_controller_vhd_tst/i1/tick_function_1/tick","/tick_for_sim",1);
    wait;
  end process spy_process;

-- tick_for_sim <= i1.tick_function_1.tick;
clk <= not clk after CLK_PERIOD / 2;
 -- tick_for_sim <= << signal period_controller_vhd_tst.i1.tick_function_1.tick : std_logic >>;    
  init : process
-- variable declarations                                     
  begin
    -- code that executes only once
    --
    reset_n <= '0';
    write_irq_enable  <= '0';
    wait for 122 ns;
    reset_n <= '1';
    wait for 60 ns;
    write_irq_enable  <= '1'; -- enable interrupts 
    wait for 66 ns;
    start_measurement <= '1';           -- tick puls length measurements
      

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

-- irq management
  irq_management : process(reset_n, clk)
  begin
    if reset_n = '0' then
      ack_put_data_on   <= '0';
      irq_enable_ph_1   <= '0';
      irq_enable_ph_2   <= '0';
      cs_n    <= '1';
      addr    <= "00";
      write_n <= '1';
      read_n  <= '1';
      irq_number <= 0;
      din     <= (others => '0');
      dout    <= (others => '0');

    elsif rising_edge(clk) then
      if (write_irq_enable = '1') and (irq_enable_ph_1 = '0') then
        irq_enable_ph_1   <= '1';
        irq_enable_ph_2   <= '1';
        cs_n    <= '0';
        addr    <= "00";
        write_n <= '0';
        din  <= (others => '1');
      end if;
      if irq_enable_ph_2 = '1' then     -- put away data
        irq_enable_ph_2   <= '0';
        cs_n    <= '1';
        addr    <= "00";
        write_n <= '1';
        din  <= (others => '0');
      end if;

-- acknowledge interrupt individually each bit
      for i in p0_irq_out'range loop
        if (p0_irq_out(i) = '1') and (ack_processing = '0') then
          ack_put_data_on   <= '1';
          ack_processing  <= '1';
          cs_n    <= '0';
          addr    <= "01";
          write_n <= '0';
          din <= (others => '0');
          din(i)  <= '1';
          exit;
        end if;
      end loop;
      if ack_put_data_on = '1' then
        ack_put_data_on   <= '0';
        cs_n    <= '1';
        addr    <= "00";
        write_n <= '1';
        din  <= (others => '0');
      end if;
      if (ack_processing = '1') and (ack_put_data_on = '0') then
        ack_processing <= '0';
      end if;
    end if;
  end process irq_management;


  -----------------------------------------------------------------------------
  measure_tick_length : process(clk, reset_n)
begin
  
  if reset_n = '0' then
    tick_start <= 0;
    tick_length_in_clk_cycles <= 0;
  elsif rising_edge(clk) then
    if start_measurement = '1' then
      if tick_for_sim = '1' then
        if tick_start = 0 then
          -- First rising edge: mark the start of the pulse
          tick_start <= tick_start + 1; -- You don't want to increment this. Instead, just mark the start.
          else
            tick_length_in_clk_cycles <= tick_length_in_clk_cycles + 1;
        end if;
      elsif tick_start > 0 then
          -- Second rising edge: calculate the pulse length
          tick_length_in_clk_cycles <= 0;
          report "Tick pulse length is " & integer'image(tick_length_in_clk_cycles + 1) & " clock cycles.";
          tick_start <= 0; -- Reset to measure next pulse
      end if;
    end if;
  end if;
end process measure_tick_length;

  -----------------------------------------------------------------------------

end period_controller_arch;
