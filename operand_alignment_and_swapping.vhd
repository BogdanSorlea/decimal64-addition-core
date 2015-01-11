----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2015 07:39:52 PM
-- Design Name: 
-- Module Name: operand_alignment_and_swapping - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity operand_alignment_and_swapping is
    port (
        ca1, cb1 : in std_logic_vector(63 downto 0);
        sa1, sb1 : in std_logic;
        ea1, eb1 : in std_logic_vector(9 downto 0);
        cas, cbs : out std_logic_vector(63 downto 0);
        er1 : out std_logic_vector(9 downto 0)
    );
end operand_alignment_and_swapping;

architecture Behavioral of operand_alignment_and_swapping is


begin

    cas <= cb1 when unsigned(eb1) - unsigned(ea1) > 0 else ca1;
    cbs <= ca1 when unsigned(eb1) - unsigned(ea1) > 0 else cb1;
    
    

end Behavioral;
