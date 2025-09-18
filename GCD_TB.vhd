library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GCD_TB is
end GCD_TB;

architecture Behavioral of GCD_TB is

    --Component Declarations
    component GCD_top is
        port(
		A,B: in std_logic_vector(7 downto 0);
		start, rst, clk: in STD_LOGIC; --RESET is active high
		DisA, DisB: out std_logic_vector(6 downto 0);
		DisplayEN: out std_logic_vector(7 downto 0)
		);
end component;

    --Inputs
    signal A : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal B : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal start : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal clk : STD_LOGIC := '0';
    --Outputs
    signal DisA : STD_LOGIC_VECTOR(6 downto 0);
    signal DisB : STD_LOGIC_VECTOR(6 downto 0);
    signal DisplayEN : STD_LOGIC_VECTOR(7 downto 0);
    -- Clock period definitions
    constant clk_period : time := 10 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut : GCD_top port map (
            A => A,
            B => B,
            start => start,
            rst => rst,
            clk => clk,
            DisA => DisA,
            DisB => DisB,
            DisplayEN => DisplayEN
        );

    --clock process
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    --Stimulus process
    stim_proc: process
    begin 
        -- hold reset state for 100 ns.
        rst <= '1';
        wait for 20 ns;  
        rst <= '0';
        wait for 20 ns;  
        
        -- Test case 1
        A <= "01100100"; 
        B <= "00001010"; 
        start <= '1'; 
        wait for 10 ns;
        start <= '0';
        wait for 300 ns;
        
        -- Test case 2
        A <= "00001111"; 
        B <= "00001010"; 
        start <= '1'; 
        wait for 10 ns;
        start <= '0';
        wait for 300 ns;

        -- Test case 3
        A <= "00101010"; 
        B <= "00000110"; 
        start <= '1'; 
        wait for 10 ns;
        start <= '0';
        wait for 300 ns;
        
        wait;
    end process;
end Behavioral;
