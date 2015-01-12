--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:46:18 01/12/2015
-- Design Name:   
-- Module Name:   D:/work/vhdl/decimal64-addition-core/operand_alignment_and_swapping_test.vhd
-- Project Name:  decimal64-addition-core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: operand_alignment_and_swapping
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
 
ENTITY operand_alignment_and_swapping_test IS
END operand_alignment_and_swapping_test;
 
ARCHITECTURE behavior OF operand_alignment_and_swapping_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT operand_alignment_and_swapping
    PORT(
         ca1 : IN  std_logic_vector(63 downto 0);
         cb1 : IN  std_logic_vector(63 downto 0);
         sa1 : IN  std_logic;
         sb1 : IN  std_logic;
         ea1 : IN  std_logic_vector(9 downto 0);
         eb1 : IN  std_logic_vector(9 downto 0);
         cas : OUT  std_logic_vector(63 downto 0);
         cbs : OUT  std_logic_vector(63 downto 0);
         lsa : OUT  natural;
         er1 : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ca1 : std_logic_vector(63 downto 0) := (others => '0');
   signal cb1 : std_logic_vector(63 downto 0) := (others => '0');
   signal sa1 : std_logic := '0';
   signal sb1 : std_logic := '0';
   signal ea1 : std_logic_vector(9 downto 0) := (others => '0');
   signal eb1 : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal cas : std_logic_vector(63 downto 0);
   signal cbs : std_logic_vector(63 downto 0);
   signal lsa : natural;
   signal er1 : std_logic_vector(9 downto 0);
	
	signal c52zero : std_logic_vector(51 downto 0) := (others => '1');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: operand_alignment_and_swapping PORT MAP (
          ca1 => ca1,
          cb1 => cb1,
          sa1 => sa1,
          sb1 => sb1,
          ea1 => ea1,
          eb1 => eb1,
          cas => cas,
          cbs => cbs,
          lsa => lsa,
          er1 => er1
        );
 
 
	-- TODO: extend testbench

   -- Stimulus process
   stim_proc: process
   begin		
		
		sa1 <= '0';
		sb1 <= '0';
		ca1 <= (others => '0');
		cb1 <= (others => '0');
		ea1 <= (others => '0');
		eb1 <= (others => '0');
      wait for 10ns;
		
		sa1 <= '0';
		sb1 <= '0';
		ca1 <= (others => '1');
		cb1 <= "000000000000" & c52zero;
		ea1 <= "0000011111";
		eb1 <= "1000011111";
      wait for 10ns;

      -- insert stimulus here 

      wait;
   end process;

END;
