-----------------------------
-- APS					   	--
-- Módulo TX					--
-----------------------------

----------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
----------------------------------

ENTITY RX IS
	GENERIC(
		N_Botoes : INTEGER := 1);
	PORT (
		clk,rst: IN STD_LOGIC;
		botao: IN STD_LOGIC_VECTOR(N_Botoes DOWNTO 1);
		
		--saida: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		
		dot, dash, letter, space: OUT BOOLEAN);
END;
----------------------------------
ARCHITECTURE RX OF RX IS 
		TYPE estado IS (Standby, Listening, Recieved_Dot, Recieved_Dash, Recieved_Letter,
																			Standby_Space,Recieved_Space);
		SIGNAL button_event: STD_LOGIC_VECTOR(N_Botoes DOWNTO 1);
		
		SIGNAL pr_state, nx_state: estado := Standby_Space; 
		--SIGNAL testa_porraaaaaaa: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		--SIGNAL dot, dash, letter, space: BOOLEAN := false;
		
		CONSTANT T_Dot: NATURAL := 10_000_000;
		CONSTANT T_Dash: NATURAL := 3*T_Dot;
		CONSTANT T_Letter: NATURAL := 5*T_Dot;
		CONSTANT T_Word: NATURAL := 7*T_Dot;
		CONSTANT T_Max: NATURAL := T_Word;
		SIGNAL ticks: NATURAL RANGE 0 TO T_Word := 0;
BEGIN

		debouncers: FOR i IN 1 TO N_Botoes GENERATE
			botaum: ENTITY work.debouncer_dual 
					PORT MAP (clk => clk, botao => botao(i), sinal => button_event(i) );	
		END GENERATE debouncers;
		
		
	Timer:
		PROCESS (clk,rst)
		BEGIN
			IF (rst='1') THEN
				 ticks <= 0;
			ELSIF (rising_edge(clk)) THEN
				IF pr_state /= nx_state THEN
					ticks <= 0;
				ELSIF ticks /= T_Max THEN
					ticks <= ticks + 1;
				END IF;
			END IF;
		END PROCESS Timer;
		
	Maquina:
	PROCESS(clk,rst)
	BEGIN
			IF (rst='1') THEN
				pr_state <= Standby_Space;
			ELSIF (rising_edge(clk)) THEN
				pr_state <= nx_state;
			END IF;
	END PROCESS Maquina;

	RX:
	PROCESS(clk, rst, pr_state, ticks, button_event)
		BEGIN
			CASE pr_state IS
				WHEN Standby =>
					dot <= false;
					dash <= false;
					letter <= false;
					space <= false;
					IF ticks < T_Dash-1 AND button_event(1) = '1' THEN
						nx_state <= Listening;
					ELSIF ticks >= T_Dash-1 AND ticks < T_Letter-1 AND button_event(1) = '1' THEN
						nx_state <= Recieved_Letter;
					ELSIF ticks >= T_Letter-1 THEN
						nx_state <= Recieved_Space;
					ELSE
						nx_state <= Standby;
					END IF;
				WHEN Listening =>
					dot <= false;
					dash <= false;
					letter <= false;
					space <= false;
					IF ticks < T_Dot-1 AND button_event(1) = '1' THEN
						nx_state <= Recieved_Dot;
					ELSIF ticks >= T_Dot-1 AND button_event(1) = '1' THEN
						nx_state <= Recieved_Dash;
					ELSE						
						nx_state <= Listening;
					END IF;
				WHEN Recieved_Dot =>
					dot <= true;
					dash <= false;
					letter <= false;
					space <= false;
					nx_state <= Standby;
				WHEN Recieved_Dash =>
					dot <= false;
					dash <= true;
					letter <= false;
					space <= false;
					nx_state <= Standby;
				WHEN Recieved_Letter =>
					dot <= false;
					dash <= false;
					letter <= true;
					space <= false;
					nx_state <= Listening;
				WHEN Recieved_Space =>
					dot <= false;
					dash <= false;
					letter <= false;
					space <= true;
					nx_state <= Standby_Space;
				WHEN Standby_Space =>
					dot <= false;
					dash <= false;
					letter <= false;
					space <= false;
					IF ticks < T_Dash-1 AND button_event(1) = '1' THEN
						nx_state <= Listening;
					ELSIF ticks >= T_Dash-1 AND ticks < T_Letter-1 AND button_event(1) = '1' THEN
						nx_state <= Recieved_Letter;
					ELSE
						nx_state <= Standby;
					end if;
				WHEN OTHERS =>
					dot <= false;
					dash <= false;
					letter <= false;
					space <= false;
					nx_state <= Standby;
				END CASE;
	END PROCESS RX;
	
--	teste:
--	PROCESS(clk)
--		VARIABLE naosei: STD_LOGIC_VECTOR(3 DOWNTO 0);
--	BEGIN
--		IF RISING_EDGE(clk) THEN
--			IF dot THEN
--				testa_porraaaaaaa <= "1000";
--				naosei := "1000";
--			ELSIF dash THEN
--				testa_porraaaaaaa <= "0100";
--				naosei := "0100";
--			ELSIF letter THEN
--				testa_porraaaaaaa <= "0010";
--				naosei := "0010";
--			ELSIF space THEN
--				testa_porraaaaaaa <= "0001";
--				naosei := "0001";
--			END IF;
--		END IF;
--	END PROCESS teste;
	
--	testa_porraaaaaaa <= "1000" WHEN dot ELSE
--				"0100" WHEN dash ELSE
--				"0010" WHEN letter ELSE
--				"0001" WHEN space ELSE
--				testa_porraaaaaaa;
--	saida <= testa_porraaaaaaa;
END;