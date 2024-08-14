library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contModN2 is
	generic(
		N : natural := 4
	);
	port(
		clk_i : in std_logic;
		rst_i : in std_logic;
		ena_i : in std_logic;
		mod_i : in std_logic_vector(N-1 downto 0); -- Modulo de cuenta
		q_o   : out std_logic_vector(N-1 downto 0)
		--max_o : out std_logic
	);
end;

architecture contModN2_arq of contModN2 is
	-- Parte declarativa
	
	component reg is
		generic(
			N: in natural := 4
		);
		port(
			clk_i : in std_logic;
			rst_i : in std_logic;
			ena_i : in std_logic;
			d_i   : in std_logic_vector(N-1 downto 0);
			q_o   : out std_logic_vector(N-1 downto 0)
		);
	end component;
	
	signal salReg : std_logic_vector(N-1 downto 0);
	signal salSum : std_logic_vector(N-1 downto 0);
	signal salOr  : std_logic;
	signal salAnd : std_logic;
	signal salComp:std_logic;
		
begin
	-- Parte descriptiva
		
	reg_inst: reg
		generic map(
			N => 4
		)
		port map(
			clk_i => clk_i,
			rst_i => salOr,
			ena_i => ena_i,
			d_i   => salSum,
			q_o   => salReg
		);
		
	-- mod_i <= "1111"
	
	salSum <= std_logic_vector(unsigned(salReg) + "0001");  
	
	salComp <= '1' when salReg = mod_i else '0';
	
	salAnd <= ena_i and salComp;
	
	salOr <= rst_i or salAnd;
	
	--max_o <= salComp;
	
	q_o <= salReg;
end;