	LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------------------------
-- decodificador de codigo morse
-- caracter selecionado a partir de arvore de morse

-- para usar utilizar 
-- funcao: entity work.decodificador PORT MAP (clk => clk,rst => , dot => , dash => , letra => , space => , char_out => , flag_hasChar => );

-- OBS: usar borda de subida do flag_hasChar , utilizar p/ receber a letra ASCII em binario
-- OBS2: qdo ocorre tempo de espaco, primeiro eh enviado a letra ASCII e logo em seguida o ASCII de espaco em binario
---------------------------------------------------------------------	
ENTITY  decodificador_v3 IS
	PORT (
		clk,rst: IN STD_LOGIC;
		--dot,dash,letra,space: IN boolean;
		botao: IN STD_LOGIC_VECTOR (0 downto 0);
		char_out: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		flag_hasChar: OUT STD_LOGIC
	);
	
END ENTITY;
-----------------------------
ARCHITECTURE decodificador_v3 OF decodificador_v3 IS

	type state is (inicio,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,
						N1,N2,N3,N4,N5,N6,N7,N8,N9,N0,
						espaco,espaco_2,espaco_3,espaco_char,
						invalido_2,invalido_8,invalido_9ou0,invalido,send_char);
	signal nx_state,pr_state:state := inicio;	
	
	type caracter is (invalido, char_espaco, a, b, c, d, e, f, g, h, i, j, k, l, m,
								n, o, p, q, r, s, t, u, v, w, x, y, z, um, dois,
								tres, quatro, cinco, seis, sete, oito, nove, zero);
	signal latch_out: caracter := invalido;
	signal latch_char: STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
	
	
	signal dot,dash,letra,space: boolean;
	
	
