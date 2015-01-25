----------------------------------------------------------------------------------
-- Company: DTU 
-- Engineer: Istvan Szonyi (s131153@student.dtu.dk)
-- 
-- Create Date: 01/24/2015 11:25:07 PM
-- Design Name: 
-- Module Name: sru - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sru is
    Port (
        ucr_lsd : in std_logic_vector(11 downto 4);   
        cr1 : in std_logic_vector(63 downto 0);
        f2 : in std_logic_vector(15 downto 0);
        rounding : in std_logic_vector(2 downto 0);
        sign_inj : in std_logic;
        cr2: out std_logic_vector(63 downto 0)
        );
end sru;




architecture Behavioral of sru is

component bcd_adder 
    port(
        a,b  : in  std_logic_vector(3 downto 0); -- input numbers.
        c_in : in std_logic;
        sum  : out  std_logic_vector(3 downto 0); 
        c_out : out std_logic  
    );
end component;


signal cr1_s : std_logic_vector(63 downto 0); 
signal G, R, new_g, new_r : std_logic_vector(3 downto 0) := "0000";
signal r_carry, g_carry : std_logic; 

  
begin

cr2 <= cr1 when cr1(63 downto 60) = "0000" else cr1_s;

process(sign_inj, rounding)
begin
    case (rounding) is
        when "000" => 
            G <= "0000";
            R <= "0000";
        when "001" => 
            G <= "0100";
            R <= "0101";     
        when "010" => 
            G <= "0100";
            R <= "0101";
        when "011" => 
            G <= "0100";
            R <= "0101";  
--Round Toward Poitive               
-- need to review the sign bit/operation condition                   
        when "100" => 
            if sign_inj = '1' then
                G <= "0000";
                R <= "0000";
            else        
                G <= "1001";
                R <= "0000";
            end if;
 --Round toward Negative             
        when "101" => 
             if sign_inj = '1' then
                 G <= "1001";
                 R <= "0000";
                else        
                  G <= "0000";
                  R <= "0000";
                end if;  
          when "110" => 
                  G <= "1001";
                  R <= "1000";
          when others => 
                  G <= "0000";
                  R <= "0000";
        end case;              
end process;

--adding R and G, skipping S, since we always add zero

adding_r : bcd_adder port map(
     a => ucr_lsd(7 downto 4),
     b => R,
     c_in => '0',
     sum  => new_r,  
     c_out=> r_carry  
   );

adding_g : bcd_adder port map(
     a => ucr_lsd(11 downto 8),
     b => G,
     c_in => r_carry,
     sum  => new_g,  
     c_out=> g_carry  
   );
   
 
--new CR2 computation
process(f2, cr1, g_carry)
    variable i :natural;
begin
    for i in 0 to 15 loop
        if cr1((i+1)*4-1 downto i*4) = "1001" and g_carry = '1' and f2(i) = '1' then
            cr1_s((i+1)*4-1 downto i*4) <= "0000";
        elsif cr1((i+1)*4-1 downto i*4) < "1001" and g_carry = '1' and f2(i) = '1' then
            cr1_s((i+1)*4-1 downto i*4) <= std_logic_vector(unsigned(cr1((i+1)*4-1 downto i*4)) + "0001");
        else 
            cr1_s((i+1)*4-1 downto i*4) <= cr1((i+1)*4-1 downto i*4);
        end if;    
    end loop;
end process;         

end Behavioral;
