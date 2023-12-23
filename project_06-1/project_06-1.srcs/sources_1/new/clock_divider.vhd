----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2022 04:42:46 PM
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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

entity clock_divider is
    Port ( clk_in : in STD_LOGIC;
           div : in STD_LOGIC_VECTOR (26 downto 0);
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

    signal counter : unsigned( 26 downto 0);
    signal divider : unsigned( 26 downto 0);
begin

    divider <= unsigned(div);
    
    clk_divider:process(clk_in,rst)
    begin
    if( rst = '1') then counter <= (others=> '0');
    elsif(clk_in'event and clk_in ='1') then
        if(counter = (divider-1)) then 
            counter <= (others=> '0');
            clk_out <= '1';
        else                       
            clk_out <= '0';
            counter <= counter +1;
        end if;
    end if;
    end process;

end Behavioral;
