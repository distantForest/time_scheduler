-------------------------------------------------------------------------------
-- Title      : IRQ selector
-- Project    : 
-------------------------------------------------------------------------------
-- File       : irq_selector.vhd
-- Author     : Igor Parchakov  <igor_pa@live.com>
-- Company    : AGSTU
-- Created    : 2025-02-07
-- Last update: 2025-02-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: The component uses a simple arbitration to handle several irq sources
-- over one irq line
-------------------------------------------------------------------------------
-- Copyright (c) 2025 AGSTU
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2025-02-07  1.0      igor    Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity irq_selector is
  generic (
    height : natural := 4               -- number of input irq lines
    );
  port(
    clk      : in  std_logic
  ; reset_n    : in  std_logic
                                          -- 
  ; irq_in_mx  : in  std_logic_vector (height - 1 downto 0)
  ; ack_in_mx  : in  std_logic_vector (height - 1 downto 0)
  ; ack_in     : in  std_logic
  ; irq_out    : out std_logic
  ; vector_out : out std_logic_vector (height - 1 downto 0)  -- 
    );
end irq_selector;

architecture rtl of irq_selector is

  signal vector   : natural range 0 to height - 1;
  signal irq_sent : std_logic_vector (height - 1 downto 0);

begin

  selector : process (reset_n, clk)
  begin
    if reset_n = '0' then
      vector = 0;
      irq_out <= '0';
    elsif rising_edge(clk) then
                                        --

      if irq_out = '0' then
        scan :                          -- the line is free
        for i in range 0 to height - 1 loop
          if (irq_in_mx(i) = '1') and (irq_sent(i) = '0') then
            -- sending irq
            irq_out     <= '1';
            vector      <= i;
            irq_sent(i) <= '1';
            exit;
          end if;
        end loop scan;
      elsif ack_in = '0' then           -- line is still active
        irq_out <= '0';
        vector  <= 0;
      end if;
      -- manage sent flag
      for i in range 0 to height -1 loop
        if (ack_in_mx(i) = '1') then
          irq_sent(i) <= '1';
          end if;
      end loop;
    end if;
  end if;
end process selector;

acknowlege : process (reset_n, clk)
  begin
    if reset_n = '0' then
      
    end if;



end architecture rtl;
