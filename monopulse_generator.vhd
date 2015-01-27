----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:31:19 01/27/2015 
-- Design Name: 
-- Module Name:    monopulse_generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity monopulse_generator is

	port (
		clk : in std_logic;
		btn : in std_logic;
		step : out std_logic
	);

end monopulse_generator;

architecture Behavioral of monopulse_generator is

	signal q0, q1, q2 : std_logic;
	signal cnt : std_logic_vector(22 downto 0);

begin

	COUNT : process(clk)
	begin
		if (rising_edge(clk)) then
			cnt <= cnt + '1';
		end if;
	end process;

	FF1 : process(cnt)
	begin
		if (rising_edge(cnt(cnt'high))) then
			q0 <= btn;
		end if;
	end process;

	FF : process(clk)
	begin
		if (rising_edge(clk)) then
			q1 <= q0;
			q2 <= q1;
		end if;
	end process;
	
	step <= q1 and not q2;

end Behavioral;

