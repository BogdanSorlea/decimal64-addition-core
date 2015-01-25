----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2015 02:24:32 PM
-- Design Name: 
-- Module Name: overflow - Behavioral
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

entity overflow is
    Port ( 
        c1 : in std_logic_vector(18 downto 0);
        er1 : in std_logic_vector(9 downto 0);
        infinity : out std_logic;
        nan : out std_logic;
        overflow : out std_logic
        );
        
end overflow;

architecture Behavioral of overflow is

begin

    nan <= '1' when er1 > "1100000000" else '0';
    infinity <= '1' when er1 = "1100000000" else '0';
    overflow <= '1' when (er1 = "1011111111" and c1(18) = '1') or (er1 = "0000000000" and c1(18) = '1') else '0'; 

end Behavioral;

