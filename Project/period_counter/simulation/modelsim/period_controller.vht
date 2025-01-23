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
  signal p0_irq_out : std_logic;
  signal p0         : std_logic;
  signal p1         : std_logic;
  signal p2         : std_logic;
  signal p3         : std_logic;
  signal cs_n       : std_logic;
  signal addr       : std_logic_vector(1 downto 0);
  signal write_n    : std_logic;
  signal read_n     : std_logic;
  signal din        : std_logic_vector(31 downto 0);
  signal dout       : std_logic_vector(31 downto 0);

  signal ack_0, ack_00, ack_1, ack_2, ack_11 : std_logic := '0';  -- ack delay


  component period_controller is
    generic (
      counter_heght : integer);
    port (
      clk        : in  std_logic;
      reset_n    : in  std_logic;
      p0_irq_out : out std_logic;
      p0         : out std_logic;
      p1         : out std_logic;
      p2         : out std_logic;
      p3         : out std_logic;
      cs_n       : in  std_logic;
      addr       : in  std_logic_vector(1 downto 0);
      write_n    : in  std_logic;
      read_n     : in  std_logic;
      din        : in  std_logic_vector(31 downto 0);
      dout       : out std_logic_vector(31 downto 0));
  end component period_controller;
begin

  i1 : period_controller
    generic map (
      counter_heght => 4)
    port map (
      clk        => clk,
      reset_n    => reset_n,
      p0_irq_out => p0_irq_out,
      p0         => p0,
      p1         => p1,
      p2         => p2,
      p3         => p3,
      cs_n       => cs_n,
      addr       => addr,
      write_n    => write_n,
      read_n     => read_n,
      din        => din,
      dout       => dout);

  init : process
-- variable declarations                                     
  begin
    -- code that executes only once
    --
    reset_n <= '0';
    ack_11  <= '0';
    --p0_irq_ack <= '0';
    wait for 122 ns;
    reset_n <= '1';
    wait for 60 ns;
    ack_11  <= '1';


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
      ack_0   <= '0';
      ack_1   <= '0';
      ack_2   <= '0';
      cs_n    <= '1';
      addr    <= "00";
      write_n <= '1';
      read_n  <= '1';
      din     <= (others => '0');
      dout    <= (others => '0');

    elsif rising_edge(clk) then
      if (ack_11 = '1') and (ack_1 = '0') then
        ack_1   <= '1';
        ack_2   <= '1';
        cs_n    <= '0';
        addr    <= "00";
        write_n <= '0';
        din(0)  <= '1';
      end if;
      if ack_2 = '1' then
        ack_2   <= '0';
        cs_n    <= '1';
        addr    <= "00";
        write_n <= '1';
        din(0)  <= '0';
      end if;


      if (p0_irq_out = '1') and (ack_00 = '0') then
        ack_0   <= '1';
        ack_00  <= '1';
        cs_n    <= '0';
        addr    <= "01";
        write_n <= '0';
        din(0)  <= '1';
      end if;
      if ack_0 = '1' then
        ack_0   <= '0';
        cs_n    <= '1';
        addr    <= "00";
        write_n <= '1';
        din(0)  <= '0';
      end if;
      if (ack_00 = '1') and (ack_0 = '0') then
        ack_00 <= '0';
      end if;
    end if;
  end process irq_management;

end period_controller_arch;
