----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2015 04:04:38 PM
-- Design Name: 
-- Module Name: decimal64_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decimal64_adder is
    -- A (operation) B
    port (
        a, b : in std_logic_vector(63 downto 0);
        operation : in std_logic;   -- 0 for addition, 1 for subtraction
        rounding_mode : in std_logic_vector(2 downto 0) -- 6 rounding modes => 2^3 values as input
    );
end decimal64_adder;

architecture Behavioral of decimal64_adder is

begin


end Behavioral;
