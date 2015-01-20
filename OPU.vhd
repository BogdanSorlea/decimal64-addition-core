----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/19/2015 11:48:06 PM
-- Design Name: 
-- Module Name: OPU - Behavioral
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

entity OPU is
    Port (
    ca2 : in std_logic_vector(63 downto 0);
    cb2 : in std_logic_vector(71 downto 0);
    operation : in std_logic;
    rounding : in std_logic;
    ca3 : out std_logic_vector(75 downto 0);   --19 digits
    cb3 : out std_logic_vector(75 downto 0)
    );
end OPU;

architecture Behavioral of OPU is

begin


end Behavioral;
