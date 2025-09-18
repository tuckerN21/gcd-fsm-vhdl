-- load register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg8 is
  Port ( 
  A : in STD_LOGIC_VECTOR(7 downto 0);
  en,clk,rst : in std_logic;
  F : out STD_LOGIC_VECTOR(7 downto 0)
  );
end reg8;

architecture Behavioral of reg8 is

begin

    process(rst,clk)
    begin
        if rst = '1' then
            F <= x"00";
        elsif rising_edge(clk) and en = '1' then
            F <= A;
        end if;

    end process;
end Behavioral;


-- multiplexer

Library IEEE;
use IEEE.std_logic_1164.all;

entity mux2x8 is
	port(S: in STD_LOGIC;
		 X0, X1: in STD_LOGIC_VECTOR(7 downto 0);
		 F: out STD_LOGIC_VECTOR(7 downto 0));
end;

architecture Behavioral of mux2x8 is
begin
	mux_behav: process(S, X0, X1)
	begin
		if S = '0' then
			F <= X0;
		else
			F <= X1;
		end if;
	end process;
end Behavioral;


-- comparator

Library IEEE;
use IEEE.std_logic_1164.all;

entity comparator is
	port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
		 AeqB, AgB: out STD_LOGIC);
end;

architecture Behavioral of comparator is
begin
	P1: process(A, B)
	begin
		if A > B then
			AgB <= '1';
			AeqB <= '0';
        elsif A = B then
			AgB <= '0';
            AeqB <= '1';
		else
			AgB <= '0';
            AeqB <= '0';
            end if;
	end process;
end Behavioral;


-- conditional inverse

Library IEEE;
use IEEE.std_logic_1164.all;

entity cond_inv is
	port(inv: in STD_LOGIC;
		 Din: in STD_LOGIC_VECTOR(7 downto 0);
		 Dout: out STD_LOGIC_VECTOR(7 downto 0));
end;

architecture Behavioral of cond_inv is
begin
        P1: process(Din, inv)
        begin
                if INV = '1' then
                        Dout <= not(Din);
                else
                        Dout <= Din;
                end if;
        end process;
end Behavioral;


-- ripple-carry adder

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity RCA is
	port(X, Y: in STD_LOGIC_VECTOR(7 downto 0);
		 Cin: in std_logic;
		 S: out STD_LOGIC_VECTOR(7 downto 0));
end;

architecture Behavioral of RCA is
begin
	S <= (X + Y) + Cin;
end Behavioral;

-- segment decoder

Library IEEE;
use IEEE.std_logic_1164.all;

entity seg7 is
    port(
        A: in STD_LOGIC_VECTOR(3 downto 0);
        S: out STD_LOGIC_VECTOR(6 downto 0)
    );
end seg7;

architecture Behavioral of seg7 is
begin
    process(A)
    begin
        case A is
            when "0000" => S <= "1000000";
            when "0001" => S <= "1111001";
            when "0010" => S <= "0100100";
            when "0011" => S <= "0110000";
            when "0100" => S <= "0011001";
            when "0101" => S <= "0010010";
            when "0110" => S <= "0000010";
            when "0111" => S <= "1111000";
            when "1000" => S <= "0000000";
            when "1001" => S <= "0010000";
            when "1010" => S <= "0001000";
            when "1011" => S <= "0000011";
            when "1100" => S <= "1000110";
            when "1101" => S <= "0100001";
            when "1110" => S <= "0000110";
            when "1111" => S <= "0001110";
            when others => S <= "1111111";

        end case;
    end process;
end Behavioral;  
