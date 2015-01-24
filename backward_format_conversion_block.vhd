----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:05:22 01/24/2015 
-- Design Name: 
-- Module Name:    backward_format_conversion_block - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity backward_format_conversion_block is
    
    port (
        sr1 : in std_logic;
        er2 : in std_logic_vector(9 downto 0);
        cr2 : in std_logic_vector(63 downto 0);
        
        r1 : out std_logic_vector(63 downto 0)
    );

end backward_format_conversion_block;

architecture Behavioral of backward_format_conversion_block is

    component dpd_encode is

        port(
            digit_group : in std_logic_vector(11 downto 0);
            dpd_group : out std_logic_vector(9 downto 0)
        );

    end component;
    
    signal i : natural := 0;

begin

    r1(63) <= sr1;
    r1(62 downto 61) <= "11" when cr2(63 downto 61) = "100" else er2(9 downto 8);
    r1(60 downto 59) <= er2(9 downto 8) when cr2(63 downto 61) = "100" else cr2(62 downto 61);
    r1(58) <= cr2(60);
    r1(57 downto 50) <= er2(7 downto 0);
    
    dpd_encoding: for i in 0 to 4 generate
    begin
        dpd_encoder_block: component dpd_encode port map (
            digit_group => cr2(12*(i+1)-1 downto 12*i),
            dpd_group => r1(10*(i+1)-1 downto 10*i)
        );
    end generate;
    

end Behavioral;

