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
     cbs : in std_logic_vector(4 downto 0);
     rsa : in  std_logic_vector(4 downto 0);
     lsa : in  std_logic_vector(4 downto 0);
     ca2 : out std_logic_vector(63 downto 0);
     cb2 : out std_logic_vector(63 downto 0)
     );
     
end DBS;

architecture Behavioral of DBS is

signal cbs_mux_4, cbs_mux_3, cbs_mux_2, cbs_mux_1, cbs_mux_0 : std_logic_vector(81 downto 0); 
signal cbs_srr_16, cbs_srr_8, cbs_srr_4, cbs_srr_2, cbs_srr_1 : std_logic_vector(81 downto 0);
signal t4, t3, t2, t1, t0 : std_logic;
signal t4_v, t3_v, t2_v, t1_V, t0_V : std_logic := '0';
signal m4, m3, m2, m1, m0 : std_logic;  
signal sticky : std_logic;


begin

--right shifters for CB
cbs_srr_16 <= "0000000000000000" & cbs(81 downto 15 );
cbs_srr_8 <= "00000000" & cbs(81 downto 7 );
cbs_srr_4 <= "0000" & cbs(81 downto 3 );
cbs_srr_2 <= "00" & cbs(81 downto 1 );


--cascaded muxes for CB
cbs_mux_4 <= cbs & "00000000" when rsa(4) = '0' else cbs_srr_16;
cbs_mux_3 <= cbs_mux_4        when rsa(3) = '0' else cbs_srr_8;
cbs_mux_2 <= cbs_mux_3        when rsa(2) = '0' else cbs_srr_4; 
cbs_mux_1 <= cbs_mux_2        when rsa(1) = '0' else cbs_srr_2;
cbs_mux_0 <= cbs_mux_1        when rsa(0) = '0' else cbs;


--sticky bit generation
--T bits


process(cbs)
begin
variable t4_v : bit := '0';
for i in cbs'range loop:
  t4_v := t4_v xor cbs(i);
end loop;
end process;
t4 <= t4_v;


process(cbs_mux_4)
begin
variable i : natural;
for i in cbs_mux_4(31 downto 0)'range loop:
  t3_v := t3_v xor cbs_mux_4(i);
end loop;
t3 <= t3_v;
end process;

process(cbs_mux_3)
begin
variable i natural;
for i in cbs_mux_3(15 downto 0)'range loop:
  t2_v := t2_v xor cbs_mux_3(i);
end loop;
t2 <= t2_v;
end process;

process(cbs_mux2)
begin
variable i natural;
for i in cbs_mux_2(7 downto 0)'range loop:
  t1_v := t1_v xor cbs_mux_2(i);
end loop;
t1 <= t1_v;
end process;

process(cbs_mux_1)
begin
variable i natural;
for i in cbs_mux_1(3 downto 0)'range loop:
  t0_v := t0_v xor cbs_mux_1(i);
end loop;
t0 <= t0_v;
end process;

--masking t*

m4 <= t4 and rsa(4);
m3 <= t3 and rsa(3);
m2 <= t2 and rsa(2);
m1 <= t1 and rsa(1);
m0 <= t0 and rsa(0);
 
--sticky bit
sticky <= m0 or m1 or m2 or m3 or m4;  

end Behavioral;
