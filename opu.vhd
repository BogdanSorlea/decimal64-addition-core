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
use IEEE.NUMERIC_STD.ALL;

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
        --for Sign_Inj
        operation : in std_logic;
        eop : in std_logic;
        swap : in std_logic;
        sa1, sb1 : in std_logic;
        rounding : in std_logic_vector(2 downto 0);
        --
        sticky_bit : in std_logic;
        ca3 : out std_logic_vector(75 downto 0);   --19 digits
        cb3 : out std_logic_vector(75 downto 0);
        sign_inj : out std_logic
    );
end OPU;

architecture Behavioral of OPU is

signal ca3_s, cb3_s, ca3_c : std_logic_vector(75 downto 0); --19 digits
signal zero : std_logic_vector(3 downto 0);
signal R, S : std_logic_vector(3 downto 0) :="0000" ;
signal sticky_digit : std_logic_vector(3 downto 0);
--signal add6 : std_logic_vector(3 downto 0) := "0110";
signal i: natural;
signal sign_inj_s : std_logic;


begin

sign_inj_s <= (not(eop and swap) and sa1) or ((eop and swap) and (operation xor sb1));
sign_inj <= sign_inj_s;

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
process(sign_inj_s, rounding)
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
            S <= "1001";
        when "011" => 
            R <= "0101";
            S <= "0000";  
--Round Toward Poitive                                  
        when "100" => 
            if sign_inj_s = '1' then
                R <= "0000";
                S <= "0000";
            else        
                R <= "1001";
                S <= "1001";
            end if;
 --Round toward Negative             
        when "101" => 
             if sign_inj_s = '1' then
                 R <= "1001";
                 S <= "1001";
                else        
                  R <= "0000";
                  S <= "0000";
                end if;  
          when "110" => 
                  R <= "1001";
                  S <= "1001";
          when others => 
                  R <= "0000";
                  S <= "0000";
        end case;              
end process;


--Operand placement
process(ca2, cb2, operation, R, S, sticky_digit)
begin
    if operation = '1' then
        ca3_s <= ca2 & "0000" & R & S;
        cb3_s <= cb2 & sticky_digit;
    else
        ca3_s <= "0000" & ca2 & R & S;
        cb3_s <= "0000" & cb2(71 downto 4) & sticky_digit;
    end if;
end process;

--Pre correction , adding "six" to each figitin BCD to ca3_S
process(ca3_s)
    variable i :natural;
begin
    for i in 0 to 18 loop
        ca3_c((i+1)*4-1 downto i*4) <=  std_logic_vector(unsigned(ca3_s((i+1)*4-1 downto i*4)) + "0110");   
    end loop;
end process;           


process(ca3_s, ca3_c, cb3_s, eop)
begin
    if eop = '1' then
        ca3 <= ca3_s;
        cb3 <= not cb3_s;
    else
        ca3 <= ca3_c;
        cb3 <= cb3_s;
    end if;
end process;        
        

end Behavioral;
