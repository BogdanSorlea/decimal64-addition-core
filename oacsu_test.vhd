--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:54:25 01/18/2015
-- Design Name:   
-- Module Name:   D:/work/vhdl/decimal64-addition-core/oacsu_test.vhd
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
--USE ieee.numeric_std.ALL;
 
ENTITY oacsu_test IS
END oacsu_test;
 
ARCHITECTURE behavior OF oacsu_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT operand_alignment_and_swapping
    PORT(
         ca1 : IN  std_logic_vector(63 downto 0);
         cb1 : IN  std_logic_vector(63 downto 0);
         ea1 : IN  std_logic_vector(9 downto 0);
         eb1 : IN  std_logic_vector(9 downto 0);
         sa1 : IN  std_logic;
         sb1 : IN  std_logic;
         operation : IN  std_logic;
         cas : OUT  std_logic_vector(63 downto 0);
         cbs : OUT  std_logic_vector(63 downto 0);
         lsa : OUT  std_logic_vector(4 downto 0);
         rsa : OUT  std_logic_vector(4 downto 0);
         er1 : OUT  std_logic_vector(9 downto 0);
         eop : OUT  std_logic
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

 	--Outputs
   signal cas : std_logic_vector(63 downto 0);
   signal cbs : std_logic_vector(63 downto 0);
   signal lsa : std_logic_vector(4 downto 0);
   signal rsa : std_logic_vector(4 downto 0);
   signal er1 : std_logic_vector(9 downto 0);
   signal eop : std_logic;
   
   signal zero56 : std_logic_vector(55 downto 0) := (others => '1');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: operand_alignment_and_swapping PORT MAP (
          ca1 => ca1,
          cb1 => cb1,
          ea1 => ea1,
          eb1 => eb1,
          sa1 => sa1,
          sb1 => sb1,
          operation => operation,
          cas => cas,
          cbs => cbs,
          lsa => lsa,
          rsa => rsa,
          er1 => er1,
          eop => eop
        );
 

   -- Stimulus process
   stim_proc: process
   begin		

        wait for 10ns;
        
        ea1 <= (others => '0');
        eb1 <= (others => '0');
        ca1 <= (others => '0');
        cb1 <= (others => '0');
        sa1 <= '0';
        sb1 <= '1';
        operation <= '0';
        wait for 10ns;
        
        ea1 <= "1111111111";
        eb1 <= "1110000000";
        ca1 <= (others => '1');
        cb1 <= (others => '0');
        sa1 <= '1';
        sb1 <= '1';
        operation <= '0';
        wait for 10ns;
        
        ea1 <= "1110011111";
        eb1 <= "1010001100";
        ca1 <= "00000000" & zero56;
        cb1 <= (others => '0');
        sa1 <= '1';
        sb1 <= '1';
        operation <= '1';
        wait for 10ns;

      wait;
   end process;

END;
