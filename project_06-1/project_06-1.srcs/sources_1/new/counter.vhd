----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2022 01:33:33 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_counter is
    Port ( Cen_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Cen_out : out std_logic;
           count_out : out STD_LOGIC_VECTOR (3 downto 0));
end BCD_counter;

architecture Behavioral of BCD_counter is
    signal count : unsigned(3 downto 0);
    
begin
count_out <= std_logic_vector(count);

counter:process(clk,rst)
begin   
    if(rst = '1')then 
        Cen_out <= '0';
        count <=(others=> '0');
    elsif(clk'event and clk ='1') then
        if(Cen_in = '1') then
            if (count =8) then
                Cen_out <= '1';
                count <= count+1;
            elsif(count = 9) then
                Cen_out <= '0';
                count <= (others=> '0');
            else    
                Cen_out <= '0';
                count <= count +1;
            end if;
        end if;
    end if;
end process;

end Behavioral;
