LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY jack IS
	PORT
	(
		clk		: IN	STD_LOGIC;
		reset	: IN	STD_LOGIC;
		X		: IN	STD_LOGIC;
		Z		: OUT	STD_LOGIC
	);
END jack;

ARCHITECTURE a OF jack IS
	TYPE STATE_TYPE IS (A, B, C, D, E, F, G, H, I, J, K, L, M);
	SIGNAL state: STATE_TYPE;
BEGIN
	PROCESS (clk, reset)
	BEGIN
		IF reset = '1' THEN
			state <= A;
		ELSIF clk'EVENT AND clk = '1' THEN
			CASE state IS
				WHEN A =>
					IF X = '1' THEN
						state <= A;
						ELSE 
						state <= B;
						END IF;

				WHEN B =>
					IF X = '1' THEN
						state <= C;
						ELSE				
						state <= B;
						END IF;

				WHEN C =>
					IF X = '1' THEN
						state <= D;
						ELSE
						state <= B;
						END IF;

				WHEN D =>
					IF X = '1' THEN
						state <= A;
						ELSE
						state <= E;
						END IF;
					
				WHEN E =>
					IF X = '1' THEN
						state <= E;
						ELSE
						state <= F;
						END IF;
					
				WHEN F =>
					IF X = '1' THEN
						state <= G;
						ELSE
						state <= E;
						END IF;
					
				WHEN G =>
					IF X = '1' THEN
						state <= H;
						ELSE
						state <= F;
						END IF;
					
				WHEN H =>
					IF X = '1' THEN
						state <= I;
						ELSE
						state <= F;
						END IF;
					
				WHEN I =>
					IF X = '1' THEN
						state <= I;
						ELSE
						state <= J;
						END IF;
					
				WHEN J =>
					IF X = '1' THEN
						state <= K;
						ELSE
						state <= I;
						END IF;
					
				WHEN K =>
					IF X = '1' THEN
						state <= L;
						ELSE
						state <= J;
						END IF;
					
				WHEN L =>
					IF X = '1' THEN
						state <= M;
						ELSE
						state <= J;
						END IF;
                 
                WHEN M =>					
					IF (X = '1' OR X = '0') THEN
						state <= M;
					END IF; 				
			END CASE;
		END IF;
	END PROCESS;
					Z <= '1' WHEN state = M ELSE '0';
END a;