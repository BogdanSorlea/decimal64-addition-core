----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:09:52 01/24/2015 
-- Design Name: 
-- Module Name:    sign_unit - Behavioral 
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

entity sign_unit is

    port (
        eop, sa1, swap, c1_msb : in std_logic;
        sr1 : out std_logic
    );

end sign_unit;

architecture Behavioral of sign_unit is

begin

    sr1 <= ((not eop) and sa1) or (eop and ((not swap) xor sa1 xor c1_msb));

end Behavioral;

