----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:31:56 01/24/2015 
-- Design Name: 
-- Module Name:    decimal64_adder_no_conversions - Behavioral 
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

entity decimal64_adder_no_conversions is

    port (
        ca1, cb1 : in std_logic_vector(63 downto 0);
        ea1, eb1 : in std_logic_vector(9 downto 0);
        sa1, sb1, operation : in std_logic;
        rounding : in std_logic_vector(2 downto 0);
        
        r1 : out std_logic_vector(63 downto 0)
    );

end decimal64_adder_no_conversions;

architecture Behavioral of decimal64_adder_no_conversions is

    component operand_alignment_and_swapping is
        port (
            ca1, cb1 : in std_logic_vector(63 downto 0);
            ea1, eb1 : in std_logic_vector(9 downto 0);
            sa1, sb1, operation : in std_logic;
              
            cas, cbs : out std_logic_vector(63 downto 0);
            lsa, rsa : out std_logic_vector(4 downto 0);
            er1 : out std_logic_vector(9 downto 0);
            eop, swap : out std_logic
        );
    end component;
    
    component dbs is
        port (
            cas : in std_logic_vector(63 downto 0);
            cbs : in std_logic_vector(63 downto 0);
            rsa : in  std_logic_vector(4 downto 0);
            lsa : in  std_logic_vector(4 downto 0);
            ca2 : out std_logic_vector(63 downto 0);
            cb2 : out std_logic_vector(71 downto 0);
            sticky : out std_logic     
        );
    end component;
    
    component OPU is
        port (
            ca2 : in std_logic_vector(63 downto 0);
            cb2 : in std_logic_vector(71 downto 0);
            --for Sign_Inj
            operation : in std_logic;
            eop : in std_logic;
            swap : in std_logic;
            sa1, sb1 : in std_logic;
            rounding : in std_logic_vector(2 downto 0);
            --
            sticky_bit : in std_logic;
            ca3 : out std_logic_vector(75 downto 0);   --19 digits
            cb3 : out std_logic_vector(75 downto 0);
            sign_inj : out std_logic
        );
    end component;
    
    component addition_module is
        port (
            ca3, cb3 : in std_logic_vector(75 downto 0);
            eop : in std_logic;
            
            f2 : out std_logic_vector(15 downto 0);
            c1 : out std_logic_vector(18 downto 0);
            ucr, f1 : out std_logic_vector(75 downto 0)
        );
    end component;
    
    component postcorrection_unit is
        port(
            c1 : in std_logic_vector(18 downto 0);
            ucr, f1 : in std_logic_vector(75 downto 0);
            eop : in std_logic;
            cr1 : out std_logic_vector(75 downto 0)
        );
    end component;
    
    component sru is
        port (
            ucr_lsd : in std_logic_vector(7 downto 0);   
            cr1 : in std_logic_vector(63 downto 0);
            f2 : in std_logic_vector(15 downto 0);
            rounding : in std_logic_vector(2 downto 0);
            sign_inj : in std_logic;
            cr2: out std_logic_vector(63 downto 0)
        );
    end component;
    
    signal cas, cbs : std_logic_vector(63 downto 0);
    signal lsa, rsa : std_logic_vector(4 downto 0);
    signal er1 : std_logic_vector(9 downto 0);
    signal eop, swap : std_logic;
    
    signal ca2 : std_logic_vector(63 downto 0);
    signal cb2 : std_logic_vector(71 downto 0);
    signal sticky : std_logic;
    
    signal tmp_ca3, tmp_cb3 : std_logic_vector(75 downto 0);
    signal sign_inj : std_logic;
    
    signal f2 : std_logic_vector(15 downto 0);
    signal c1 : std_logic_vector(18 downto 0);
    signal ucr, f1 : std_logic_vector(75 downto 0);
    
    signal cr1 : std_logic_vector(75 downto 0);
    signal cr2 : std_logic_vector(63 downto 0);
    
    -- testing signals
    signal ca3, cb3 : std_logic_vector(75 downto 0);
    signal tmp_sign_inj : std_logic;

begin

    oacsu: component operand_alignment_and_swapping port map (
        ca1, cb1, ea1, eb1, sa1, sb1, operation, cas, cbs, lsa, rsa, er1, eop, swap
    );
    
    decimal_barrel_shifters: component dbs port map (
        cas, cbs, rsa, lsa, ca2, cb2, sticky
    );
    
    precorrection_and_operand_placement: component opu port map (
        ca2, cb2, operation, eop, swap, sa1, sb1, rounding, sticky, tmp_ca3, tmp_cb3, tmp_sign_inj
    );
    
    ca3 <= x"200_0000_0001_0000_0050";
    cb3 <= x"FFF_FFFF_FFFF_6FFF_FAFF";
    sign_inj <= '0';
    
    addition: component addition_module port map (
        ca3, cb3, eop, f2, c1, ucr, f1
    );
    
    postcorrection: component postcorrection_unit port map (
        c1, ucr, f1, eop, cr1
    );
    
    shift_and_round: component sru port map (
        cr1(11 downto 4), cr1(75 downto 12), f2, rounding, sign_inj, cr2
    );

    r1 <= cr2;

end Behavioral;

