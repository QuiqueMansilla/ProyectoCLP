library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwmModule is
	generic(
		N : natural := 4
	);
	port(
		clk_i   : in  std_logic;           
        rst_i   : in  std_logic;           
        mod_i   : in  std_logic_vector(N-1 downto 0);    -- Período del PWM 
		ena_i   : in  std_logic;
        duty_i  : in  std_logic_vector(N-1 downto 0);    -- Ciclo de trabajo 
		q_o		: out std_logic_vector(N-1 downto 0); -- Salida del contador contModN2
        pwm_out : out std_logic
	);
end;

architecture pwmModule_arq of pwmModule is
	-- Parte declarativa
	signal q_internal : std_logic_vector(N-1 downto 0);
		
	component contModN2 is
		generic(
			N : natural := 4
		);
		port(
			clk_i : in std_logic;
			rst_i : in std_logic;
			ena_i : in std_logic;
			mod_i : in std_logic_vector(N-1 downto 0); -- Modulo de cuenta --> Período
			q_o   : out std_logic_vector(N-1 downto 0)
		);
	end component;
	
	signal genEna_sal : std_logic;
	
begin
	-- Parte descriptiva
		
	contModN2_inst: contModN2
		generic map(
			N => 4
		)
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => genEna_sal,
			mod_i => mod_i,
			q_o   => q_internal
		);
		
	genEna_inst: entity work.genEna
		generic map(
			NC => 3 --N 
		)
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			q_o   => genEna_sal
		);
		
	-- Aqui ponemos las operaciones propias del Modulo pwm
	process (clk_i, rst_i)  
	begin  
		if rst_i = '1' then  
			pwm_out <= '0';
		elsif rising_edge(clk_i) then                                      -- pwm_out <= '1' when (q_o < mod_i) & (q_o < duty_i) else '0';
			if ena_i = '1' then
				if unsigned(q_internal) < unsigned(duty_i) then            -- compara entradas y establece salida pwm_out
					pwm_out <= '1';
				else
					pwm_out <= '0';
				end if;
			end if;
			if unsigned(q_internal) >= unsigned(mod_i) then
				pwm_out <= '1';
			end if;
		end if;
	end process;
	
	q_o <= q_internal;
	
end;