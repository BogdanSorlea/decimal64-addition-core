----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2015 06:41:08 PM
-- Design Name: 
-- Module Name: dpd_decoder_test - Behavioral
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

entity dpd_decoder_test is
    
end dpd_decoder_test;

architecture Behavioral of dpd_decoder_test is

    component dpd_decoder
        port (
            input : in std_logic_vector(9 downto 0);
            output : out std_logic_vector(11 downto 0)
        );
    end component;
    
    signal input : std_logic_vector(9 downto 0);
    signal output : std_logic_vector(11 downto 0);

begin

    uut: dpd_decoder PORT MAP (
        input => input,
        output => output
    );
    
    -- TODO: extend test for each case (similarly to the commented lines - i.e. more test for each case)
    
    stim_proc: process
    begin    
        wait for 10 ns;
        input <= "1111110111";
        wait for 100ns;
        --input <= "1011010101";
        --wait for 100ns;
        --input <= "0100100010";
        --wait for 100ns;
        input <= "1111111001";
        wait for 100ns;
        input <= "1111111011";
        wait for 100ns;
        input <= "1111111101";
        wait for 100ns;
        input <= "1110011111";
        wait for 100ns;
        input <= "1110111111";
        wait for 100ns;
        input <= "1111011111";
        wait for 100ns;
        input <= "zz11111111";
        wait for 100ns;
        
    end process;

end Behavioral;
