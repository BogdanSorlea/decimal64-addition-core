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

entity Right_DBS is
    Port (
     cbs : in std_logic_vector(63 downto 0);
     rsa : in  std_logic_vector(4 downto 0);
     cb2 : out std_logic_vector(71 downto 0);
     sticky : out std_logic     
     );
     
end Right_DBS;

architecture Behavioral of Right_DBS is

signal cbs_e,cbs_mux_4, cbs_mux_3, cbs_mux_2, cbs_mux_1, cbs_mux_0 : std_logic_vector(71 downto 0); 
signal cbs_srr_16, cbs_srr_8, cbs_srr_4, cbs_srr_2, cbs_srr_1 : std_logic_vector(71 downto 0);
signal t4, t3, t2, t1, t0 : std_logic;
signal m4, m3, m2, m1, m0 : std_logic;  

----for masking T bits
--signal cbs_t4 : std_logic_vector(63 downto 0);
--signal cbs_t3 : std_logic_vector(31 downto 0);
--signal cbs_t2 : std_logic_vector(15 downto 0);
--signal cbs_t1 : std_logic_vector(7 downto 0);
--signal cbs_t0 : std_logic_vector(3 downto 0);

begin
    

    
    cbs_e <= cbs & "00000000";

--cascaded muxes for CB
    cbs_mux_4 <= cbs_e      when rsa(4) = '0' else X"0000_0000_0000_0000" & cbs_e(71 downto 64); 
    cbs_mux_3 <= cbs_mux_4  when rsa(3) = '0' else X"0000_0000" & cbs_mux_4(71 downto 32);
    cbs_mux_2 <= cbs_mux_3  when rsa(2) = '0' else X"0000" & cbs_mux_3(71 downto 16);
    cbs_mux_1 <= cbs_mux_2  when rsa(1) = '0' else X"00" & cbs_mux_2(71 downto 8);
    cbs_mux_0 <= cbs_mux_1  when rsa(0) = '0' else X"0" & cbs_mux_1(71 downto 4);

--cb2 output
    cb2 <= cbs_mux_0;

--sticky bit generation
--T bits

t4 <= cbs(0) or cbs(1) or cbs(2) or cbs(3) or cbs(4) or cbs(5) or cbs(6) or cbs(7)
      or cbs(8) or cbs(9) or cbs(10) or cbs(11) or cbs(12) or cbs(13) or cbs(14) or cbs(15)
      or cbs(16) or cbs(17) or cbs(18) or cbs(19) or cbs(20) or cbs(21) or cbs(22) or cbs(23)
      or cbs(24) or cbs(25) or cbs(26) or cbs(27) or cbs(28) or cbs(29) or cbs(30) or cbs(31)
      or cbs(32) or cbs(33) or cbs(34) or cbs(35) or cbs(36) or cbs(37) or cbs(38) or cbs(39)
      or cbs(40) or cbs(41) or cbs(42) or cbs(43) or cbs(44) or cbs(45) or cbs(46) or cbs(47)
      or cbs(48) or cbs(49) or cbs(50) or cbs(51) or cbs(52) or cbs(53) or cbs(54) or cbs(55)
      or cbs(56) or cbs(57) or cbs(58) or cbs(59) or cbs(60) or cbs(61) or cbs(62) or cbs(63);
--process(cbs)
--  variable i : natural;
--  variable temp: std_logic := '0';
--begin
--  for i in cbs'range loop
--    temp :=  temp or cbs(i);
--  end loop;
--  t4 <= temp;
--end process;

t3 <= cbs_mux_4(0) or cbs_mux_4(1) or cbs_mux_4(2) or cbs_mux_4(3) or cbs_mux_4(4) or cbs_mux_4(5) or cbs_mux_4(6) or cbs_mux_4(7)
      or cbs_mux_4(8) or cbs_mux_4(9) or cbs_mux_4(10) or cbs_mux_4(11) or cbs_mux_4(12) or cbs_mux_4(13) or cbs_mux_4(14) or cbs_mux_4(15)
      or cbs_mux_4(16) or cbs_mux_4(17) or cbs_mux_4(18) or cbs_mux_4(19) or cbs_mux_4(20) or cbs_mux_4(21) or cbs_mux_4(22) or cbs_mux_4(23)
            or cbs_mux_4(24) or cbs_mux_4(25) or cbs_mux_4(26) or cbs_mux_4(27) or cbs_mux_4(28) or cbs_mux_4(29) or cbs_mux_4(30) or cbs_mux_4(31);

--process(cbs_t3)
--  variable i : natural;
--  variable t3_v: std_logic := '0';
--begin
--  for i in cbs_t3'range loop
--    t3_v := t3_v or cbs_t3(i);
--  end loop;
--t3 <= t3_v;
--end process;

t2 <= cbs_mux_3(0) or cbs_mux_3(1) or cbs_mux_3(2) or cbs_mux_3(3) or cbs_mux_3(4) or cbs_mux_3(5) or cbs_mux_3(6) or cbs_mux_3(7)
      or cbs_mux_3(8) or cbs_mux_3(9) or cbs_mux_3(10) or cbs_mux_3(11) or cbs_mux_3(12) or cbs_mux_3(13) or cbs_mux_3(14) or cbs_mux_3(15);
--process(cbs_t2)
--  variable i : natural;
--  variable t2_v: std_logic := '0';
--begin
--  for i in cbs_t2'range loop
--    t2_v := t2_v or cbs_t2(i);
--  end loop;
--t2 <= t2_v;
--end process;

t1 <= cbs_mux_2(0) or cbs_mux_2(1) or cbs_mux_2(2) or cbs_mux_2(3) or cbs_mux_2(4) or cbs_mux_2(5) or cbs_mux_2(6) or cbs_mux_2(7);

--process(cbs_t1)
--  variable i:  natural;
--   variable t1_v: std_logic := '0';
--begin
--  for i in cbs_t1'range loop
--    t1_v := t1_v or cbs_t1(i);
--  end loop;
--t1 <= t1_v;
--end process;


t0 <= cbs_mux_1(0) or cbs_mux_1(1) or cbs_mux_1(2) or cbs_mux_1(3); 

--process(cbs_t0)
--  variable i:  natural;
--  variable t0_v: std_logic := '0';
--begin
--  for i in cbs_t0'range loop
--    t0_v := t0_v or cbs_t0(i);
--  end loop;
--t0 <= t0_v;
--end process;

--masking t*

    m4 <= t4 and rsa(4);
    m3 <= t3 and rsa(3);
    m2 <= t2 and rsa(2);
    m1 <= t1 and rsa(1);
    m0 <= t0 and rsa(0);
 
--sticky bit
    sticky <= m0 or m1 or m2 or m3 or m4;  



end Behavioral;
