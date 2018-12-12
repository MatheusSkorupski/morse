library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity buff_beer is
	
	generic(tam_max : integer := 15;
	transmitir : std_logic := '0');
   	
  port(flag_teclado_in : in std_logic;
		flag_tela_in, flag_tx_in : in std_logic;
		vet_in: in std_logic_vector(7 downto 0);
		vet_out_out: out std_logic_vector(7 downto 0);
		buffer_transmitido: out std_logic_vector(7 downto 0);
		flag_teclado_out, flag_tela_out, flag_tx_out : out std_logic;
		display7: out std_logic_vector(6 downto 0);
		cont_led: out std_logic_vector(6 downto 0);
		tam_buffer : out integer;
		clk, rst : in std_logic);
	
end buff_beer;

architecture buff_beer of buff_beer is
-- component buffer port(flag_teclado_in, flag_tela_in, transmitir : in std_logic;
--								vet_in(7 downto 0): in std_logic_vector;
--								vet_out(7 downto 0): out std_logic_vector;
--								flag_teclado_out, flag_tela_out : out std_logic); 
-- end component;
--								
type array_of_vector is array(tam_max -1 downto 0) of std_logic_vector(7 downto 0);
type state_buffer is (QUO, TX, WAITTX, WRT, WRT1, WRT0, WAITWRT, RD, WAITRD);
signal pr_state, nx_state: state_buffer;
signal vet_out: std_logic_vector(7 downto 0) := (others => '0');

begin
--U1: buffer port map( );

process(clk, rst)

begin
	if (rst = '0') then
		pr_state <= QUO;
	elsif (rising_edge(clk) and clk = '1') then
		pr_state <= nx_state;
	end if;
end process;

