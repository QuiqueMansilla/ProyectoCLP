library IEEE;
use IEEE.std_logic_1164.all;

entity reg is
	generic(
		N: in natural := 4 -- Linea correcta
	);
	port(
		clk_i : in std_logic;
		rst_i : in std_logic;
		ena_i : in std_logic;
		d_i   : in std_logic_vector(N-1 downto 0);
		q_o   : out std_logic_vector(N-1 downto 0)
	);
end;

architecture reg_arq of reg is
	-- Parte declarativa
	
begin
	-- Parte descriptiva
	process(clk_i)
	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				q_o <= (others => '0'); -- (N-1 downto 0 => '0'); (N-1 downto 0) hace lo mismo que "others"
			elsif ena_i = '1' then
				q_o <= d_i;
			end if;
		end if;
	end process;
	
end;