----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2022 04:02:29 PM
-- Design Name: 
-- Module Name: SSD_decoder - Behavioral
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

entity SSD_decoder is
    Port ( BCD_Digit : in STD_LOGIC_VECTOR (3 downto 0);
           Cath_Out : out STD_LOGIC_VECTOR (6 downto 0));
end SSD_decoder;

architecture Behavioral of SSD_decoder is
    

begin
    decoder:process 
    begin
        case BCD_Digit is
        when "0000" => Cath_Out <= "1000000";
        when "0001" => Cath_Out <= "1111001";
        when "0010" => Cath_Out <= "0100100";
        when "0011" => Cath_Out <= "0110000";
        when "0100" => Cath_Out <= "0011001";
        when "0101" => Cath_Out <= "0010010";
        when "0110" => Cath_Out <= "0000010";
        when "0111" => Cath_Out <= "1111000";
        when "1000" => Cath_Out <= "0000000";
        when "1001" => Cath_Out <= "0010000";
        when "1010" => Cath_Out <= "0100000";
        when "1011" => Cath_Out <= "0000011";
        when "1100" => Cath_Out <= "1000110";
        when "1101" => Cath_Out <= "0100001";
        when "1110" => Cath_Out <= "0000110";
        when "1111" => Cath_Out <= "0001110";
        end case;
    end process;

end Behavioral;
