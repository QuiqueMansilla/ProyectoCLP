library IEEE;
use IEEE.std_logic_1164.all;

entity genEna is
	generic(
		NC: natural := 4 
	);
	port(
		clk_i : in std_logic;
		rst_i : in std_logic;
		ena_i : in std_logic;
		q_o   : out std_logic
	);
end;

architecture genEna_arq of genEna is
	-- Parte declarativa
	signal cuenta : integer;
	
begin
	-- Parte descriptiva
	
	process(clk_i)
		variable aux: integer;
	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				aux := 0;
				q_o <= '0';
			elsif ena_i = '1' then
				aux := aux + 1;
				if aux = NC then
					q_o <= '1';
					aux := 0;
				else
					q_o <= '0';
				end if;
			end if;
		end if;
		cuenta <= aux;
	end process;
	
end;