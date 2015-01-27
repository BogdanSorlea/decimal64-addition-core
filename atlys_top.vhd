----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:35:01 01/27/2015 
-- Design Name: 
-- Module Name:    atlys_top - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity atlys_top is

    port (
        sw : in std_logic_vector(7 downto 0);
        rst : in std_logic;
        --step : in std_logic; -- if testing, uncomment this line
        btn, clk : in std_logic; -- if testing, comment this line and the mapping of MPG and step signal 
        led : out std_logic_vector(7 downto 0)
    );

end atlys_top;

architecture Behavioral of atlys_top is

    component monopulse_generator is
        port (
            clk : in std_logic;
            btn : in std_logic;
            step : out std_logic
        );
    end component;
    
    component decimal64_adder is
        port (
            a, b : in std_logic_vector(63 downto 0);
            operation : in std_logic;
            rounding : in std_logic_vector(2 downto 0);
            r1 : out std_logic_vector(63 downto 0)
        );
    end component;
    
    type states is (start, read_inputs, read_flags, result);
    
    signal adder_inputs_reg : std_logic_vector(127 downto 0) := (others => '0');
    signal operation_reg : std_logic := '0';
    signal rounding_reg : std_logic_vector(2 downto 0) := (others => '0');
    signal output : std_logic_vector(63 downto 0);
    signal partial_result : std_logic_vector(7 downto 0);
    
    signal step : std_logic;
    signal state, next_state : states;
    signal input_count, next_input_count : unsigned(4 downto 0);

begin

    mpg: component monopulse_generator port map (
       clk, btn, step
    );
    
    dec64_adder: component decimal64_adder port map (
        adder_inputs_reg(127 downto 64), adder_inputs_reg(63 downto 0), operation_reg, rounding_reg, output
    );
    
    state_register: process(step, rst, next_state)
    begin
        if rst = '0' then
            state <= start;
            input_count <= to_unsigned(0, 5);
        elsif rising_edge(step) then
            state <= next_state;
            input_count <= next_input_count;
        end if;
    end process;
    
    state_logic: process(state, input_count)
    begin
        
        case state is
            when start =>
                next_state <= read_inputs;
                next_input_count <= input_count + 1;
                
            when read_inputs =>
                if input_count < 15 then
                    next_state <= read_inputs;
                else
                    next_state <= read_flags;
                end if;
                next_input_count <= input_count + 1;
                
            when read_flags =>
                next_state <= result;
                next_input_count <= to_unsigned(16, 5);
                
            when result =>
                next_state <= start;
                next_input_count <= to_unsigned(0, 5);
                
        end case;
    end process;
    
    inputs: process(step, state, input_count)
    begin
        if rising_edge(step) and (state = start or state = read_inputs) then
            adder_inputs_reg(8*(to_integer(input_count)+1)-1 downto 8*to_integer(input_count)) <= sw;
        end if;
        
        if rising_edge(step) and state = read_flags then
            operation_reg <= sw(0);
            rounding_reg <= sw(3 downto 1);
        end if;
    end process;
    
    state_output: process(step, state, sw, partial_result, input_count)
    begin
        
        case state is
            when start =>
                led <= std_logic_vector(resize(input_count, 8));
                
            when read_inputs =>
                led <= std_logic_vector(resize(input_count, 8));
                
            when read_flags =>
                led <= std_logic_vector(resize(input_count, 8));
                
            when result =>
                led <= partial_result;
                
        end case;
    end process;
    
    partial_result <= output(8*(to_integer(unsigned(sw(2 downto 0)))+1)-1 downto 8*(to_integer(unsigned(sw(2 downto 0)))));

end Behavioral;

