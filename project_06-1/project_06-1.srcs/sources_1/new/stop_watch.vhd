----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2022 11:02:06 AM
-- Design Name: 
-- Module Name: stop_watch - Behavioral
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

entity stop_watch is
    Port ( clk      : in    STD_LOGIC;
           rst      : in    STD_LOGIC;
           start    : in    STD_LOGIC;
           stop     : in    STD_LOGIC;
           incr     : in    STD_LOGIC;
           Cen      : out   STD_LOGIC;
           Clr      : out   STD_LOGIC);
end stop_watch;

architecture state_codes of stop_watch is
    
    signal ps, ns : std_logic_vector (2 downto 0);    

begin

comb_logic:process (clk) begin
    case ps is 
        when "000" => 
            Cen <= '0';
            Clr <= '1';
            if(start = '1' and stop = '0' and incr = '0')       then ns <= "001";
            elsif(start = '0' and stop = '0' and incr = '1')    then ns <= "011";
            else                                                     ns <= "000";
            end if;
        when "001"=> 
            Cen <= '1';
            Clr <= '0';
            if(stop = '1' and start = '0')                      then ns <= "010";
            else                                                     ns <= "001";
            end if;
        when "010" => 
            Cen <= '0';
            Clr <= '0';
            if(stop = '0' and start = '1' and incr = '0')       then ns <= "001";
            elsif(incr = '1' and start = '0' and stop ='0')     then ns <= "011";
            else                                                     ns <= "010";
            end if;
        when "011"=>
            Cen <= '1';
            Clr <= '0';
            ns <= "100";
        when "100"=>
            Cen <= '0';
            Clr <= '0';
            if(incr = '0') then ns <= "010";
            else                ns <= "100";
            end if;            
        when "101"=>
            Cen <= '0';
            Clr <= '1';
            ns <= "000";
            
        when "110"=>
            Cen <= '0';
            Clr <= '1';
            ns <= "000";
        
        when "111"=>
            Cen <= '0';
            Clr <= '1';
            ns <= "000";
    end case;
    end process;
    
    state_reg:process (clk,rst) begin
        if rst='1' then ps <= "000";
        elsif (clk'event and clk ='1') then ps <= ns;
        end if;
        end process;
end state_codes;
