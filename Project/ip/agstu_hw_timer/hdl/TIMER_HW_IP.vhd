-------------------------------------------------------------------------------
-- Title      : Hardware timer IP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : TIMER_HW_IP.vhd
-- Author     : Igor Parchakov  <igor@fedora>
-- Company    : AGSTU
-- Created    : 2025-06-24
-- Last update: 2025-06-24
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: The top level entity for timer_function. It includes
--               Avalon bus interface
-------------------------------------------------------------------------------
-- Copyright (c) 2025 AGSTU
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2025-06-24  1.0.1      igor	Created
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity TIMER_HW_IP is
  port(
    reset_n : in  std_logic;
    clk     : in  std_logic;
    cs_n    : in  std_logic;                     -- IP component address
    addr    : in  std_logic_vector(1 downto 0);  -- offset address
    write_n : in  std_logic;
    read_n  : in  std_logic;
    din     : in  std_logic_vector(31 downto 0);
    dout    : out std_logic_vector(31 downto 0)
    );
end TIMER_HW_IP;

architecture RTL of TIMER_HW_IP is
  component timer_function is
    port
      (
        Control_timer : in    std_logic_vector(1 downto 0);
        clk           : in    std_logic;
        reset_n       : in    std_logic;
        timer_data    : out std_logic_vector(31 downto 0)
        );
  end component timer_function;

  signal data_reg    : std_logic_vector(31 downto 0) := (others => '0');  -- data register
  signal control_reg : std_logic_vector(1 downto 0)  := "00";
begin  -- architecture RTL

  timer_comp : timer_function
    port map
    (
      Control_timer => control_reg,
      clk           => clk,
      reset_n       => reset_n,
      timer_data    => data_reg
      );
  dout <= data_reg when (cs_n = '0' and
                         read_n = '0' and
                         addr = "00") else
          (others => '0');
  
  process(clk, reset_n)
  begin
      if reset_n = '0' then
        control_reg <= (others => '0');
    elsif rising_edge(clk) then
      if(cs_n = '0' and
         write_n = '0' and
         addr = "01") then
        control_reg <= din(din'left downto (din'left - control_reg'left)); 
      end if;
    end if;
  end process;
  
end architecture RTL;
