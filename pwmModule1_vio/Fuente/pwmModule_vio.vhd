library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwmModule_vio is
	port(
		clk_i: in std_logic --usaremos clock de la placa
	);
end;

architecture pwmModule_vio_arq of pwmModule_vio is
	-- Parte declarativa
	constant N: natural := 4;
	
	component pwmModule is
		generic(
			N : natural := 4
		);
		port(
			clk_i   : in  std_logic;           
			rst_i   : in  std_logic_vector(0 downto 0);           
			mod_i   : in  std_logic_vector(N-1 downto 0); -- Período del PWM 
			ena_i   : in  std_logic_vector(0 downto 0);
			duty_i  : in  std_logic_vector(N-1 downto 0); -- Ciclo de trabajo 
			q_o		: out std_logic_vector(N-1 downto 0); -- Salida del contador contModN2
			pwm_out : out std_logic_vector(0 downto 0)
		);
	end component;
	
	component vio
        port (
            clk : in  std_logic;
            probe_out0 : out std_logic_vector(0 downto 0);
            probe_out1 : out std_logic_vector(0 downto 0);
            probe_out2 : out std_logic_vector(3 downto 0);
            probe_out3 : out std_logic_vector(3 downto 0)
          );
    end component;
    
    component ila
        port (
            clk : in std_logic;
            probe0 : in std_logic_vector(0 downto 0)
        );
    end component;
	
	signal probe_rst  : std_logic_vector(0 downto 0);
	signal probe_ena  : std_logic_vector(0 downto 0);
	signal probe_mod  : std_logic_vector(N-1 downto 0);
	signal probe_duty : std_logic_vector(N-1 downto 0);
	signal probe_pwm  : std_logic_vector(0 downto 0);
	
begin
	-- Parte descriptiva
		
	pwmModule_inst: pwmModule
		generic map(
			N => 4
		)
		port map(
			clk_i   => clk_i,
			rst_i   => probe_rst,
			ena_i   => probe_ena,
			mod_i   => probe_mod,
			duty_i  => probe_duty,
			pwm_out => probe_pwm
        );
		
	vio_inst : vio
          port map (
            clk => clk_i,
            probe_out0 => probe_rst,
            probe_out1 => probe_ena,
            probe_out2 => probe_mod,
            probe_out3 => probe_duty
          );
          
    your_instance_name : ila
          port map (
            clk => clk_i,
            probe0 => probe_pwm
          );
end;