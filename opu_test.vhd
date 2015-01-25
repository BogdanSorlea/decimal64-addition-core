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

entity tb_opu is
end tb_opu;

architecture Behavioral of tb_opu is

 COMPONENT opu
    PORT(
           ca2 : in std_logic_vector(63 downto 0);
           cb2 : in std_logic_vector(71 downto 0);
           --for Sign_Inj
           operation : in std_logic;
           eop : in std_logic;
           swap : in std_logic;
           sa1, sb1 : in std_logic;
           rounding : in std_logic_vector(2 downto 0);
           --
           sticky_bit : in std_logic;
           ca3 : out std_logic_vector(75 downto 0);   --19 digits
           cb3 : out std_logic_vector(75 downto 0);
           sign_inj : out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ca2 : std_logic_vector(63 downto 0) := (others => '0');
   signal cb2 : std_logic_vector(71 downto 0) := (others => '0');
   signal operation, sticky_bit, eop, sa1, sb1, swap : std_logic := '0';
   signal rounding : std_logic_vector(2 downto 0);

 	--Outputs
   signal ca3, cb3 : std_logic_vector(75 downto 0);
   signal sign_inj : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: opu PORT MAP (
          ca2 => ca2,
          cb2 => cb2,
          eop => eop,
          swap => swap, 
          sa1 => sa1, 
          sb1 => sb1,
          rounding => rounding,
          operation => operation,
          sticky_bit => sticky_bit, 
          ca3 => ca3,
          cb3 => cb3,
          sign_inj => sign_inj
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      
      ca2 <= X"0000_0000_0000_0000";
      cb2 <= X"00_0000_0000_0000_0000";
      eop <= '0';
      swap <= '0';
      sa1 <= '0';
      sb1 <= '0';
      operation <= '0';
      rounding <= "000";
      sticky_bit <= '0';
     
      wait for 60ns;

      ca2 <= X"0000_0000_0000_0000";
      cb2 <= X"00_0000_0000_0000_0000";
      eop <= '0';
      swap <= '0';
      sa1 <= '0';
      sb1 <= '0';
      operation <= '0';
      rounding <= "000";
      sticky_bit <= '0';
      
      wait for 60ns;
      
     ca2 <= X"0000_0000_0000_0001";
     cb2 <= X"00_0000_0000_0000_0001";
     eop <= '0';
     swap <= '0';
     sa1 <= '0';
     sb1 <= '0';
     operation <= '0';
     rounding <= "001";
     sticky_bit <= '0';
     
      wait for 60ns;
      
      ca2 <= X"0000_0000_0000_0010";
      cb2 <= X"00_0000_0000_0000_0011";
      eop <= '0';
      swap <= '0';
      sa1 <= '1';
      sb1 <= '0';     
      operation <= '0';
      rounding <= "010";
      sticky_bit <= '1';      

        wait for 60ns;
     ca2 <= X"0000_0000_0000_7777";
     cb2 <= X"00_0000_0000_0000_1111";
     eop <= '1';
     swap <= '1';
     sa1 <= '0';
     sb1 <= '1';     
     operation <= '0';
     rounding <= "010";
     sticky_bit <= '0';
     
     wait;
   
   end process;



end Behavioral;
