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

  counter <= (others => '0')  when (reset_n = '0') else
               counter_on_clk when rising_edge(clk);
  counter_on_clk <= counter + 1 when Control_timer = "10" else
               counter          when Control_timer = "01" else
               (others => '0')  when Control_timer = "00" else
               (others => '0');
  
  timer_data <= std_logic_vector(counter);

end timer_top_rtl;
