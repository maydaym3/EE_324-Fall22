----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2022 02:27:09 PM
-- Design Name: 
-- Module Name: system - structural
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

entity system is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           stop : in STD_LOGIC;
           incr : in STD_LOGIC;
           SSDC : out STD_LOGIC_VECTOR (7 downto 0);
           SSDA : out STD_LOGIC_VECTOR (3 downto 0));
end system;

architecture structural of system is
        component btn_debounce
        port(clk,btn_in,rst : in std_logic;
            btn_out : out std_logic);
        end component;
      
        component stop_watch
        port(clk,rst,start,stop,incr : in std_logic;
            Cen,Clr : out std_logic);
        end component;
        
        component BCD_counter
        port(clk,rst,Cen_in : in std_logic;
            Cen_out : out std_logic;
            count_out : out std_logic_vector (3 downto 0)
            );
        end component;
        
        component clock_divider
        port(clk_in,rst : in STD_LOGIC;
            div : in STD_LOGIC_VECTOR (26 downto 0);
            clk_out : out STD_LOGIC
            );
        end component;
        
        component SSD_Controller
        Port (  BCD : in std_logic_vector (15 downto 0);
            DP  : in std_logic_vector (3 downto 0);
            clk : in std_logic;
            SSD_C : out std_logic_vector (7 downto 0);
            SSD_A : out std_logic_vector (3 downto 0)
        );
        end component;
            
        signal inputs : std_logic_vector (3 downto 0);
        signal Clr : std_logic; 
        signal Cen : std_logic;     
        signal count : std_logic_vector (15 downto 0);
        signal Cen_out : std_logic_vector (3 downto 0);
        signal Cen_in : std_logic_vector (3 downto 0);        
        signal Current_BCD : std_logic_vector (3 downto 0);
        signal kHz_clk :std_logic;
        signal display_clk :std_logic;
        
        
begin
        Cen_in(1) <= (Cen_in(0) and Cen_out(0));
        Cen_in(2) <= (Cen_in(1) and Cen_out(1));
        Cen_in(3) <= (Cen_in(2) and Cen_out(2));
        
        start_debnce: btn_debounce port map (clk=>kHz_clk,btn_in=>start,rst=>rst,btn_out=>inputs(0));
        stop_debnce : btn_debounce port map (clk=>kHz_clk,btn_in=>stop,rst=>rst,btn_out=>inputs(1));
        incr_debnce : btn_debounce port map (clk=>kHz_clk,btn_in=>incr,rst=>rst,btn_out=>inputs(2));
    
        stop_watch_inst : stop_watch port map (clk=>kHz_clk,rst=>rst,start=>inputs(0),stop=>inputs(1),incr=>inputs(2),Cen=>Cen_in(0),Clr=>Clr);
        
        C0 : BCD_counter port map (clk=>kHz_clk,rst=>rst,Cen_in=>Cen_in(0),Cen_out=>Cen_out(0),count_out=>count(3 downto 0));
        C1 : BCD_counter port map (clk=>kHz_clk,rst=>rst,Cen_in=>Cen_in(1),Cen_out=>Cen_out(1),count_out=>count(7 downto 4));
        C2 : BCD_counter port map (clk=>kHz_clk,rst=>rst,Cen_in=>Cen_in(2),Cen_out=>Cen_out(2),count_out=>count(11 downto 8));
        C3 : BCD_counter port map (clk=>kHz_clk,rst=>rst,Cen_in=>Cen_in(3),Cen_out=>Cen_out(3),count_out=>count(15 downto 12));
                
        stopwatch_clk : clock_divider port map(clk_in=>clk,div=>"000000000011000011010100000",rst=>rst,clk_out=>kHz_clk);
        
        SSD_Controller_inst : SSD_Controller port map(BCD=>count,DP=>"0111",clk=>clk,SSD_C=>SSDC,SSD_A=>SSDA);
    
end structural;
