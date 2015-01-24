----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:38:16 01/24/2015 
-- Design Name: 
-- Module Name:    dpd_encode - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dpd_encode is

    port(
        digit_group : in std_logic_vector(11 downto 0);
        dpd_group : out std_logic_vector(9 downto 0)
    );

end dpd_encode;

architecture Behavioral of dpd_encode is

    signal d0, d1, d2 : std_logic_vector(3 downto 0);
    signal dig_range : std_logic_vector(2 downto 0);

begin

    d0 <= digit_group(3 downto 0);
    d1 <= digit_group(7 downto 4);
    d2 <= digit_group(11 downto 8);
    
    dig_range(2) <= '1' when unsigned(d2) > 7 else '0';
    dig_range(1) <= '1' when unsigned(d1) > 7 else '0';
    dig_range(0) <= '1' when unsigned(d0) > 7 else '0';
    
    
    
    
    
    
    encoding: process(d0, d1, d2, dig_range)
    begin
    
        case dig_range is
            when "000" =>
                dpd_group(3) <= '0';
                dpd_group(9 downto 7) <= d2(2 downto 0);
                dpd_group(6 downto 4) <= d1(2 downto 0);
                dpd_group(2 downto 0) <= d0(2 downto 0);
            when "001" =>
                dpd_group(3 downto 1) <= "100";
                dpd_group(9 downto 7) <= d2(2 downto 0);
                dpd_group(6 downto 4) <= d1(2 downto 0);
                dpd_group(0) <= d0(0);
            when "010" =>
                dpd_group(3 downto 1) <= "101";
                dpd_group(9 downto 7) <= d2(2 downto 0);
                dpd_group(6 downto 5) <= d0(2 downto 1);
                dpd_group(4) <= d1(0);
                dpd_group(0) <= d0(0);
            when "100" =>
                dpd_group(3 downto 1) <= "110";
                dpd_group(9 downto 8) <= d0(2 downto 1);
                dpd_group(7) <= d2(0);
                dpd_group(6 downto 4) <= d1(2 downto 0);
                dpd_group(0) <= d0(0);
            when "110" =>
                dpd_group(3 downto 1) <= "111";
                dpd_group(6 downto 5) <= "00";
                dpd_group(0) <= d0(0);
                dpd_group(4) <= d1(0);
                dpd_group(7) <= d2(0);
                dpd_group(9 downto 8) <= d0(2 downto 1);
            when "101" =>
                dpd_group(3 downto 1) <= "111";
                dpd_group(6 downto 5) <= "01";
                dpd_group(0) <= d0(0);
                dpd_group(4) <= d1(0);
                dpd_group(7) <= d2(0);
                dpd_group(9 downto 8) <= d1(2 downto 1);
            when "011" =>
                dpd_group(3 downto 1) <= "111";
                dpd_group(6 downto 5) <= "10";
                dpd_group(0) <= d0(0);
                dpd_group(4) <= d1(0);
                dpd_group(9 downto 7) <= d2(2 downto 0);
            when others =>
                dpd_group(3 downto 1) <= "111";
                dpd_group(6 downto 5) <= "11";
                dpd_group(9 downto 8) <= "11";
                dpd_group(0) <= d0(0);
                dpd_group(4) <= d1(0);
                dpd_group(7) <= d2(0);
        end case;
    
    end process;

end Behavioral;

