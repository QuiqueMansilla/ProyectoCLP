library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwmModule_tb is
end;

architecture pwmModule_tb_arq of pwmModule_tb is
	-- parte declarativa
	
	component pwmModule is
		generic(
			N : natural := 4
		);
		port(
			clk_i   : in  std_logic;           
			rst_i   : in  std_logic;          
			mod_i   : in  std_logic_vector(N-1 downto 0); -- Período del PWM 
			ena_i   : in  std_logic;
			duty_i  : in  std_logic_vector(N-1 downto 0); -- Ciclo de trabajo
			q_o		: out std_logic_vector(N-1 downto 0); -- Salida del contador contModN2
			pwm_out : out std_logic
		);
	end component;
	
	constant N_tb: natural := 4;
	-- Declaracion de senales de prueba
	signal clk_tb     : std_logic := '0';
	signal rst_tb     : std_logic := '1';
	signal ena_tb     : std_logic := '1';
	signal mod_tb     : std_logic_vector(N_tb-1 downto 0) := std_logic_vector(to_unsigned(15, N_tb)); 
	signal duty_tb    : std_logic_vector(N_tb-1 downto 0) := std_logic_vector(to_unsigned(5, N_tb));
	signal q_o_tb     : std_logic_vector(N_tb-1 downto 0);
	signal pwm_out_tb : std_logic;
	
begin
	-- Parte descriptiva
	
	clk_tb <= not clk_tb after 10 ns;
	rst_tb <= '0' after 40 ns;
	ena_tb <= '0' after 5000 ns;
	
	-- En Port Map: en la columna de la izquierda estan los puertos que se conectan
	--				en la columna de la derecha están las señales que se conectan contra esos puertos
	DUT: pwmModule
		generic map(
			N => N_tb
		)
		port map( 
			clk_i   => clk_tb, 
			rst_i   => rst_tb,
			ena_i   => ena_tb,
			mod_i   => mod_tb,
			duty_i  => duty_tb,
			q_o	    => q_o_tb,
			pwm_out => pwm_out_tb
		);
	
end;