BEGIN	
		funcao_RX: entity work.RX PORT MAP (clk => clk,rst => not rst, botao => botao,dot=>dot, dash =>dash , letter => letra, space =>space);
	
	-- Lower FSM
	PROCESS (clk,rst)	
	BEGIN
		IF (rst='0') THEN		-- considerando que precisa apertar RST para iniciar
			pr_state<=inicio;
		ELSIF (clk'EVENT AND clk='1') THEN
			pr_state<=nx_state;
		END IF;
	END PROCESS;
	
		
		--Upper section of FSM:
		PROCESS (clk, dash,dot,letra,space,pr_state)   
		BEGIN
		
			CASE pr_state IS
				WHEN inicio =>
					flag_hasChar <= '0';	latch_out <= invalido;
					-- char_out <= "00000000";		-- inicio: se tudo zerado, char_out é invalido (se precisar)
					if dot then
						nx_state <= E;
					elsif dash then 
						nx_state <= T;
					else 
						nx_state <= inicio; 
					end if;	
----------------------------- linha 1 -----------------------------
				WHEN E =>
					flag_hasChar <= '0'; latch_out <= e;
					if dot then
						nx_state <= I;
					elsif dash then 
						nx_state <= A;
					elsif letra then
						nx_state <=send_char;
					elsif space then
						nx_state <= espaco;	-- garante que quando ocorre tempo de palavra, adiciona o character espaço em ASCII
					else
						nx_state <= E;
					end if;	
				WHEN T =>
					flag_hasChar <= '0'; latch_out <= t;
					if dot then
						nx_state <= N;
					elsif dash then 
						nx_state <= M;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= T;
					end if;
----------------------------- linha 2 -----------------------------
				WHEN I =>
					flag_hasChar <= '0'; latch_out <= i;
					if dot then
						nx_state <= S;
					elsif dash then 
						nx_state <= U;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= I;
					end if;	
				WHEN A =>
					flag_hasChar <= '0'; latch_out <= a;
					if dot then
						nx_state <= R;
					elsif dash then 
						nx_state <= W;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= A;
					end if;
				WHEN N =>
					flag_hasChar <= '0'; latch_out <= n;
					if dot then
						nx_state <= D;
					elsif dash then 
						nx_state <= K;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N;
					end if;	
				WHEN M =>
					flag_hasChar <= '0'; latch_out <= m;
					if dot then
						nx_state <= G;
					elsif dash then 
						nx_state <= O;
					elsif letra then
						nx_state <=send_char;
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= M;
					end if;		
-----------------------------	LINHA 3	-----------------------------
				WHEN S =>
					flag_hasChar <= '0'; latch_out <= s;
					if dot then
						nx_state <= H;
					elsif dash then 
						nx_state <= V;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= S;
					end if;	
				WHEN U =>
					flag_hasChar <= '0'; latch_out <= u;
					if dot then
						nx_state <= F;
					elsif dash then 
						nx_state <= invalido_2;  -- invalido mas ainda pode ser 2 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= U;
					end if;
				WHEN R =>
					flag_hasChar <= '0'; latch_out <= r;
					if dot then
						nx_state <= L;
					elsif dash then 
						nx_state <= invalido; -- nao considerando o simbolo '+'
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= R;
					end if;
				WHEN W =>
					flag_hasChar <= '0'; latch_out <= w;
					if dot then
						nx_state <= P;
					elsif dash then 
						nx_state <= J; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= W;
					end if;
				-------------------------------
				WHEN D =>
					flag_hasChar <= '0'; latch_out <= d;
					if dot then
						nx_state <= B;
					elsif dash then 
						nx_state <= X; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= D;
					end if;
				WHEN K =>
					flag_hasChar <= '0'; latch_out <= k;
					if dot then
						nx_state <= C;
					elsif dash then 
						nx_state <= Y; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= K;
					end if;
				WHEN G =>
					flag_hasChar <= '0'; latch_out <= g;
					if dot then
						nx_state <= Z;
					elsif dash then 
						nx_state <= Q; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= G;
					end if;
				WHEN O =>
					flag_hasChar <= '0'; latch_out <= o;
					if dot then
						nx_state <= invalido_8;
					elsif dash then 
						nx_state <= invalido_9ou0; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= O;
					end if;
				
-----------------------------	LINHA 4	-----------------------------
				WHEN H =>
					flag_hasChar <= '0'; latch_out <= h;
					if dot then
						nx_state <= N5;
					elsif dash then 
						nx_state <= N4; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= H;
					end if;
				WHEN V =>
					flag_hasChar <= '0'; latch_out <= v;
					if dot then
						nx_state <= invalido;
					elsif dash then 
						nx_state <= N3; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= V;
					end if;
				WHEN F =>
					flag_hasChar <= '0'; latch_out <= f;
					if dot then
						nx_state <= invalido;
					elsif dash then 
						nx_state <= invalido; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= F;
					end if;
--------------------------------------------------------------------	
				WHEN invalido_2 => -- invalido mas ainda espera pra ver se eh 2
					flag_hasChar <= '0'; latch_out <= invalido;
					if dot or letra then
						nx_state <= invalido;
					elsif dash then 
						nx_state <= N2;
					elsif space then
						nx_state <= espaco; -- ignora o errado e manda ASCII do espaco
					else
						nx_state <= invalido_2;
					end if;
--------------------------------------------------------------------				
				WHEN L =>
					flag_hasChar <= '0'; latch_out <= l;
					if dot or dash then
						nx_state <= invalido;
--					elsif dash then 
--						nx_state <= invalido; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= L;
					end if;
				WHEN P =>
					flag_hasChar <= '0'; latch_out <= p;
					if dot or dash then
						nx_state <= invalido;
--					elsif dash then 
--						nx_state <= invalido; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= P;
					end if;
				WHEN J =>
					flag_hasChar <= '0'; latch_out <= j;
					if dot then
						nx_state <= invalido;
					elsif dash then 
						nx_state <= N1; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= J;
					end if;
				WHEN B =>
					flag_hasChar <= '0'; latch_out <= b;
					if dot then
						nx_state <= N6;
					elsif dash then 
						nx_state <= invalido; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= B;
					end if;
				WHEN X =>
					flag_hasChar <= '0'; latch_out <= x;
					if dot or dash then
						nx_state <= invalido; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= B;
					end if;
				WHEN C =>
					flag_hasChar <= '0'; latch_out <= c;
					if dot or dash then
						nx_state <= invalido; 
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= C;
					end if;
				WHEN Y =>
					flag_hasChar <= '0'; latch_out <= y;
					if dot or dash then
						nx_state <= invalido; 
					elsif letra then
						nx_state <=send_char;
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= C;
					end if;
				WHEN Z =>
					flag_hasChar <= '0'; latch_out <= z;
					if dot then
						nx_state <= N7; 
					elsif dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= Z;
					end if;
				WHEN Q =>
					flag_hasChar <= '0'; latch_out <= q;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= Q;
					end if;
--------------------------------------------------------------------	
				WHEN invalido_8 => -- invalido mas ainda espera pra ver se eh 8
					flag_hasChar <= '0'; latch_out <= invalido;
					if dot then
						nx_state <= N8;
					elsif dash or letra then 
						nx_state <= invalido; 
					elsif space then
						nx_state <= espaco; -- ignora o errado e manda ASCII do espaco
					else
						nx_state <= invalido_8;
					end if;
--------------------------------------------------------------------	
				WHEN invalido_9ou0 => -- invalido mas ainda espera pra ver se eh 9 ou 0
					flag_hasChar <= '0'; latch_out <= invalido;
					if dot then
						nx_state <= N9;
					elsif dash then 
						nx_state <= N0;
					elsif letra then 
						nx_state <= invalido;
					elsif space then
						nx_state <= espaco; -- ignora o errado e manda ASCII do espaco
					else
						nx_state <= invalido_2;
					end if;

-----------------------------	LINHA 4	-----------------------------						
				WHEN N5 =>
					flag_hasChar <= '0'; latch_out <= cinco;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N5;
					end if;				
				WHEN N4 =>
					flag_hasChar <= '0'; latch_out <= quatro;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char;
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N4;
					end if;	
				WHEN N3 =>
					flag_hasChar <= '0'; latch_out <= tres;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N3;
					end if;		
				WHEN N2 =>
					flag_hasChar <= '0'; latch_out <= dois;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char;
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N2;
					end if;	
				WHEN N1 =>
					flag_hasChar <= '0'; latch_out <= um;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N1;
					end if;		
				WHEN N6 =>
					flag_hasChar <= '0'; latch_out <= seis;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N6;
					end if;			
				WHEN N7 =>
					flag_hasChar <= '0'; latch_out <= sete;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N7;
					end if;			
				WHEN N8 =>
					flag_hasChar <= '0'; latch_out <= oito;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N8;
					end if;		
				WHEN N9 =>
					flag_hasChar <= '0'; latch_out <= nove;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						nx_state <=send_char; 
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N9;
					end if;			
				WHEN N0 =>
					flag_hasChar <= '0'; latch_out <= zero;
					if dot or dash then
						nx_state <= invalido;
					elsif letra then
						latch_out <= zero;
					elsif space then
						nx_state <= espaco;
					else
						nx_state <= N0;
					end if;				
-------------------------------------------------------------------					
				
				WHEN invalido =>
					flag_hasChar <= '0';
					nx_state <= inicio; 
					
				WHEN send_char =>
					latch_out <= latch_out; -- Faz um latch pra enviar a letra anterior????
					flag_hasChar <= '1';	-- Envia a letra anterior
					nx_state <= inicio;
				
				WHEN espaco =>	
					latch_out <= latch_out; -- Faz um latch pra enviar a letra anterior????
					flag_hasChar <= '1';	-- Envia a letra anterior
					nx_state <= espaco_2;
				WHEN espaco_2 =>
					latch_out <= char_espaco;
					flag_hasChar <= '0';	-- Limpa a flag / faz comunicação com o buffer antes de enviar o espaço
					nx_state <= espaco_3;
				WHEN espaco_3 =>
					latch_out <= char_espaco; 	--
					flag_hasChar <= '1';	-- Envia o espaco
					nx_state <= inicio;
				WHEN OTHERS =>
					nx_state <= inicio;					
			END CASE;
		END PROCESS;
		
		latch_char <= 	"00110000" WHEN latch_out = zero 	ELSE -- 0
							"00110001" WHEN latch_out = um 		ELSE -- 1
							"00110010" WHEN latch_out = dois 	ELSE -- 2
							"00110011" WHEN latch_out = tres 	ELSE -- 3
							"00110100" WHEN latch_out = quatro 	ELSE -- 4
							"00110101" WHEN latch_out = cinco 	ELSE -- 5
							"00110110" WHEN latch_out = seis 	ELSE -- 6
							"00110111" WHEN latch_out = sete 	ELSE -- 7
							"00111000" WHEN latch_out = oito 	ELSE -- 8
							"00111001" WHEN latch_out = nove 	ELSE -- 9
							"01000001" WHEN latch_out = a 		ELSE -- A 
							"01000010" WHEN latch_out = b 		ELSE -- B 
							"01000011" WHEN latch_out = c			ELSE -- C
							"01000100" WHEN latch_out = d			ELSE -- D 
							"01000101" WHEN latch_out = e			ELSE -- E 
							"01000110" WHEN latch_out = f			ELSE -- F 
							"01000111" WHEN latch_out = g			ELSE -- G 
							"01001000" WHEN latch_out = h			ELSE -- H 
							"01001001" WHEN latch_out = i			ELSE -- I 
							"01001010" WHEN latch_out = j			ELSE -- J 
							"01001011" WHEN latch_out = k			ELSE -- K 
							"01001100" WHEN latch_out = l			ELSE -- L 
							"01001101" WHEN latch_out = m			ELSE -- M 
							"01001110" WHEN latch_out = n			ELSE -- N
							"01001111" WHEN latch_out = o			ELSE -- O 
							"01010000" WHEN latch_out = p			ELSE -- P 
							"01010001" WHEN latch_out = q			ELSE -- Q 
							"01010010" WHEN latch_out = r			ELSE -- R 
							"01010011" WHEN latch_out = s			ELSE -- S 
							"01010100" WHEN latch_out = t			ELSE -- T 
							"01010101" WHEN latch_out = u			ELSE -- U 
							"01010110" WHEN latch_out = v			ELSE -- V 
							"01010111" WHEN latch_out = w			ELSE -- W 
							"01011000" WHEN latch_out = x			ELSE -- X
							"01011001" WHEN latch_out = y			ELSE -- Y 
							"01011010" WHEN latch_out = z			ELSE -- Z
							"00100000" WHEN latch_out = char_espaco 	ELSE
							latch_char;
			char_out <= latch_char;
	END ARCHITECTURE;
			
			