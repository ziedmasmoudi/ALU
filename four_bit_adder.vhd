library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bit_adder is 
	port( A,B: 		in 	std_logic_vector(3 downto 0); 	-- Two 4 bit inputs 
			cin: in std_logic;										-- Carry in
			S:		out 	std_logic_vector(3 downto 0);			-- Sum
			cout: out std_logic										-- Carry out
			); 
end entity; 

architecture Main of Four_bit_adder is 

signal c: std_logic_vector(3 downto 1); 

begin 

-- Bit by bit addition with cascading carry
	Full_adder_1: entity work.Full_adder(Main) port map(A(0), B(0), cin, S(0), c(1)); 
	Full_adder_2: entity work.Full_adder(Main) port map(A(1), B(1), c(1), S(1), c(2)); 
	Full_adder_3: entity work.Full_adder(Main) port map(A(2), B(2), c(2), S(2), c(3)); 
	Full_adder_4: entity work.Full_adder(Main) port map(A(3), B(3), c(3), S(3), cout); 

end architecture; 