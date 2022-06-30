library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_verification is 
	port( A, B: in std_logic_vector(3 downto 0);
			ALUControl: in std_logic_vector(2 downto 0);
			Y: out std_logic_vector(3 downto 0);
			Flag: out std_logic
			); 
end entity; 

architecture Main of ALU_verification is 

Signal C,AandB,AorB,s, SLT: std_logic_vector(3 downto 0);
Signal AplusB, AminusB: std_logic_vector(4 downto 0);

begin 

AplusB <= std_logic_vector(resize(unsigned(A) + unsigned(B), 5));
AminusB <= std_logic_vector(resize(unsigned(A) - unsigned(B), 5));
SLT <= ("0000") when (unsigned(A) >= unsigned(B)) else
		("0001") when (unsigned(A) < unsigned(B)) else
		"0000";

Y <=	 (A AND B) when (ALUControl = "000") else
       (A OR B) when (ALUControl = "001") else
       (AplusB(3 downto 0)) when (ALUControl = "010") else
		 (A AND (NOT B)) when (ALUControl = "100") else
		 (A OR (NOT B)) when (ALUControl = "101") else
		 (AminusB(3 downto 0)) when (ALUControl = "110") else
		 (SLT) when (ALUControl = "110") else
       "0000";
		 
Flag <= AplusB(4) or AminusB(4);

end architecture; 