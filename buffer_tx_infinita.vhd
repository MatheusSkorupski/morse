library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity aps is
  generic();
   	
  port();
	
end aps;

architecture aps of aps is
 component buffer port(flag_teclado_in, flag_tela_in, flag_tx_in, flag_tx_infinita : in std_logic;
								vet_in: in std_logic_vector(7 downto 0);
								vet_out: out std_logic_vector(7 downto 0);
								buffer_transmitido, buffer_transmitido_infinito: out std_logic_vector(7 downto 0);
								-- buffer_transmitido_infinito
								flag_teclado_out, flag_tela_out, flag_tx_out : out std_logic;
								tam_buffer : out integer;
								clk, rst : in std_logic); 
 end component;
								
type array_of_vector is array(tam_max -1 downto 0) of std_logic_vector(7 downto 0);
type state_buffer is (QUO, TX, WRT, RD);
signal pr_state, nx_state: state_buffer;
signal vet_out: std_logic_vector(7 downto 0) := (others => '0');


begin
U1: buffer port map( );

process(clk, rst)

begin
	if (rst = '1') then
		pr_state <= QUO;
	elsif (clk'EVENT and clk='1') then
		pr_state <= nx_state;
	end if;
end process;

process(all)
variable vet_buffer: array_of_vector;
variable cont_buffer: integer range 0 to tam_max := 0;
variable flag_teclado_interm : std_logic :='0'; 
variable flag_tela_interm : std_logic :='0';
variable flag_tx_interm : std_logic := '0';
begin
	case pr_state is
		WHEN QUO =>  -- espera um flag (status quo)
		
			if flag_tx_in = '1' then
				nx_state <= TX;
			elsif flag_teclado_in = '1' then --preferencia para a leitura do teclado
				nx_state <= RD;
			elsif flag_tela_in = '1' then
				nx_state <= WRT;
			else
				nx_state <= QUO;
			end if;	
			
		WHEN TX =>
		
			tam_buffer <= cont_buffer;
			flag_tx_out <= flag_tx_interm;
			
			if flag_tx_in = '1' and flag_tx_interm = '0' and flag_tx_infinita = '0' then
				
				if(cont_buffer > 0) then
					
					buffer_transmitido <= vet_buffer(0);-- le do buffer
					vet_buffer(cont_buffer-1 downto 0) := vet_buffer(cont_buffer downto 1); --faz o shift 
					cont_buffer := cont_buffer - 1;
					flag_tx_interm := '1';
				else
					buffer_transmitido <= (OTHERS => '0'); --buffer vazio: manda o vetor de zeros
					flag_tela_interm := '1';
				end if;
				
			elsif flag_tx_in = '1' and flag_tx_interm = '0' and flag_tx_infinita = '1' then
			
				if(cont_buffer > 0) then
				
					buffer_transmitido <= vet_buffer(0);-- le do buffer
					buffer_transmitido_infinito <= vet_buffer(0);-- le do buffer
					vet_buffer(cont_buffer-1 downto 0) := vet_buffer(cont_buffer downto 1); --faz o shift 
					cont_buffer := cont_buffer - 1;
					flag_tx_interm := '1';
				else
					buffer_transmitido <= (OTHERS => '0'); --buffer vazio: manda o vetor de zeros
					flag_tela_interm := '1';
				end if;
			elsif flag_tx_in = '0' then
				flag_tx_interm := '0';
			end if;
			
			if flag_tx_in = '0' and flag_tx_interm = '0' then	
				nx_state <= QUO;
			else
				nx_state <= TX;
			end if;
				
		WHEN RD => --LER a info repassada pelo teclado e armazena no buffer
		
			flag_teclado_out <= flag_teclado_interm;
		
			if flag_teclado_in = '1' and flag_teclado_interm = '0' then
				vet_buffer(cont_buffer) := vet_in;
				cont_buffer := cont_buffer + 1;
				flag_teclado_interm := '1';
			elsif flag_teclado_in = '0' then
				flag_teclado_interm := '0';
			end if;
			
			if flag_teclado_in = '0' and flag_teclado_interm = '0' then
				nx_state <= QUO;
			else
				nx_state <= RD;
			end if;
			
		WHEN WRT => -- le o buffer e ESCREVE info para a tela
		
			flag_tela_out <= flag_tela_interm;
		
			if flag_tela_in = '1' and flag_tela_interm = '0' then
				if(cont_buffer > 0) then
					
					vet_out <= vet_buffer(0);-- le do buffer
					vet_buffer(cont_buffer-1 downto 0) := vet_buffer(cont_buffer downto 1); --faz o shift 
					cont_buffer := cont_buffer - 1;
					flag_tela_interm := '1';
				else
					vet_out <= (OTHERS => '0'); --buffer vazio: manda o vetor de zeros
					flag_tela_interm := '1';
				end if;
			elsif flag_tela_in = '0' then
				flag_tela_interm := '0';
			end if;
		
			if flag_tela_in = '0' and flag_tela_interm = '0' then
				nx_state <= QUO;
			else
				nx_state <= WRT;
			end if;
		end case;
end process;



end architecture;