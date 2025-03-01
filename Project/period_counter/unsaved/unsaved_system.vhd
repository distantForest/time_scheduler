library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unsaved_system is
	port
	(
		-- Input ports
		reset_btn : in std_logic;
		clk_50 : in std_logic

		-- Output ports
	);
end unsaved_system;

architecture system of unsaved_system is
  component unsaved is
    port (
		clk_clk                      : in  std_logic := '0'; --                     clk.clk
		reset_reset_n                : in  std_logic := '0' --                   reset.reset_n
--		time_scheduler_0_vector_name : out std_logic         -- time_scheduler_0_vector.name
		);
  end component unsaved;
begin
  unsaved_1 : unsaved
    port map (
      clk_clk => clk_50,
      reset_reset_n => reset_btn);
end system;
