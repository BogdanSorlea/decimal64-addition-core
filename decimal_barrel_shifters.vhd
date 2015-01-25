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

entity dbs is
    port (
        cas : in std_logic_vector(63 downto 0);
        cbs : in std_logic_vector(63 downto 0);
        rsa : in  std_logic_vector(4 downto 0);
        lsa : in  std_logic_vector(4 downto 0);
        ca2 : out std_logic_vector(63 downto 0);
        cb2 : out std_logic_vector(71 downto 0);
        sticky : out std_logic     
    );
     
end dbs;

architecture Behavioral of dbs is

signal cas_s, ca2_s : std_logic_vector(63 downto 0);
signal cbs_s : std_logic_vector(63 downto 0);
signal cb2_s : std_logic_vector(71 downto 0);
signal rsa_s, lsa_s : std_logic_vector(4 downto 0);
signal sticky_s : std_logic;  

component LDBS 
    port (
        cas : in std_logic_vector(63 downto 0);
        lsa : in  std_logic_vector(4 downto 0);
        ca2 : out std_logic_vector(63 downto 0)   
    );
end component;

component RDBS 
    port (
        cbs : in std_logic_vector(63 downto 0);
        rsa : in  std_logic_vector(4 downto 0);
        cb2 : out std_logic_vector(71 downto 0);
        sticky : out std_logic     
    );
end component;

begin

    --inputs
    cbs_s <= cbs;
    cas_s <= cas;
    rsa_s <= rsa;
    lsa_s <= lsa;

    rdbs_i: RDBS port map (
        cbs => cbs_s,
        rsa => rsa_s,
        cb2 => cb2_s,
        sticky => sticky_s
    );
        
    ldbs_i: LDBS port map (
        cas => cas_s,
        lsa => lsa_s,
        ca2 => ca2_s
    );    

    --outputs
    ca2 <= ca2_s;
    cb2 <= cb2_s;
    sticky <= sticky_s;

end Behavioral;
