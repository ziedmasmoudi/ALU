library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Half_adder is 
	port (A, B: 		in std_logic; 
			S, Cout: 	out std_logic); 
end entity; 

architecture Main of Half_adder is 
begin 

	S <= A xor B; 
	Cout <= A and B; 

end architecture; 