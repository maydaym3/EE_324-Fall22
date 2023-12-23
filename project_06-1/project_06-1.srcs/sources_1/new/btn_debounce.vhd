----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2022 11:45:28 AM
-- Design Name: 
-- Module Name: btn_debounce - Behavioral
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

entity btn_debounce is
    Port(
        clk     : in    std_logic;
        btn_in  : in    std_logic;
        rst     : in    std_logic;
        btn_out : out   std_logic
        );
        
end btn_debounce;

architecture debounce of btn_debounce is
        signal ps,ns : std_logic_vector (1 downto 0);
begin

    comb_logic: process (clk) begin
        case ps is
            when "00" =>
                btn_out <= '0';
                if (btn_in = '1') then  ns <= "01";
                else                    ns <= "00";
                end if;
            when "01" =>
                btn_out <= '0';
                if (btn_in = '1') then  ns <= "11";
                else                    ns <= "00";
                end if;
            when "11" =>
                btn_out <= '1';
                if (btn_in = '1') then  ns <= "11";
                else                    ns <= "10";
                end if;
            when "10" =>
                btn_out <= '1';
                if (btn_in = '1') then  ns <= "11";
                else                    ns <= "00";
                end if;
            end case;    
        end process;  

    state_reg:process (clk ,rst) begin
        if rst='1' then ps <= "00";
        elsif (clk'event and clk ='1') then ps <= ns;
        end if;
        end process;
        
end debounce;
