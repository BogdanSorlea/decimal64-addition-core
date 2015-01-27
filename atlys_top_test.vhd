--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:02:03 01/27/2015
-- Design Name:   
-- Module Name:   D:/work/vhdl/decimal64-addition-core/atlys_top_test.vhd
-- Project Name:  decimal64-addition-core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: atlys_top
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
 
ENTITY atlys_top_test IS
END atlys_top_test;
 
ARCHITECTURE behavior OF atlys_top_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT atlys_top
    PORT(
         sw : IN  std_logic_vector(7 downto 0);
         --btn : IN  std_logic;
         --clk : IN  std_logic;
         rst : IN  std_logic;
         step : IN  std_logic;
         led : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sw : std_logic_vector(7 downto 0) := (others => '0');
   --signal btn : std_logic := '0';
   --signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal step : std_logic := '0';

 	--Outputs
   signal led : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: atlys_top PORT MAP (
          sw => sw,
          --btn => btn,
          --clk => clk,
          rst => rst,
          step => step,
          led => led
        );

   -- Clock process definitions
   clk_process :process
   begin
		step <= '0';
		wait for clk_period/2;
		step <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '1';
      wait for 100 ns;	
      
      -------------------------------------------
      --b <= "1" & "01000" & "11100011" 
      --          & "0000000000" & "0100000000" & "0000000000" & "0000000000" & "0000010000"; -- - 0000200000000010 e100
      -- A38C004000000010
      
      sw <= "00010000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "00000000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "00000000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "00000000";
      rst <= '0';
      wait for clk_period;
      
      ---
      
      sw <= "01000000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "00000000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "10001100";
      rst <= '0';
      wait for clk_period;
      
      sw <= "10100011";
      rst <= '0';
      wait for clk_period;
      
      -----------------------------------
      --a <= "0" & "11011" & "11010100" 
      --          & "0000000000" & "0001010000" & "0000000000" & "0000000000" & "0000000000"; -- + 9000050000000000 e85
      -- 6F50001400000000
      
      sw <= "00000000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "00000000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "00000000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "00000000";
      rst <= '0';
      wait for clk_period;
      
      ---
      
      sw <= "00010100";
      rst <= '0';
      wait for clk_period;
      
      sw <= "00000000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "01010000";
      rst <= '0';
      wait for clk_period;
      
      sw <= "01101111";
      --sw <= "11111111";
      rst <= '0';
      wait for clk_period;
      
      -----------------------------
      
      sw <= "00000010";
      rst <= '0';
      wait for clk_period;
      
      wait for clk_period;

      -- insert stimulus here 

      wait;
   end process;

END;
