LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_ARITH.ALL;
USE ieee.std_logic_UNSIGNED.ALL;

ENTITY vndmc IS
        PORT(  clk             		  : IN  STD_LOGIC; 
               reset           		  : IN  STD_LOGIC;    
               nic5, dime10, quart25  : IN  STD_LOGIC; 
			   select1 				  : IN  STD_LOGIC; 
			   outproduct			  : OUT STD_LOGIC;
			   outnic   	          : OUT integer;
			   outdime, outquart  	  : OUT integer);                                 
END vndmc;

ARCHITECTURE a OF vndmc IS

        TYPE STATE_TYPE IS (s0,s1,s2,s3); 
			SIGNAL state   			: STATE_TYPE;
			SIGNAL sum 				: integer RANGE 0 TO 65;
			SIGNAL change			: integer RANGE 0 TO 20;
			SIGNAL nic, dime	    : integer;  
BEGIN

PROCESS (clk, reset) 

BEGIN

IF reset = '1' THEN

                state <= s0;
				sum <= 0;
				change <= 0;
				nic <= 0;
				dime <= 0;
				
ELSIF clk'EVENT AND clk = '1' THEN 
	CASE state IS

	WHEN S0 =>
            IF nic5 = '1' THEN 
			sum <= sum + 5;
			ELSIF dime10 = '1' THEN 
			sum <= sum + 10;
			ELSIF quart25 = '1' THEN
			sum <= sum + 25;
			ELSE 
			state <= s0;
		END IF;
			IF ((sum > 45) OR (sum = 45)) AND (select1 ='1') THEN
			state <= s1;
			ELSE 
			state <= s0;
		END IF;

	WHEN s1 =>

 -- if item65 = '1' then
		IF change <= sum - 45 THEN
		outproduct <= '1';
		ELSE
        state <= s2;
        END IF;

	WHEN s2 =>
			IF change = 0 THEN
			state <= s0;
			ELSE
			state <= s3;
		END IF;

	WHEN s3 =>
    if change >4 and change <9 then
  			 --change = 5 ;
			change <= change -5;
			nic<= nic + 1;
			outnic <= nic;
			ELSIF change > 9 and change < 24 then
			--change = 10 ; 
			change <= change - 10;
			dime <= dime + 1;
			outdime <= dime;
--change > 24 then
 --change = 25 then

-- change <= change -25;
--  quart <= quart + 1;
--  outquart <= quart;
			END IF ;
   --	state <= s2;
		END CASE;
	END IF ;
END PROCESS ;

END a;