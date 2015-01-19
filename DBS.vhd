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

entity DBS is
    Port (
     cas : in std_logic_vector(63 downto 0);
     cbs : in std_logic_vector(63 downto 0);
     rsa : in  std_logic_vector(4 downto 0);
     lsa : in  std_logic_vector(4 downto 0);
     ca2 : out std_logic_vector(63 downto 0);
     cb2 : out std_logic_vector(63 downto 0)
     );
     
end DBS;

architecture Behavioral of DBS is

signal cbs_mux_4, cbs_mux_3, cbs_mux_2, cbs_mux_1, cbs_mux_0 : std_logic_vector(71 downto 0); 
signal cbs_srr_16, cbs_srr_8, cbs_srr_4, cbs_srr_2, cbs_srr_1 : std_logic_vector(63 downto 0);
signal t4, t3, t2, t1, t0 : std_logic;
signal t4_v, t3_v, t2_v, t1_V, t0_V : std_logic := '0';
signal m4, m3, m2, m1, m0 : std_logic;  
signal sticky : std_logic;


begin

--right shifters for CB
cbs_srr_16 <= "0000000000000000" & cbs(63 downto 16 );
cbs_srr_8 <= "00000000" & cbs(63 downto 8 );
cbs_srr_4 <= "0000" & cbs(63 downto 4 );
cbs_srr_2 <= "00" & cbs(63 downto 2 );


--cascaded muxes for CB
cbs_mux_4 <= cbs & "00000000" when rsa(4) = '0' else cbs_srr_16 & "00000000";
cbs_mux_3 <= cbs_mux_4        when rsa(3) = '0' else cbs_srr_8 & "00000000";
cbs_mux_2 <= cbs_mux_3        when rsa(2) = '0' else cbs_srr_4 & "00000000"; 
cbs_mux_1 <= cbs_mux_2        when rsa(1) = '0' else cbs_srr_2 & "00000000";
cbs_mux_0 <= cbs_mux_1        when rsa(0) = '0' else cbs & "00000000";


--sticky bit generation
--T bits


process(cbs)
  variable i : natural;
begin
  for i in 63 downto 0 loop
    t4_v <= t4_v xor cbs(i);
  end loop;
end process;
t4 <= t4_v;


process(cbs_mux_4)
  variable i : natural;
begin
  for i in 31 downto 0 loop
    t3_v <= t3_v xor cbs_mux_4(i);
  end loop;
end process;
t3 <= t3_v;

process(cbs_mux_3)
  variable i : natural;
begin
  for i in 15 downto 0 loop
    t2_v <= t2_v xor cbs_mux_3(i);
  end loop;
end process;
t2 <= t2_v;

process(cbs_mux_2)
  variable i:  natural;
begin
  for i in 7 downto 0 loop
    t1_v <= t1_v xor cbs_mux_2(i);
  end loop;
end process;
t1 <= t1_v;

process(cbs_mux_1)
  variable i:  natural;
begin
  for i in 3 downto 0 loop
    t0_v <= t0_v xor cbs_mux_1(i);
  end loop;
end process;
t0 <= t0_v;
--masking t*

m4 <= t4 and rsa(4);
m3 <= t3 and rsa(3);
m2 <= t2 and rsa(2);
m1 <= t1 and rsa(1);
m0 <= t0 and rsa(0);
 
--sticky bit
sticky <= m0 or m1 or m2 or m3 or m4;  

end Behavioral;
