library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_ARITH.all;
use ieee.std_logic_UNSIGNED.all;

ENTITY jack IS
        	PORT(   clk 					            : IN        STD_LOGIC;          
                    reset                               : IN        STD_LOGIC;             
                    nic5, dime10, quart25, dollar       : IN        STD_LOGIC;          
					item40, item45, item50, item55		: IN        STD_LOGIC;          
					select1, return_change 				: IN        STD_LOGIC;           
					outproduct40, outproduct45 ,outproduct50, outproduct55	: OUT STD_LOGIC;   
               		outnic, outdime, outquart             :  OUT   integer range 0 to 35);    

END jack;


ARCHITECTURE behaviour OF jack IS

        TYPE STATE_TYPE IS (s0, s2, s3, s4); 
		SIGNAL state   : STATE_TYPE;
		signal sum : integer range 0 to 450;   
		signal change: integer range 0 to 450; 
		signal nic,dime,quart : integer range 0 to 35; 

 
BEGIN
 PROCESS (clk) 
begin
IF reset = '1' THEN
                state <= s0;
				sum <= 0;
				change <= 0;
				nic <= 0;
				dime <= 0;
				quart <=0;

elsif clk'EVENT and clk = '1' then 
	case state is
     WHEN S0 =>
                if nic5 = '1' then 
						sum <= sum + 5;
					elsif dime10 = '1' then 
						sum <= sum + 10;
					elsif quart25 = '1' then
						sum <= sum + 25;
					else dollar ='1' then
						sum <= sum + 100;
                    end if;                                           
					
				if  (sum > 200 or return_change = '1' or sum < 40 ) then
					--	change <= sum; 
					    state <= s3;
				elsif (sum < 200 or sum = 200) and (sum = 40 or sum > 40) then 
				    	state <= s2;
                else 
                    state <= s0;
  
			       end if;
    
when s2 =>
             if select1='1' then
				if item40 = '1' then
						change <= sum - 40;
						outproduct40 <= '1' ;
				elsif item45 = '1' then
						change <= sum - 45;
						outproduct45 <= '1' ;
				elsif item50 = '1' then
						change <= sum - 50;
						outproduct50 <= '1' ;
				else item55 = '1' then
						change <= sum - 55;
						outproduct55 <= '1' ;
				end if;
            
            

			elsif return_change ='1' then 
						state <= s3;
						
			else 
					sum <= change;
                    state <= s2;
             end if;

when s3 =>

		    if change = 0 then 
						state <= s0;
				else 
						state <= s4;
				
		    end if;


when s4 =>

		    if change >4 and change <9 then
						change <= change - 5;
						nic<= nic + 1;
						outnic <= nic;
				elsif  change > 9 and change < 24 then
				  		change <= change - 10;
						dime <= dime + 1;
						outdime <= dime;
			    else change > 24 then
						change <= change - 25;
					    quart <= quart + 1;
						outquart <= quart;
		    end if ;

   			state <= s2;

		end case;
	end if ;
end process ;

end behaviour;