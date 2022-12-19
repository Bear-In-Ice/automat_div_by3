


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity div_by3 is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           din : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (1 downto 0));
end div_by3;

architecture Behavioral of div_by3 is
    type states is(S0,S1,S2);
    signal state, next_state : states := S0;
begin
    process(clk,rst) is
    begin
        if rst = '1' then
            state <= S0;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;
    
    process(state,din) is
    begin
        case(state) is 
            when S0 =>
                if din = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 =>
                if din = '1' then
                    next_state <= S0;
                else
                    next_state <= S2;
                end if; 
             when S2 =>
                if din = '1' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if; 
             when others =>
                null;             
        end case;
    end process;
    
    with state select
        dout <= "00" when S0,
                "01" when S1,
                "10" when others;
end Behavioral;
