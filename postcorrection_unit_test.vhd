--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:39:54 01/24/2015
-- Design Name:   
-- Module Name:   D:/work/vhdl/decimal64-addition-core/postcorrection_unit_test.vhd
-- Project Name:  decimal64-addition-core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: postcorrection_unit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY postcorrection_unit_test IS
END postcorrection_unit_test;
 
ARCHITECTURE behavior OF postcorrection_unit_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT postcorrection_unit
    PORT(
         c1 : IN  std_logic_vector(18 downto 0);
         ucr : IN  std_logic_vector(75 downto 0);
         f1 : IN  std_logic_vector(75 downto 0);
         eop : IN  std_logic;
         cr1 : OUT  std_logic_vector(75 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal c1 : std_logic_vector(18 downto 0) := (others => '0');
   signal ucr : std_logic_vector(75 downto 0) := (others => '0');
   signal f1 : std_logic_vector(75 downto 0) := (others => '0');
   signal eop : std_logic := '0';

 	--Outputs
   signal cr1 : std_logic_vector(75 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: postcorrection_unit PORT MAP (
          c1 => c1,
          ucr => ucr,
          f1 => f1,
          eop => eop,
          cr1 => cr1
        );
 

   -- Stimulus process
   stim_proc: process
   begin		

        eop <= '1';
        ucr <= "0010" & std_logic_vector(to_unsigned(0, 40)) & "01101111111111111111101101001111";
        c1 <= "1111111111100000010";
        f1 <= std_logic_vector(to_unsigned(0, 68)) & "00011111";
        wait for 10ns;
        
        -- considering the missing 1 as 2nd LSB digit of f1
        eop <= '1';
        ucr <= "0010" & std_logic_vector(to_unsigned(0, 40)) & "01101111111111111111101101001111";
        c1 <= "1111111111100000010";
        f1 <= std_logic_vector(to_unsigned(0, 68)) & "00001111";
        wait for 10ns;
        
      wait;
   end process;

END;
