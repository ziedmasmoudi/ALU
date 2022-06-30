library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 
entity ALU_Testbench is
end ALU_Testbench;
 
architecture Test of ALU_Testbench is
 
Signal A, B: std_logic_vector(3 downto 0);
Signal ALUControl: std_logic_vector(2 downto 0);
Signal Y, Y_v: std_logic_vector(3 downto 0);
Signal Flag, Flag_v: std_logic;
 
begin
	-- DUT
	ALU : entity work.ALU(Main) port map (A => A, 
													B => B, 
													ALUControl => ALUControl,
													Y => Y,
													Flag => Flag);

	-- ALU implemented differently for verification 
	ALU_verification : entity work.ALU_verification(Main) port map (A => A, 
													B => B, 
													ALUControl => ALUControl,
													Y => Y_v,
													Flag => Flag_v);
	-- Cycling through every possible combination of inputs
	PROC_INPUT : process
	begin
	 
	  for i in 0 to 2**A'length - 1 loop
		 A <= std_logic_vector(to_unsigned(i, A'length));
		 
		 for j in 0 to 2**B'length - 1 loop
			 B <= std_logic_vector(to_unsigned(j, B'length));
			 
			 for k in 0 to 2**ALUControl'length - 1 loop
				 ALUControl <= std_logic_vector(to_unsigned(k, ALUControl'length));
				 wait for 10 ns;
			 end loop;
			  
			 wait for 10 ns;
		 end loop;
		  
		 wait for 10 ns;
	  end loop;
	 
	  -- Wrapping back around to initial input
	  A <= (others => '0');
	  B <= (others => '0');
	  ALUControl <= (others => '0');
	  wait for 10 ns;
	 
	  report "Test: OK";
	 
	end process;
	
	PROC_CHECKER : process
	begin
		wait on ALUControl;
		wait for 1 ns;
		
		-- Matching outputs form DUT and verification ALU
		assert Y = Y_v 
			report " bits changed, should have been 1"
			severity failure;
		assert Flag = Flag_v 
			report " bits changed, should have been 1"
			severity failure;
		
	end process;
 
end architecture;