-------------------------------------------------------------------------------
-- Title      : Testbench for design "irq_selector"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : irq_selector_tb.vhd
-- Author     : Igor Parchakov  <igor@fedora>
-- Company    : AGSTU
-- Created    : 2025-02-12
-- Last update: 2025-02-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2025 AGSTU
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2025-02-12  1.0      igor    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library modelsim_lib;
use modelsim_lib.util.all;

-------------------------------------------------------------------------------

entity irq_selector_tb is

end entity irq_selector_tb;

-------------------------------------------------------------------------------

architecture sim_testbench of irq_selector_tb is
  -- procedures


  -- component generics
  constant height : natural := 4;

  -- component ports
  signal clk        : std_logic := '0';
  signal reset_n    : std_logic := '0';
  signal irq_in_mx  : std_logic_vector (height - 1 downto 0);
  signal ack_in_mx  : std_logic_vector (height - 1 downto 0);
  signal ack_in     : std_logic;
  signal irq_out    : std_logic;
  signal vector_out : natural range 0 to height - 1;

  signal irq_sent_for_sim : std_logic_vector (height - 1 downto 0);


  constant stc_l_v_zero : std_logic_vector (height - 1 downto 0) := (others => '0');

  -- Wait for a given number of clock cycles
  procedure wait_cycles(cycles : integer) is
  begin
    for i in 0 to cycles loop
      wait until clk = '1';
      wait until clk = '0';
    end loop;
  end procedure;

  -- Procedure for IRQ-ACK sequence
  procedure irq_ack_sequence(
    signal irq, ack    : out std_logic;
    irq_time, ack_time :     integer;
    signal clk         : in  std_logic
    ) is
  begin
    if reset_n = '0' then
      irq <= '0';
      ack <= '0';
      wait until reset_n = '1';
    else
      wait until clk = '1';
      irq <= '1';
      wait_cycles(irq_time);
      wait until clk = '1';
      ack <= '1';
      wait until clk = '1';
      ack <= '0';
      irq <= '0';
      wait_cycles(ack_time);
    end if;
  end procedure;

begin  -- architecture sim_testbench

  -- component instantiation
  DUT : entity work.irq_selector
    generic map (
      height => height)
    port map (
      clk        => clk,
      reset_n    => reset_n,
      irq_in_mx  => irq_in_mx,
      ack_in_mx  => ack_in_mx,
      ack_in     => ack_in,
      p_irq_out    => irq_out,
      vector_out => vector_out);

  spy_process : process
  begin
    init_signal_spy("/irq_selector_tb/DUT/irq_sent", "/irq_sent_for_sim", 1);
    wait;
  end process spy_process;

  -- clock generation
  clk <= not clk after 10 ns;

  -- period functions simulation
  irq_ack_sequence(irq_in_mx(0), ack_in_mx(0), 10, 30, clk);
  irq_ack_sequence(irq_in_mx(1), ack_in_mx(1), 40, 40, clk);
  irq_ack_sequence(irq_in_mx(2), ack_in_mx(2), 60, 100, clk);
  irq_ack_sequence(irq_in_mx(3), ack_in_mx(3), 200, 140, clk);


  -- reset the system
  start_Proc : process
  begin

    wait until Clk = '1';
    wait until Clk = '0';
    wait until Clk = '1';
    reset_n <= '1';
    wait;
  end process start_Proc;

  general_ack_proc : process
  begin
    wait until clk = '1';
    ack_in <= '0';
    wait until irq_out = '1';
    wait_cycles(3);
    ack_in <= '1';
  end process general_ack_proc;

end architecture sim_testbench;

-------------------------------------------------------------------------------

configuration irq_selector_tb_sim_testbench_cfg of irq_selector_tb is
  for sim_testbench
  end for;
end irq_selector_tb_sim_testbench_cfg;

-------------------------------------------------------------------------------