process(all)
variable vet_buffer: array_of_vector;
variable cont_buffer: integer range 0 to tam_max := 0;
begin
	case pr_state is
	
		WHEN QUO =>  -- espera um flag (status quo)
			
			tam_buffer <= cont_buffer;
			vet_buffer := vet_buffer;
			cont_buffer := cont_buffer;
			flag_tela_out <= '0';
			flag_teclado_out <= '0';
			flag_tx_out <= '0';
			vet_out <= vet_out;	
			buffer_transmitido <= vet_buffer(0);
		
			--display7 <= "1111001"; --1
			
			if flag_tx_in = '1' then
				nx_state <= TX;
			elsif flag_teclado_in = '1' then --preferencia para a leitura do teclado
				nx_state <= RD;
			elsif flag_tela_in = '1' then
				nx_state <= WRT;
			else
				nx_state <= QUO;
			end if;	
				
				
			if cont_buffer < 3 then		
				cont_led <= "1000000";
			elsif cont_buffer < 6  then		
				cont_led <= "1111001";
			elsif cont_buffer < 9 then		
				cont_led <= "0100100";
			elsif cont_buffer < 12 then		
				cont_led <= "0110000";
			else 
				cont_led <= "0000000";
			end if;
				
		WHEN TX =>
		
			tam_buffer <= cont_buffer;
			--vet_buffer := vet_buffer;
			--cont_buffer := cont_buffer;
			flag_tela_out <= '0';
			flag_teclado_out <= '0';
			flag_tx_out <= '1';	
			vet_out <= vet_out;			
			buffer_transmitido <= vet_buffer(0);
			
			vet_buffer(cont_buffer-1 downto 0) := vet_buffer(cont_buffer downto 1); --faz o shift 
			cont_buffer := cont_buffer - 1;			
			nx_state <= WAITTX;
			
		WHEN WAITTX =>

			tam_buffer <= cont_buffer;
			vet_buffer := vet_buffer;
			cont_buffer := cont_buffer;
			flag_tela_out <= '0';
			flag_teclado_out <= '0';
			flag_tx_out <= '1';	
			vet_out <= vet_out;			
			buffer_transmitido <= vet_buffer(0);
					
			if flag_tx_in = '0' then
				nx_state <= QUO;
			else
				nx_state <= WAITTX;
			end if; 
			
		WHEN RD => --LER a info repassada pelo teclado e armazena no buffer
		
			tam_buffer <= cont_buffer;
			--vet_buffer := vet_buffer;
			--cont_buffer := cont_buffer;
			flag_tela_out <= '0';
			flag_teclado_out <= '1';
			flag_tx_out <= '0';	
			vet_out <= vet_out;			
			buffer_transmitido <= vet_buffer(0);
			
			vet_buffer(cont_buffer) := vet_in;
			cont_buffer := cont_buffer + 1;
			nx_state <= WAITRD;
			
		WHEN WAITRD => -- ja leu e espera até a flag baixar
		
			tam_buffer <= cont_buffer;
			vet_buffer := vet_buffer;
			cont_buffer := cont_buffer;
			flag_tela_out <= '0';
			flag_teclado_out <= '1';
			flag_tx_out <= '0';	
			vet_out <= vet_out;			
			buffer_transmitido <= vet_buffer(0);
						
			if flag_teclado_in = '0' then
				nx_state <= QUO;
			else
				nx_state <= WAITRD;
			end if;
		
			--display7 <= "0110000"; --3
		
			
		WHEN WRT => -- le o buffer e ESCREVE info para a tela
			
			tam_buffer <= cont_buffer;
			vet_buffer := vet_buffer;
			cont_buffer := cont_buffer;
			flag_tela_out <= '1';
			flag_teclado_out <= '0';
			flag_tx_out <= '0';	
			vet_out <= vet_out;			
			buffer_transmitido <= vet_buffer(0);
			
			if(cont_buffer > 0) then
				nx_state <= WRT1;
			else
				nx_state <= WRT0;
			end if;
			
		WHEN WRT1 => --buffer nao vazio
		
			tam_buffer <= cont_buffer;
			--vet_buffer := vet_buffer;
			--cont_buffer := cont_buffer;
			flag_tela_out <= '1';
			flag_teclado_out <= '0';
			flag_tx_out <= '0';	
			--vet_out <= vet_out;			
			buffer_transmitido <= vet_buffer(0);
			
			vet_out <= vet_buffer(0);-- le do buffer
			vet_buffer(cont_buffer-1 downto 0) := vet_buffer(cont_buffer downto 1); --faz o shift 
			cont_buffer := cont_buffer - 1;
			nx_state <= WAITWRT;
		
		WHEN WRT0 => --buffer vazio, passa vetor de 0 pra saída
		
			tam_buffer <= cont_buffer;
			vet_buffer := vet_buffer;
			cont_buffer := cont_buffer;
			flag_tela_out <= '1';
			flag_teclado_out <= '0';
			flag_tx_out <= '0';	
			--vet_out <= vet_out;			
			buffer_transmitido <= vet_buffer(0);
			
			vet_out <= (OTHERS => '0'); --buffer vazio: manda o vetor de zeros
			nx_state <= WAITWRT;
		
		WHEN WAITWRT => -- espera até a flag baixar
			
			tam_buffer <= cont_buffer;
			vet_buffer := vet_buffer;
			cont_buffer := cont_buffer;
			flag_tela_out <= '1';
			flag_teclado_out <= '0';
			flag_tx_out <= '0';	
			vet_out <= vet_out;			
			buffer_transmitido <= vet_buffer(0);
			
			--display7 <= "0011001"; --4
			if flag_tela_in = '0' then
				nx_state <= QUO;
			else
				nx_state <= WAITWRT;
			end if;	
				
			
		WHEN RESETANDO => 
			tam_buffer <= cont_buffer;
			--vet_buffer := vet_buffer;
			--cont_buffer := cont_buffer;
			flag_tela_out <= '0';
			flag_teclado_out <= '0';
			flag_tx_out <= '0';	
			vet_out <= vet_out;			
			buffer_transmitido <= "00000000";
			
			--display7 <= "0000000"; --8
			vet_buffer(i):= (OTHERS => "00000000");
			cont_buffer := 0;
			nx_state <= QUO;
				
		end case;
end process;



vet_out_out <= vet_out;


end architecture;