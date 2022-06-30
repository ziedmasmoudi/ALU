library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
	port( A, B: in std_logic_vector(3 downto 0);				-- Two 4 bit inputs
			ALUControl: in std_logic_vector(2 downto 0);		-- ALU control signal 3 bits
			Y: out std_logic_vector(3 downto 0);				-- 4 bit output
			Flag: out std_logic										-- Flag
			); 
end entity; 

architecture Main of ALU is 

Signal C, AandB, AorB, s, SLT, NOTB: std_logic_vector(3 downto 0);
Signal ALUControl2: std_logic_vector(1 downto 0);

begin 

	
	NOTB <= NOT B;
	ALUControl2 <= '0' & ALUControl(2);
	
	-- Selecting for B or Not B
	-- Using 4:1 MUX as 2:1 MUX
	MUX: entity work.MUX(Main) port map(B, NOTB, "0000", "0000", ALUControl2, C); 

	-- Performing bitwise logical operations on inputs
	AandB <= A AND B;
	AorB <= A OR B;

	-- Adder to either add or subtract depending on ALUControl2
	ADD: entity work.Four_bit_adder(Main) port map(A, C, ALUControl(2), S, Flag);

	-- SLT takes sign of A-B
	SLT <= "000" & S(3);

	-- Final MUX to select output
	MUX2: entity work.MUX(Main) port map(AandB, AorB, S, SLT, ALUControl(1 downto 0), Y);

end architecture Main; 