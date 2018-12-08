LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;

-- DEBOUNCER-PULSO DUAL
-- 	Ao colocar o sinal de um botão na estrada "botao",
-- o componente devolve na saída "sinal" pulsos de 1 clock de
-- duração no momento de apertar e de soltar o botão

ENTITY debouncer_dual IS
	GENERIC(
			debounce_duration : INTEGER := 3000000);
	
	PORT (
			clk: IN STD_LOGIC;
			botao: IN STD_LOGIC;
			sinal: OUT STD_LOGIC);
			
	END;
ARCHITECTURE debouncer_dual OF debouncer_dual IS 
		SIGNAL estado: STD_LOGIC; -- Estado do botao Pressionado / Depressão
		SIGNAL cidade1, cidade2: STD_LOGIC; -- Pulso do botão debounceado
	BEGIN
		the_bounce: PROCESS(clk) IS
			VARIABLE ticks: integer := 0;
		BEGIN
			IF RISING_EDGE(clk) THEN
				IF estado = '0' AND botao = '0' THEN
					ticks := ticks+1;
					IF ticks >= debounce_duration THEN -- 100ms no clk da placa
						estado <= '1';
					END IF;
				ELSIF estado ='0' AND botao = '1' THEN
					ticks := 0;
				ELSIF estado = '1' AND botao = '1' THEN
					ticks := ticks+1;
					IF ticks >= debounce_duration THEN -- 100ms no clk da placa
						estado <= '0';
					END IF;
				ELSIF estado ='1' AND botao = '0' THEN
					ticks := 0;
				END IF;
			END IF;
		END PROCESS the_bounce;		
		
		pulso_bounce_down: PROCESS(clk) IS
			VARIABLE ticks: integer := 0;
		BEGIN
			IF RISING_EDGE(clk) THEN
				IF estado = '1' THEN
					cidade1 <= '0';
					ticks := 0;
				ELSIF estado = '0' THEN
					cidade1 <= '1';
					ticks := ticks + 1;
					IF ticks > 1 THEN
						cidade1 <= '0';
					END IF;
				END IF;
			END IF;
		END PROCESS pulso_bounce_down;
		
		pulso_bounce_up: PROCESS(clk) IS
			VARIABLE ticks: integer := 0;
		BEGIN
			IF RISING_EDGE(clk) THEN
				IF estado = '0' THEN
					cidade2 <= '0';
					ticks := 0;
				ELSIF estado = '1' THEN
					cidade2 <= '1';
					ticks := ticks + 1;
					IF ticks > 1 THEN
						cidade2 <= '0';
					END IF;
				END IF;
			END IF;
		END PROCESS pulso_bounce_up;
		sinal <= cidade1 OR cidade2;		
		
--		incrementa: PROCESS(cidade) IS
--			VARIABLE testa : STD_LOGIC := '0';
--		BEGIN
--			IF cidade = '1' THEN
--				testa := NOT testa;
--			END IF;
--			ledi_buffer <= testa;
--		END PROCESS incrementa;
--		ledi <= ledi_buffer;
END;
