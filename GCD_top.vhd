Library IEEE;
use IEEE.std_logic_1164.all;

entity GCD_top is
        port(
		A,B: in std_logic_vector(7 downto 0);
		start, rst, clk: in STD_LOGIC; --RESET is active high
		DisA, DisB: out std_logic_vector(6 downto 0);
		DisplayEN: out std_logic_vector(7 downto 0)
		);
end;

architecture BEHAVIOR of GCD_top is
--Component Declarations

    component reg8 is
        Port ( 
            A : in STD_LOGIC_VECTOR(7 downto 0);
            en,clk,rst : in std_logic;
            F : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    component mux2x8 is
        Port ( 
            S: in STD_LOGIC;
            X0, X1: in STD_LOGIC_VECTOR(7 downto 0);
            F: out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;      
    
    component cond_inv is
        Port ( 
            inv: in STD_LOGIC;
            Din: in STD_LOGIC_VECTOR(7 downto 0);
            Dout: out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;      
    
    component RCA is
        Port ( 
            X, Y: in STD_LOGIC_VECTOR(7 downto 0);
            Cin: in std_logic;
            S: out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;      
    
    component comparator is
        Port ( 
            A, B: in STD_LOGIC_VECTOR(7 downto 0);
            AeqB, AgB: out STD_LOGIC
        );
    end component;      
    
    component seg7 is
        Port ( 
            A: in STD_LOGIC_VECTOR(3 downto 0);
            S: out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;        
	
--Signal Declarations
	type state_type is (S0, S1, S2, S3, S4);
	signal CS, NS: state_type;
--Control signals used in the FSM to interact with the datapath
	signal sel, enA, enB, AgB, AeqB, invA, invB: std_logic;
--Signal Declarations for port mapping internal signals in your datapath
	signal muxA_out, muxB_out : std_logic_vector(7 downto 0);
    signal regA_out, regB_out : std_logic_vector(7 downto 0);
    signal invA_out, invB_out : std_logic_vector(7 downto 0);
    signal sum_out : std_logic_vector(7 downto 0);

begin

	-- Turn on the display for A and B
	DisplayEN <= "11101110"; --This is used for the 7 segment display do not delete unless you know what you are doing.

	-- here we are port maping our datapath. Make the connections as shown in the lab manual for the datapath. 
	--You will need to create your own signals to make internal connections.
    -- Register A
    regA: reg8 port map (
        A => muxA_out,
        en => enA,
        clk => clk,
        rst => rst,
        F => regA_out
    );

    regB: reg8 port map (
        A => muxB_out,
        en => enB,
        clk => clk,
        rst => rst,
        F => regB_out
    );
    
    muxA: mux2x8 port map (
        S => sel,
        X0 => sum_out,
        X1 => A,
        F => muxA_out
    );
    
    muxB: mux2x8 port map (
        S => sel,
        X0 => sum_out,
        X1 => B,
        F => muxB_out
    );
    
    inv_A: cond_inv port map (
        inv => invA,
        Din => regA_out,
        Dout => invA_out
    );
    
    inv_B: cond_inv port map (
        inv => invB,
        Din => regB_out,
        Dout => invB_out
    );
    
    RCA_1: RCA port map (
        X => invA_out,
        Y => invB_out,
        Cin => '1',
        S => sum_out
    );
    
    comp: comparator port map (
        A => regA_out,
        B => regB_out,
        AeqB => AeqB,
        AgB => AgB
    );
    
    segA: seg7 port map (
        A => regA_out(7 downto 4),
        S => DisA
    );
    
    segB: seg7 port map (
        A => regB_out(3 downto 0),
        S => DisB
    );


	--Here is a 2-process state machine started to help start of the FSM. 
	-- Next State Logic for Algorithmic State Machine (ASM)
	comb: process(CS, AeqB, AgB, start)	-- Process Sensitivity List
	begin
		-- Set Defaults to prevent latches
		NS <= CS;
		sel <= '0';
		enA <= '0';
		enB <= '0';
		invA <= '0';
		invB <= '0';
		--Start case statement for FSM
		case CS is
		
		  when S0 =>
		      if start = '1' then
		          NS <= S1;
		      else
		          NS <= S0;
		      end if;
		      
		  when S1 =>
		      enA <= '1';
		      enB <= '1';
		      sel <= '1';
		      NS <= S2;
		      
		  when S2 =>
		      if AeqB = '1' then
                  NS <= S0;       
              elsif AgB = '1' then
                  NS <= S3;
              else
                  NS <= S4;
              end if; 
          
          when S3 =>
              invB <= '1';
              enA <= '1';
              NS <= S2;
          
          when S4 =>
              invA <= '1';
              enB <= '1';
              NS <= S2; 
              
          end case;
	end process;

	-- Update Current State based on Next State Logic
	sync: process(clk, rst)
	begin
        if rst = '1' then
	       CS <= S0;
		elsif rising_edge(clk) then
	       CS <= NS;
		end if;
	end process;
end;
