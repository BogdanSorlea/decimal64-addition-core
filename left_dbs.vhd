----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2015 08:20:40 PM
-- Design Name: 
-- Module Name: DBS - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Left_DBS is
    Port (
     cas : in std_logic_vector(63 downto 0);
     lsa : in  std_logic_vector(4 downto 0);
     ca2 : out std_logic_vector(63 downto 0)   
     );
     
end Left_DBS;

architecture Behavioral of Left_DBS is

signal cas_mux_4, cas_mux_3, cas_mux_2, cas_mux_1, cas_mux_0 : std_logic_vector(63 downto 0); 
signal cas_sl_16, cas_sl_8, cas_sl_4, cas_sl_2, cas_sl_1 : std_logic_vector(63 downto 0);


begin

--cascaded muxes for CB and shift_values
cas_mux_4 <= cas              when lsa(4) = '0' else X"0000_0000_0000_0000" ;
cas_mux_3 <= cas_mux_4        when lsa(3) = '0' else cas(31 downto 0) & X"0000_0000" ;
cas_mux_2 <= cas_mux_3        when lsa(2) = '0' else cas(47 downto 0) & X"0000"; 
cas_mux_1 <= cas_mux_2        when lsa(1) = '0' else cas(55 downto 0) & X"00";
cas_mux_0 <= cas_mux_1        when lsa(0) = '0' else cas(59 downto 0) & X"0";

--cb2 output
ca2 <= cas_mux_0;



end Behavioral;
