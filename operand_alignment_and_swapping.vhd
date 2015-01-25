----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2015 07:39:52 PM
-- Design Name: 
-- Module Name: operand_alignment_and_swapping - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity operand_alignment_and_swapping is
    port (
        ca1, cb1 : in std_logic_vector(63 downto 0);
        ea1, eb1 : in std_logic_vector(9 downto 0);
        sa1, sb1, operation : in std_logic;
		  
        cas, cbs : out std_logic_vector(63 downto 0);
        lsa, rsa : out std_logic_vector(4 downto 0);
        er1 : out std_logic_vector(9 downto 0);
        eop, swap : out std_logic
    );
end operand_alignment_and_swapping;

architecture Behavioral of operand_alignment_and_swapping is
    signal tmp_swap, lsa_select_las : std_logic;
    -- exponent is biased by +398;
    signal diffab, diffba, abs_ediff, rsa_maxterm, rsa_maxterm_diff, rsa_tmp : unsigned(9 downto 0);
    signal la1, lb1, las, lsa_tmp : unsigned(4 downto 0);
    signal eas : std_logic_vector(9 downto 0);

begin

    -- eac
    diffab <= unsigned(ea1) - unsigned(eb1);
    diffba <= unsigned(eb1) - unsigned(ea1);
    tmp_swap <= '1' when unsigned(eb1) > unsigned(ea1) else '0';
    abs_ediff <= diffba when unsigned(eb1) > unsigned(ea1) else diffab;
    
    -- significand swapping
    cas <= cb1 when tmp_swap = '1' else ca1;
    cbs <= ca1 when tmp_swap = '1' else cb1;
    
    -- eas MUX
    eas <= ea1 when tmp_swap = '0' else eb1;
    
    -- lead zero detection (LZD)
    lzd_a: process(ca1)
        variable i : natural := 0;
        variable lz : natural;
    begin
        lz := 0;
        for i in 15 downto 0 loop
            if unsigned(ca1(4*(i+1)-1 downto 4*i)) = 0 then
                lz := 16-i;
            else
                exit;
            end if;
		end loop;
        la1 <= to_unsigned(lz, 5);
    end process;
    
    lzd_b: process(cb1)
        variable i : natural := 0;
        variable lz : natural;
    begin
        lz := 0;
        for i in 15 downto 0 loop
            if unsigned(cb1(4*(i+1)-1 downto 4*i)) = 0 then
                lz := 16-i;
            else
                exit;
			end if;
		end loop;
        lb1 <= to_unsigned(lz, 5);
    end process;
    
    -- las MUX
    las <= lb1 when tmp_swap = '1' else la1;
    
    -- rsa_maxterm, rsa, lsa_select_las and lsa
    rsa_maxterm_diff <= abs_ediff - las;
    rsa_maxterm <= rsa_maxterm_diff when rsa_maxterm_diff > 0 else to_unsigned(0, rsa_maxterm'length);
    rsa_tmp <= rsa_maxterm when rsa_maxterm < to_unsigned(19, rsa_maxterm'length) 
                    else to_unsigned(19, rsa_maxterm'length);
    lsa_select_las <= '1' when unsigned(abs_ediff) - unsigned(las) > 0 else '0';
    lsa_tmp <= las when lsa_select_las = '1' else abs_ediff(4 downto 0);
    rsa <= std_logic_vector(resize(rsa_tmp, 5));
    lsa <= std_logic_vector(lsa_tmp);
    
    -- er1
    er1 <= std_logic_vector(unsigned(eas) - lsa_tmp);
    
    -- eop
    eop <= sa1 xor sb1 xor operation;
    
    -- swap
    swap <= tmp_swap;

end Behavioral;
