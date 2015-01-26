----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2015 04:04:38 PM
-- Design Name: 
-- Module Name: forward_format_conversion_unit - Behavioral
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

entity forward_format_conversion_unit is
    port (
        a, b : in std_logic_vector(63 downto 0);
        sa1, sb1 : out std_logic;
        ea1, eb1 : out std_logic_vector(9 downto 0);
        ca1, cb1 : out std_logic_vector(63 downto 0)
    );
end forward_format_conversion_unit;

architecture Behavioral of forward_format_conversion_unit is

    component dpd_decoder
        port (
            input : in std_logic_vector(9 downto 0);
            output : out std_logic_vector(11 downto 0)
        );
    end component;

    signal esela, eselb : std_logic_vector(1 downto 0);

begin

    sa1 <= a(63);
    sb1 <= b(63);
    
    -- http://en.wikipedia.org/wiki/Decimal64_floating-point_format#Densely_packed_decimal_significand_field
    
    esela <= a(62 downto 61);
    eselb <= b(62 downto 61);
    ea1 <= esela & a(57 downto 50) when esela = "00" or esela = "01" or esela = "10" else
            a(60 downto 59) & a(57 downto 50);
    eb1 <= eselb & b(57 downto 50) when eselb = "00" or eselb = "01" or eselb = "10" else
            b(60 downto 59) & b(57 downto 50);

    ca1(63 downto 60) <= "0" & a(60 downto 58) when esela = "00" or esela = "01" or esela = "10" 
                            else "100" & a(58);         
    cb1(63 downto 60) <= "0" & b(60 downto 58) when eselb = "00" or eselb = "01" or eselb = "10" 
                            else "100" & b(58);
    
    -- for generate this shit
    
    dpd_decode_a0 : dpd_decoder port map (
        input => a(9 downto 0),
        output => ca1(11 downto 0)
    );
    
    dpd_decode_a1 : dpd_decoder port map (
        input => a(19 downto 10),
        output => ca1(23 downto 12)
    );
        
    dpd_decode_a2 : dpd_decoder port map (
        input => a(29 downto 20),
        output => ca1(35 downto 24)
    );
            
    dpd_decode_a3 : dpd_decoder port map (
        input => a(39 downto 30),
        output => ca1(47 downto 36)
    );
    
    dpd_decode_a4 : dpd_decoder port map (
        input => a(49 downto 40),
        output => ca1(59 downto 48)
    );
    
    dpd_decode_b0 : dpd_decoder port map (
        input => b(9 downto 0),
        output => cb1(11 downto 0)
    );
    
    dpd_decode_b1 : dpd_decoder port map (
        input => b(19 downto 10),
        output => cb1(23 downto 12)
    );
        
    dpd_decode_b2 : dpd_decoder port map (
        input => b(29 downto 20),
        output => cb1(35 downto 24)
    );
            
    dpd_decode_b3 : dpd_decoder port map (
        input => b(39 downto 30),
        output => cb1(47 downto 36)
    );
    
    dpd_decode_b4 : dpd_decoder port map (
        input => b(49 downto 40),
        output => cb1(59 downto 48)
    );
    

end Behavioral;
