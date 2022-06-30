library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Full_adder is 
	port (A, B, cin: 	in  std_logic; 
			S, cout: 	out std_logic); 
end entity; 

architecture Main of Full_adder is 

signal s0, cout_1, cout_2: std_logic; 

begin 

	Half_adder_1: entity work.Half_adder(Main) port map(A, B, s0, cout_1); 		-- Adding A and B
	Half_adder_2: entity work.Half_adder(Main) port map(s0, cin, S, cout_2); 	-- Adding carry in
	cout <= cout_1 or cout_2; 

end architecture; 