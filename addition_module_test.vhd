--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:01:20 01/24/2015
-- Design Name:   
-- Module Name:   D:/work/vhdl/decimal64-addition-core/addition_module_test.vhd
-- Project Name:  decimal64-addition-core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: addition_module
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
 
ENTITY addition_module_test IS
END addition_module_test;
 
ARCHITECTURE behavior OF addition_module_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT addition_module
    PORT(
         ca3 : IN  std_logic_vector(75 downto 0);
         cb3 : IN  std_logic_vector(75 downto 0);
         eop : IN  std_logic;
         f2 : OUT  std_logic_vector(15 downto 0);
         c1 : OUT  std_logic_vector(18 downto 0);
         ucr : OUT  std_logic_vector(75 downto 0);
         f1 : OUT  std_logic_vector(75 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ca3 : std_logic_vector(75 downto 0) := (others => '0');
   signal cb3 : std_logic_vector(75 downto 0) := (others => '0');
   signal eop : std_logic := '0';

 	--Outputs
   signal f2 : std_logic_vector(15 downto 0);
   signal c1 : std_logic_vector(18 downto 0);
   signal ucr : std_logic_vector(75 downto 0);
   signal f1 : std_logic_vector(75 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: addition_module PORT MAP (
          ca3 => ca3,
          cb3 => cb3,
          eop => eop,
          f2 => f2,
          c1 => c1,
          ucr => ucr,
          f1 => f1
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      
      ca3 <= x"2000000000100000050"; 
            --"0010" & std_logic_vector(to_unsigned(0, 36)) & "0001" & std_logic_vector(to_unsigned(0, 20)) & "000001010000";
      cb3 <= x"FFFFFFFFFFF6FFFFAFF";
            --"1111111111111111111111111111111111111111111101101111111111111111101011111111";
      eop <= '1';
      
      wait for 10ns;
      
      wait;
   end process;

END;
