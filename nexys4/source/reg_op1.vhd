--------------------------------------------------------------------------------
-- Register for Operand 1 with Asyncronous Reset                              --
--                                                                            --
-- Master's Thesis Project 2014                                               --
-- Università della Svizzera Italiana                                         --
-- Master of Science in Informatics, Embedded System Design                   --
--                                                                            --
-- 05.07.2014, Simon Maurer                                                   --
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.param_pkg.all;

entity reg_op1 is
    port ( 
        clk      : in  std_logic;
        reset_n  : in  std_logic;
        load     : in  std_logic;
        data_in  : in  std_logic_vector(OP1_WIDTH);
        data_out : out std_logic_vector(OP1_WIDTH)
    );
end reg_op1;

architecture reg of reg_op1 is
begin
    process(clk, reset_n, load)
    begin
        if reset_n = '0' then
            data_out <= (others => '0');
        else
            if load = '1' and rising_edge(clk) then
                data_out <= data_in;
            end if;
        end if;
    end process;
end reg;
