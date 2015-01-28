----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2015 11:49:07 AM
-- Design Name: 
-- Module Name: tb_opu - Behavioral
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

entity sru_test is
end sru_test;

architecture Behavioral of sru_test is

 Component sru 
    Port (
         ucr_lsd : in std_logic_vector(7 downto 0);   -- ucr_lsd(11 downto 4)
         cr1 : in std_logic_vector(63 downto 0);
         f2 : in std_logic_vector(15 downto 0);
         rounding : in std_logic_vector(2 downto 0);
         sign_inj : in std_logic;
         er1 : in std_logic_vector(9 downto 0);
         er2 : out std_logic_vector(9 downto 0);
         cr2: out std_logic_vector(63 downto 0)
         );
end component;
    

   --Inputs
   signal f2 : std_logic_vector(15 downto 0) := (others => '0');
   signal cr1 : std_logic_vector(63 downto 0) := (others => '0');
   signal sign_inj : std_logic := '0';
   signal ucr_lsd : std_logic_vector(7 downto 0);
   signal rounding : std_logic_vector(2 downto 0);
   signal er1, er2 : std_logic_vector(9 downto 0);
 	--Outputs
   signal cr2 : std_logic_vector(63 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sru PORT MAP (
          f2 => f2,
          cr1 => cr1,
          ucr_lsd => ucr_lsd,
          rounding => rounding,
          sign_inj => sign_inj, 
          er1 => er1,
          er2 => er2,
          cr2 => cr2
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
        
        er1 <= "0000000000"; 
        f2 <= X"0000";
        cr1 <= X"0000_0000_0000_0000";
        ucr_lsd <=  X"00";
        rounding <= "000";
        sign_inj <= '0'; 
    
      wait for 60ns;
      
        er1 <= "1000000000";
        f2 <= "0000000000011111";
        cr1 <= X"2000_0000_0000_9999";
        ucr_lsd <=  X"55";  --GR , s is not considered
        rounding <= "001";
        sign_inj <= '0'; 
        
        wait for 60ns;
        er1 <= "0000000001";
         f2 <= X"FFFF";
         cr1 <= X"9999_9999_9999_9999";
         ucr_lsd <=  X"55";  --GR , s is not considered
         rounding <= "001";
         sign_inj <= '0'; 
         
        wait for 60ns;
        er1 <= "0101010101";
         f2 <= X"0000";
         cr1 <= X"0000_0000_5129_4568";
         ucr_lsd <=  X"55";  --GR , s is not considered
         rounding <= "001";
         sign_inj <= '0'; 
        wait;       
     wait;       
   end process;



end Behavioral;
