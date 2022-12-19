----------------------------------------------------------------------------------
-- Company:  DCI FEEI TUKE
-- Engineer: Norbert Ádám
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: divisibility_by_5 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divisibility_by_5 is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           din : in STD_LOGIC;
           dout : out STD_LOGIC);
end divisibility_by_5;

architecture Behavioral of divisibility_by_5 is

    type states is (S0, S1, S2, S3, S4);
    signal state, next_state : states := S0;

begin

	--state register
	process (clk, rst) is
	begin
		if rst = '1' then
			state <= S0;
		elsif rising_edge(clk) then
			state <= next_state;
		end if;
	end process;

	-- next state logic
	process(state, din) is
	begin
		case (state) is
			when S0 =>
				if din = '1' then
					next_state <= S1;
				else
					next_state <= S0;
				end if;
			when S1 =>
				if din = '1' then
                    next_state <= S3;
                else
                    next_state <= S2;
            end if;
			when S2 =>
				if din = '1' then
                    next_state <= S0;
                else
                    next_state <= S4;
            end if;
			when S3 =>
                if din = '1' then
                    next_state <= S2;
                else
                    next_state <= S1;
            end if;
			when S4 =>
                if din = '1' then
                    next_state <= S4;
                else
                    next_state <= S3;
            end if;
			when others =>
				next_state <= S0;
		end case;
	end process;
	
	-- output logic
	dout <= '1' when state = S0 else '0';
	
end Behavioral;
