----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2022 05:20:45 PM
-- Design Name: 
-- Module Name: SSD_Controller - Behavioral
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

entity SSD_Controller is
    Port (  BCD : in std_logic_vector (15 downto 0);
            DP  : in std_logic_vector (3 downto 0);
            clk,rst : in std_logic;
            SSD_C : out std_logic_vector (7 downto 0);
            SSD_A : out std_logic_vector (3 downto 0)
     );
end SSD_Controller;

architecture Behavioral of SSD_Controller is

    signal display_clock : std_logic;
    signal anode_sel :unsigned (1 downto 0);
    signal cath_sel : std_logic_vector (3 downto 0);
        
    component clock_divider
    Port ( clk_in : in STD_LOGIC;
           div : in STD_LOGIC_VECTOR (26 downto 0);
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
    end component;
    
    component SSD_decoder    
    Port ( BCD_Digit : in STD_LOGIC_VECTOR (3 downto 0);
           Cath_Out : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
      
begin
    display_clk : clock_divider port map(clk_in=>clk,div=>"000000000000011000011010100",rst=>rst,clk_out=>display_clock);
    SSD_Cath_Decoder : SSD_decoder port map(BCD_Digit=>cath_sel,Cath_Out=>SSD_C(6 downto 0));
    
    anode_select:process (display_clock)
    begin
        if(rst = '1') then
            anode_sel <= "00";
        elsif(display_clock'event and display_clock = '1') then
            anode_sel <= anode_sel +1;
        end if;
                   
    end process;
    
    digit_display:process(display_clock)
    begin
        case (anode_sel) is
            when "00" =>
                SSD_A <= "1110";
                cath_sel <= BCD(3 downto 0);
                SSD_C(7) <= DP(0);
            when "01" =>
                SSD_A <= "1101";
                cath_sel <= BCD(7 downto 4);
                SSD_C(7) <= DP(1);            
            when "10" =>
                SSD_A <= "1011";
                cath_sel <= BCD(11 downto 8);
                SSD_C(7) <= DP(2);            
            when "11" =>
                SSD_A <= "0111";
                cath_sel <= BCD(15 downto 12);
                SSD_C(7) <= DP(3);            
        end case;
    end process;
    
    

end Behavioral;
