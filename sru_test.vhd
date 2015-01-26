----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2015 11:17:16 PM
-- Design Name: 
-- Module Name: test_dbs - Behavioral
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

entity test_dbs is
end test_dbs;

architecture Behavioral of test_dbs is

component DBS 
    Port (
     cas : in std_logic_vector(63 downto 0);
     cbs : in std_logic_vector(63 downto 0);
     rsa : in  std_logic_vector(4 downto 0);
     lsa : in  std_logic_vector(4 downto 0);
     ca2 : out std_logic_vector(63 downto 0);
     cb2 : out std_logic_vector(71 downto 0);
     sticky : out std_logic     
     );
end component;


signal cas, cbs : std_logic_vector(63 downto 0);
signal rsa, lsa : std_logic_vector(4 downto 0); 

--outputs
signal  sticky : std_logic;
signal ca2 : std_logic_vector(63 downto 0);
signal cb2 :std_logic_vector(71 downto 0);
    
     

begin

	-- Instantiate the Unit Under Test (UUT)
   uut: DBS PORT MAP (
          cas => cas,
          cbs => cbs,
          rsa => rsa,
          lsa => lsa, 
          ca2 => ca2, 
          cb2 => cb2,
          sticky => sticky 
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      
      cas <= X"0000_0000_0000_0000";
      cbs <= X"0000_0000_0000_0000";
      rsa <= "00000";
      lsa <= "00000";
      
     
      wait for 60ns;

      cas <= X"0000_2000_0000_0010";
      cbs <= X"9000_0500_0000_0000";
      rsa <= "01011";
      lsa <= "00100";      
      
     
     wait;
   
   end process;


end Behavioral;
