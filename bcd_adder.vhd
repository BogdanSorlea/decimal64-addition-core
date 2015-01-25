----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2015 03:26:43 PM
-- Design Name: 
-- Module Name: bcd_addder - Behavioral
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


entity bcd_adder is
    port(
        a,b  : in  std_logic_vector(3 downto 0); -- input numbers.
        c_in : in std_logic;
        sum  : out  std_logic_vector(3 downto 0); 
        c_out : out std_logic  
    );
end bcd_adder;

architecture Behavioral of bcd_adder is

signal tmp_sum : std_logic_vector(4 downto 0);
signal tmp_cin : std_logic_vector(4 downto 0); 
signal sum_s : std_logic_vector(3 downto 0);


begin

tmp_cin <= "0000" & c_in;

process(a,b, tmp_sum, tmp_cin)
begin
    tmp_sum <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b) + unsigned(tmp_cin)); 
    if(tmp_sum > "01001") then
        c_out <= '1';
        sum_s <= std_logic_vector(resize((unsigned(tmp_sum) + "00110"),4));
    else
        c_out <= '0';
        sum_s <= tmp_sum(3 downto 0);
    end if; 
end process;

sum <= std_logic_vector(sum_s);   

end Behavioral;
