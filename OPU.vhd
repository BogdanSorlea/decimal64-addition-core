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
    rounding : in std_logic_vector(2 downto 0);
    sticky_bit : in std_logic;
    ca3 : out std_logic_vector(75 downto 0);   --19 digits
    cb3 : out std_logic_vector(75 downto 0)
    );
end OPU;

architecture Behavioral of OPU is

signal ca3_s, cb3_s : std_logic_vector(75 downto 0);
signal zero : std_logic_vector(3 downto 0);
signal R, S : std_logic_vector(3 downto 0);
signal sticky_digit : std_logic_vector(3 downto 0);




begin


--sticky digit generation
-- will be changed with foor loop iteration later
process(cb2, sticky_bit, operation)
begin
    if operation = '1' then
        sticky_digit <= "000" & sticky_bit;
    else
         sticky_digit(0) <= cb2(0) or cb2(1) or cb2(2) or cb2(3) or sticky_bit;
         sticky_digit(1) <= cb2(4) or cb2(5) or cb2(6) or cb2(7) or sticky_bit;
         sticky_digit(2) <= cb2(8) or cb2(9) or cb2(10) or cb2(11) or sticky_bit;
         sticky_digit(3) <= cb2(12) or cb2(13) or cb2(14) or cb2(15) or sticky_bit; 
    end if;
end process;                   
             

--injection values for different rounding modes
--rounding mode: roundTowardsZero = 0000 
-- ......
--rounding mode: roundAwayZero = 1000
process(operation, rounding)
begin
    case (rounding) is
        when "000" => 
            R <= "0000";
            S <= "0000";
        when "001" => 
            R <= "0101";
            S <= "0000";     
        when "010" => 
            R <= "0100";
            S <= "1000";
        when "011" => 
            R <= "0101";
            S <= "0000";  
--Round Toward Poitive               
-- need to review the sign bit/operation condition                   
        when "100" => 
            if operation = '1' then
                R <= "0000";
                S <= "0000";
            else        
                R <= "1000";
                S <= "1000";
            end if;
 --Round toward Negative             
        when "101" => 
             if operation = '1' then
                 R <= "1000";
                 S <= "1000";
                else        
                  R <= "0000";
                  S <= "0000";
                end if;  
          when "110" => 
                  R <= "1000";
                  S <= "1000";
          when others => 
                  R <= "0000";
                  S <= "0000";
        end case;              
end process;

end Behavioral;
