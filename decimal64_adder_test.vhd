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
        a, b : in std_logic_vector(63 downto 0);
        operation : in std_logic;
        rounding : in std_logic_vector(2 downto 0);
        
        r1 : out std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(63 downto 0) := (others => '0');
   signal b : std_logic_vector(63 downto 0) := (others => '0');
   signal operation : std_logic := '0';
   signal rounding : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal r1 : std_logic_vector(63 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decimal64_adder_no_conversions PORT MAP (
          a => a,
          b => b,
          operation => operation,
          rounding => rounding,
          r1 => r1
        );
 

   -- Stimulus process
   stim_proc: process
   begin		

        a <= "0" & "11011" & "11010100" 
                & "0000000000" & "0001010000" & "0000000000" & "0000000000" & "0000000000"; -- + 9000050000000000 e85
        b <= "1" & "01000" & "11100011" 
                & "0000000000" & "0100000000" & "0000000000" & "0000000000" & "0000010000"; -- - 0000200000000010 e100
        operation <= '0';
        rounding <= "001"; -- roundTiesToAway
        -- r1 should be: + 2000000000010000 e96
        -- which in decimal64 DPD is
        -- 0_01010_11011111_0000000000_0000000000_0000000000_0000010000_0000000000
        -- aka 2B7C000000004000
        -- TODO: figure out why sign is wrong
        wait for 10 ns;


      wait;
   end process;

END;
