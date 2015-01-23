----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:25:30 01/21/2015 
-- Design Name: 
-- Module Name:    adder - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is

    generic (
        width : natural := 4
    );
    
    port (
        a, b : in std_logic_vector(width-1 downto 0);
        cin : in std_logic;
        
        sum : out std_logic_vector(width-1 downto 0);
        cout : out std_logic
    );

end adder;

architecture Behavioral of adder is

    signal tmp_sum : std_logic_vector(width downto 0);
    signal tmp_cin : std_logic_vector(1 downto 0);

begin
    
    tmp_cin <= "0" & cin;
    tmp_sum <= std_logic_vector(unsigned("0" & a) + unsigned(b) + unsigned(tmp_cin));
    sum <= tmp_sum(width-1 downto 0);
    cout <= tmp_sum(width);

end Behavioral;

