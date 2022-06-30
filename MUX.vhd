library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX is 
	port( A, B, C, D: in std_logic_vector(3 downto 0);		-- Four 4 bit inputs
			MUXControl: in std_logic_vector(1 downto 0);		-- 2 bit MUX control 
			Y: out std_logic_vector(3 downto 0)					-- 4 bit output
			); 
end entity; 

architecture Main of MUX is 

begin 
	
	with MUXControl select Y <=
	A when "00",
	B when "01",
	C when "10",
	D when "11",
	"0000" when others;

end architecture; 