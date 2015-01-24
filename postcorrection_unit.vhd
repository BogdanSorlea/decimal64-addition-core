----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:59:31 01/24/2015 
-- Design Name: 
-- Module Name:    postcorrection_unit - Behavioral 
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

entity postcorrection_unit is

    port(
        c1 : in std_logic_vector(18 downto 0);
        ucr, f1 : in std_logic_vector(75 downto 0);
        eop : in std_logic;
        cr1 : out std_logic_vector(75 downto 0)
    );

end postcorrection_unit;

architecture Behavioral of postcorrection_unit is

begin

    postcorrection: process(c1, ucr, f1, eop)
        variable i : natural := 0;
        variable tmp_cr1_digit, tmp_cr1_invdig : std_logic_vector(4 downto 0);
        variable correction_6 : std_logic_vector(4 downto 0);
    begin
    
        correction_6 := "01010";
        
        for i in 0 to 18 loop
            if eop = '0' then
                if c1(i) = '0' then
                    tmp_cr1_digit := std_logic_vector(unsigned(ucr(4*(i+1)-1 downto 4*i)) + unsigned(correction_6));
                    cr1(4*(i+1)-1 downto 4*i) <= tmp_cr1_digit(3 downto 0);
                else
                    cr1(4*(i+1)-1 downto 4*i) <= ucr(4*(i+1)-1 downto 4*i);
                end if;
            else
                if c1(18) = '1' then
                    tmp_cr1_invdig := "0" & (ucr(4*(i+1)-1 downto 4*i) xor f1(4*(i+1)-1 downto 4*i));
                    if (c1(i) xor f1(4*(i+1)-1)) = '0' then
                        tmp_cr1_digit := std_logic_vector(unsigned(tmp_cr1_invdig(3 downto 0)) + unsigned(correction_6));
                    else
                        tmp_cr1_digit := tmp_cr1_invdig(4 downto 0);
                    end if;
                    cr1(4*(i+1)-1 downto 4*i) <= tmp_cr1_digit(3 downto 0);
                else
                    tmp_cr1_invdig := "0" & (not ucr(4*(i+1)-1 downto 4*i));
                    tmp_cr1_digit := std_logic_vector(unsigned(tmp_cr1_invdig(3 downto 0)) + unsigned(correction_6));
                    cr1(4*(i+1)-1 downto 4*i) <= tmp_cr1_digit(3 downto 0);
                end if;
            end if;
        end loop;
    
    end process;

end Behavioral;

