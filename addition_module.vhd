----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:39:09 01/21/2015 
-- Design Name: 
-- Module Name:    addition_module - Behavioral 
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

entity addition_module is

    port (
        ca3, cb3 : in std_logic_vector(75 downto 0);
        eop : in std_logic;
        
        f2 : out std_logic_vector(15 downto 0);
        c1 : out std_logic_vector(18 downto 0);
        ucr, f1 : out std_logic_vector(75 downto 0)
    );

end addition_module;

architecture Behavioral of addition_module is

    type flag is array (0 to 4) of std_logic_vector(15 downto 0);

    component adder is
        generic (
            width : natural := 4
        );
        
        port (
            a, b : in std_logic_vector(width-1 downto 0);
            cin : in std_logic;
            
            sum : out std_logic_vector(width-1 downto 0);
            cout : out std_logic
        );
    end component adder;
    
    signal i : natural;
    signal tmp_c1 : std_logic_vector(19 downto 0);
    signal tmp_f1 : std_logic_vector(75 downto 0) := (others => '0');
    signal tmp_ucr : std_logic_vector(75 downto 0);
    signal tmp_ucr_f2gen : std_logic_vector(63 downto 0);
    signal tmp_f2 : std_logic_vector(15 downto 0);
    signal flag_add, flag_sub : flag;
    signal grs_propagate : std_logic;

begin
    
    tmp_c1(0) <= '0';
    
    initial_addition: for i in 18 downto 0 generate
        digit_i_addition: adder 
            generic map (width => 4) 
            port map (
                a => ca3((i+1)*4-1 downto i*4), 
                b => cb3((i+1)*4-1 downto i*4), 
                cin => tmp_c1(i), 
                sum => tmp_ucr((i+1)*4-1 downto i*4),
                cout => tmp_c1(i+1)
            );
    end generate;
    
    f1_generate: process(tmp_ucr, tmp_f1)
        variable i: natural := 0;
    begin
        
        tmp_f1(0) <= tmp_ucr(0);
        for i in 1 to 75 loop
            if tmp_ucr(i) = '1' and tmp_f1(i-1) = '1' then
                tmp_f1(i) <= '1';
            else
                tmp_f1(i) <= '0';
            end if;
        end loop;
        
    end process;
    
    flag_add_sub_generate: process(tmp_ucr_f2gen, tmp_c1, grs_propagate, flag_add, flag_sub)
        variable i : natural := 0;
    begin
    
        for i in 0 to 15 loop
            if tmp_ucr_f2gen((i+1)*4-1 downto i*4) = "1111" 
                    or (tmp_ucr_f2gen((i+1)*4-1 downto i*4) = "1001" and tmp_c1(i+1) = '1') then
                flag_add(0)(i) <= '1';
            else
                flag_add(0)(i) <= '0';
            end if;
        end loop;

        if (tmp_ucr_f2gen(3 downto 0) = "1111" and grs_propagate = '0')
            or (tmp_ucr_f2gen(3 downto 0) = "1110" and grs_propagate = '1') then
            flag_sub(0)(0) <= '1';
        else
            flag_sub(0)(0) <= '0';
        end if;
        
        for i in 1 to 15 loop
            if (tmp_ucr_f2gen((i+1)*4-1 downto i*4) = "1111" and grs_propagate = '0')
                                        or (tmp_ucr_f2gen((i+1)*4-1 downto i*4) = "1110" and grs_propagate = '1') then
                flag_sub(0)(i) <= '1';
            else
                flag_sub(0)(i) <= '0';
            end if;
        end loop;
        
        flag_add(1)(0) <= flag_add(0)(0);
        flag_sub(1)(0) <= flag_sub(0)(0);
        for i in 1 to 15 loop
            flag_add(1)(i) <= flag_add(0)(i) and flag_add(0)(i-1);
            flag_sub(1)(i) <= flag_sub(0)(i) and flag_sub(0)(i-1);
        end loop;
        
        flag_add(2)(2 downto 0) <= flag_add(1)(2 downto 0);
        flag_sub(2)(2 downto 0) <= flag_sub(1)(2 downto 0);
        for i in 3 to 15 loop
            flag_add(2)(i) <= flag_add(1)(i) and flag_add(1)(i-2);
            flag_sub(2)(i) <= flag_sub(1)(i) and flag_sub(1)(i-2);
        end loop;
        
        flag_add(3)(4 downto 0) <= flag_add(2)(4 downto 0);
        flag_sub(3)(4 downto 0) <= flag_sub(2)(4 downto 0);
        for i in 5 to 15 loop
            flag_add(3)(i) <= flag_add(2)(i) and flag_add(2)(i-4);
            flag_sub(3)(i) <= flag_sub(2)(i) and flag_sub(2)(i-4);
        end loop;
        
        flag_add(4)(8 downto 0) <= flag_add(3)(8 downto 0);
        flag_sub(4)(8 downto 0) <= flag_sub(3)(8 downto 0);
        for i in 9 to 15 loop
            flag_add(4)(i) <= flag_add(3)(i) and flag_add(3)(i-8);
            flag_sub(4)(i) <= flag_sub(3)(i) and flag_sub(3)(i-8);
        end loop;
    
    end process;
    
    grs_propagate <= (ca3(0) or cb3(0)) and 
                        (ca3(1) or cb3(1)) and 
                        (ca3(2) or cb3(2)) and 
                        (ca3(3) or cb3(3)) and
                        (ca3(4) or cb3(4)) and
                        (ca3(5) or cb3(5)) and
                        (ca3(6) or cb3(6)) and
                        (ca3(7) or cb3(7)) and
                        (ca3(8) or cb3(8)) and
                        (ca3(9) or cb3(9)) and
                        (ca3(10) or cb3(10)) and
                        (ca3(11) or cb3(11));
                        
    c1 <= tmp_c1(19 downto 1);
    tmp_ucr_f2gen <= tmp_ucr(75 downto 12);
    ucr <= tmp_ucr(75 downto 0);
    f1 <= tmp_f1(74 downto 0) & '1' when tmp_f1(0) = '1' else tmp_f1;
    tmp_f2 <= flag_add(4) when eop = '0' else flag_sub(4);
    f2 <= tmp_f2(14 downto 0) & '1' when tmp_f2(0) = '1' else tmp_f2;

end Behavioral;

