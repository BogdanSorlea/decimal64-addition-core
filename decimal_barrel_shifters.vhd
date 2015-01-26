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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decimal_barrel_shifters is
    port (
        cas : in std_logic_vector(63 downto 0);
        cbs : in std_logic_vector(63 downto 0);
        rsa : in  std_logic_vector(4 downto 0);
        lsa : in  std_logic_vector(4 downto 0);
        ca2 : out std_logic_vector(63 downto 0);
        cb2 : out std_logic_vector(71 downto 0);
        sticky : out std_logic     
    );
     
end decimal_barrel_shifters;

architecture Behavioral of decimal_barrel_shifters is

signal cas_s, ca2_s : std_logic_vector(63 downto 0);
signal cbs_s : std_logic_vector(63 downto 0);
signal cb2_s : std_logic_vector(71 downto 0);
signal rsa_s, lsa_s : std_logic_vector(4 downto 0);
signal sticky_s : std_logic;  

component left_dbs 
    port (
        cas : in std_logic_vector(63 downto 0);
        lsa : in  std_logic_vector(4 downto 0);
        ca2 : out std_logic_vector(63 downto 0)   
    );
end component;

component right_dbs 
    port (
        cbs : in std_logic_vector(63 downto 0);
        rsa : in  std_logic_vector(4 downto 0);
        cb2 : out std_logic_vector(71 downto 0);
        sticky : out std_logic     
    );
end component;

begin



    rdbs_i: RIGHT_DBS port map (
        cbs => cbs,
        rsa => rsa,
        cb2 => cb2,
        sticky => sticky
    );
        
    ldbs_i: LEFT_DBS port map (
        cas => cas,
        lsa => lsa,
        ca2 => ca2
    );    



end Behavioral;
