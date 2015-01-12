--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:13:05 01/12/2015
-- Design Name:   
-- Module Name:   D:/work/vhdl/decimal64-addition-core/dpd_decoder_test.vhd
-- Project Name:  decimal64-addition-core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dpd_decoder
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
 
ENTITY dpd_decoder_test IS
END dpd_decoder_test;
 
ARCHITECTURE behavior OF dpd_decoder_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dpd_decoder
    PORT(
         input : IN  std_logic_vector(9 downto 0);
         output : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(11 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dpd_decoder PORT MAP (
          input => input,
          output => output
        );
 
	-- TODO: extend test for each case (similarly to the commented lines - i.e. more test for each case)

   -- Stimulus process
   stim_proc: process
   begin		
		
		wait for 10ns;
		input <= "1111110111";
      wait for 10ns;
		--input <= "1011010101";
		--wait for 10ns;
		--input <= "0100100010";
		--wait for 10ns;
		input <= "1111111001";
      wait for 10ns;
		input <= "1111111011";
      wait for 10ns;
		input <= "1111111101";
      wait for 10ns;
		input <= "1110011111";
      wait for 10ns;
		input <= "1110111111";
      wait for 10ns;
		input <= "1111011111";
      wait for 10ns;
		input <= "ZZ11111111";
      wait for 10ns;

      -- insert stimulus here 

      wait;
   end process;

END;
