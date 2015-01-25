--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:40:17 01/24/2015
-- Design Name:   
-- Module Name:   D:/work/vhdl/decimal64-addition-core/decimal64_adder_no_conversions_test.vhd
-- Project Name:  decimal64-addition-core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decimal64_adder_no_conversions
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
 
ENTITY decimal64_adder_no_conversions_test IS
END decimal64_adder_no_conversions_test;
 
ARCHITECTURE behavior OF decimal64_adder_no_conversions_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decimal64_adder_no_conversions
    PORT(
         ca1 : IN  std_logic_vector(63 downto 0);
         cb1 : IN  std_logic_vector(63 downto 0);
         ea1 : IN  std_logic_vector(9 downto 0);
         eb1 : IN  std_logic_vector(9 downto 0);
         sa1 : IN  std_logic;
         sb1 : IN  std_logic;
         operation : IN  std_logic;
         rounding : IN std_logic_vector(2 downto 0);
         r1 : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ca1 : std_logic_vector(63 downto 0) := (others => '0');
   signal cb1 : std_logic_vector(63 downto 0) := (others => '0');
   signal ea1 : std_logic_vector(9 downto 0) := (others => '0');
   signal eb1 : std_logic_vector(9 downto 0) := (others => '0');
   signal sa1 : std_logic := '0';
   signal sb1 : std_logic := '0';
   signal operation : std_logic := '0';
   signal rounding : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal r1 : std_logic_vector(63 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decimal64_adder_no_conversions PORT MAP (
          ca1 => ca1,
          cb1 => cb1,
          ea1 => ea1,
          eb1 => eb1,
          sa1 => sa1,
          sb1 => sb1,
          operation => operation,
          rounding => rounding,
          r1 => r1
        );
 

   -- Stimulus process
   stim_proc: process
   begin		

        sa1 <= '0';
        sb1 <= '1';
        ca1 <= x"9000050000000000";
        cb1 <= x"0000200000000010";
        ea1 <= "0111010100"; -- 85 with -383 bias
        eb1 <= "0111100011"; -- 100 with -383 bias
        operation <= '0';
        rounding <= "001"; -- roundTiesToAway

        wait for 10 ns;


      wait;
   end process;

END;
