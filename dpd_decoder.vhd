----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2015 05:13:07 PM
-- Design Name: 
-- Module Name: dpd_decoder - Behavioral
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

entity dpd_decoder is
    port (
        input : in std_logic_vector(9 downto 0);
        output : out std_logic_vector(11 downto 0)
    );
end dpd_decoder;

architecture Behavioral of dpd_decoder is

    signal d2, d1, d0 : std_logic_vector(3 downto 0);

begin

    -- http://en.wikipedia.org/wiki/Decimal64_floating-point_format#Densely_packed_decimal_significand_field
    -- not really worrying about other values than 0 and 1 here - not ideal, but fast to implement
    
    process(input)
    begin
        if input(3) = '0' then
            d2 <= "0" & input(9 downto 7);
            d1 <= "0" & input(6 downto 4);
            d0 <= "0" & input(2 downto 0);
        else
            if input(2 downto 1) = "00" then
                d2 <= "0" & input(9 downto 7);
                d1 <= "0" & input(6 downto 4);
                d0 <= "100" & input(0);
            elsif input(2 downto 1) = "01" then
                d2 <= "0" & input(9 downto 7);
                d1 <= "100" & input(4);
                d0 <= "0" & input(6 downto 5) & input(0);
            elsif input(2 downto 1) = "10" then
                d2 <= "100" & input(7);
                d1 <= "0" & input(6 downto 4);
                d0 <= "0" & input(9 downto 8) & input(0);
            else
                if input(6 downto 5) = "00" then
                    d2 <= "100" & input(7);
                    d1 <= "100" & input(4);
                    d0 <= "0" & input(9 downto 8) & input(0);
                elsif input(6 downto 5) = "01" then
                    d2 <= "100" & input(7);
                    d1 <= "0" & input(9 downto 8) & input(4);
                    d0 <= "100" & input(0);
                elsif input(6 downto 5) = "10" then
                    d2 <= "0" & input(9 downto 7);
                    d1 <= "100" & input(4);
                    d0 <= "100" & input(0);
                else
                    d2 <= "100" & input(7);
                    d1 <= "100" & input(4);
                    d0 <= "100" & input(0);
                end if;
            end if;
        end if;
    end process;

end Behavioral;
