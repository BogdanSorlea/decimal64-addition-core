----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2015 07:39:52 PM
-- Design Name: 
-- Module Name: operand_alignment_and_swapping - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity operand_alignment_and_swapping is
    port (
        ca1, cb1 : in std_logic_vector(63 downto 0);
        sa1, sb1 : in std_logic;
        ea1, eb1 : in std_logic_vector(9 downto 0);
        cas, cbs : out std_logic_vector(63 downto 0);
		  lsa : out natural;
        er1 : out std_logic_vector(9 downto 0)
    );
end operand_alignment_and_swapping;

architecture Behavioral of operand_alignment_and_swapping is

	signal tmp_cas : std_logic_vector(63 downto 0);
	signal eas : std_logic_vector(9 downto 0);
	signal las : natural := 0;

begin

    tmp_cas <= cb1 when unsigned(eb1) - unsigned(ea1) > 0 else ca1;
	 cas <= tmp_cas;
    cbs <= ca1 when unsigned(eb1) - unsigned(ea1) > 0 else cb1;
    
	 process(tmp_cas)
		variable i : natural;
	 begin
		for i in 15 downto 0 loop
			if tmp_cas(4*(i+1)-1 downto 4*i) = "0000" then
				las <= 16-i;
			end if;
		end loop;
	 end process;
	 
	 lsa <= las;
	 
    er1 <= (others => '0');--when unsigned(eb1) - unsigned(ea1) > 0 else ;

end Behavioral;
