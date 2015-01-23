--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:33:54 01/21/2015
-- Design Name:   
-- Module Name:   D:/work/vhdl/decimal64-addition-core/adder_test.vhd
-- Project Name:  decimal64-addition-core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder
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
--USE ieee.numeric_std.ALL;
 
ENTITY adder_test IS
END adder_test;
 
ARCHITECTURE behavior OF adder_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         cin : IN  std_logic;
         sum : OUT  std_logic_vector(3 downto 0);
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal sum : std_logic_vector(3 downto 0);
   signal cout : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder PORT MAP (
          a => a,
          b => b,
          cin => cin,
          sum => sum,
          cout => cout
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      
      a <= "0000";
      b <= "0000";
      cin <= '0';
      wait for 10ns;
      
      a <= "1111";
      b <= "1111";
      cin <= '1';
      wait for 10ns;
      
      a <= "0001";
      b <= "0001";
      cin <= '0';
      wait for 10ns;
      
      a <= "0001";
      b <= "0001";
      cin <= '1';
      wait for 10ns;
      
      a <= "1111";
      b <= "0001";
      cin <= '1';
      wait for 10ns;

      wait;
   end process;

END;
