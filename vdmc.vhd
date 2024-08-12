LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY vdmc IS
	PORT
	(
		clk											: IN STD_LOGIC;
		reset										: IN STD_LOGIC;
		Q, Di, Ni									: IN STD_LOGIC;
		PRODUCT, Nickel, Dime, FiftC, TwentyC, NC	: OUT STD_LOGIC
	);
END vdmc;

ARCHITECTURE a OF vdmc IS
	TYPE STATE_TYPE IS (A, B, C, D, E, F, G, H, I, J, K, L, M, N);
	SIGNAL state: STATE_TYPE;
BEGIN
	PROCESS (clk, reset)
	BEGIN
		IF reset = '1' THEN
			state <= A;
		ELSIF clk'EVENT AND clk = '1' THEN
			CASE state IS
				WHEN A =>
					IF Q = '1' THEN
						state <= B;
						ELSIF Di = '1' THEN
						state <= C;
						ELSIF Ni = '1' THEN 
						state <= D;
						ELSE state <= A;
					END IF;

				WHEN B =>
					IF Q = '1' THEN
						state <= J;
						PRODUCT <= '1';
						ELSIF Di = '1' THEN
						state <= E;
						ELSIF Ni = '1' THEN 
						state <= F;
						ELSE state <= A;
					END IF;

				WHEN C =>
					IF Q = '1' THEN
						state <= E;
						ELSIF Di = '1' THEN
						state <= G;
						ELSIF Ni = '1' THEN 
						state <= E;
						ELSE state <= A;
					END IF;
				
				WHEN D =>
					IF Q = '1' THEN
						state <= F;
						ELSIF Di = '1' THEN
						state <= E;
						ELSIF Ni = '1' THEN 
						state <= C;
						ELSE
						state <= A;
					END IF;
					
				WHEN E =>
					IF Q = '1' THEN
						state <= L;
						PRODUCT <= '1';
						ELSIF Di = '1' THEN
						state <= N;
						PRODUCT <= '1';
						ELSIF Ni = '1' THEN
						state <= I;
						ELSE state <= A;
					END IF;
					
				WHEN F =>
					IF Q = '1' THEN
						state <= K;
						PRODUCT <= '1';
						ELSIF Di = '1' THEN
						state <= I;
						ELSIF Ni = '1' THEN 
						state <= B;
						ELSE 
						state <= A;
					END IF;
					
				WHEN G =>
					IF Q = '1' THEN
						state <= N;
						ELSIF Di = '1' THEN
						state <= F;
						ELSIF Ni = '1' THEN 
						state <= B;
						ELSE 
						state <= A;
					END IF;
					
				WHEN H =>
					IF Q = '1' THEN
						state <= I;
						ELSIF Di = '1' THEN
						state <= B;
						ELSIF Ni = '1' THEN 
						state <= G;
						ELSE
						state <= A;
					END IF;
					
				WHEN I =>
					IF Q = '1' THEN
						state <= M;
						PRODUCT <= '1';
						ELSIF Di = '1' THEN
						state <= J;
						PRODUCT <= '1';
						ELSIF Ni = '1' THEN
						state <= N;
						ELSE 
						state <= A;
					END IF;
			END CASE;
		END IF;
	END PROCESS;
		Nickel  <= '1' WHEN state = J ELSE '0';
		Dime 	<= '1' WHEN state = K ELSE '0';
		FiftC 	<= '1' WHEN state = L ELSE '0';
		TwentyC	<= '1' WHEN state = M ELSE '0';
		NC 		<= '1' WHEN state = N ELSE '0';
END a;