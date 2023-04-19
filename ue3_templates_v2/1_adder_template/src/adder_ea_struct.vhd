
-- We can just compute for every input bit the sum, with and without carriage with the full adder. Then we put it back together.


library IEEE; use IEEE.STD_LOGIC_1164.all;  -- must be added before each entity/arch.
entity adder is
  port(a,b: in  std_ulogic_vector(7 downto 0);
       c:   in  std_ulogic;
       s:   out std_ulogic_vector(8 downto 0));
end;

library IEEE; use IEEE.STD_LOGIC_1164.all;
architecture adder_arch of adder is 
  component full_adder
    port(a, b, carry_in: in std_ulogic; -- input ports
  carry, sum: out std_ulogic);
  end component;

  component


begin

  

end adder_arch;

-- Full adder from slide 42
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity full_adder is
begin
  port(a, b, carry_in: in std_ulogic; -- input ports
  sum, carry_out: out std_ulogic); -- output ports
end full_adder;

-- Structural elements for full_adder, from slides (47)
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity half_adder is
  port (in1,in2: in std_ulogic; carry: out std_ulogic; sum: out std_ulogic);
end half_adder;

-- Multplexer gets 2 2-bit inputs (a, b), where a0 is the sum and a1 is the carry of the prev. addition
-- input a is the addition with carry, input b the addition without, hence a gets propagated if control = 1
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity multiplexer is
  port(a0, a1, b0, b1, control : in std_ulogic;
       carry, sum : out std_ulogic);

library IEEE; use IEEE.STD_LOGIC_1164.all;
architecture multiplexer_arch of multiplexer is
begin 
  multiplex_process : process (a0, a1, b0, b1, control) begin
    if(control = '0') then
      sum <= a0; carry <= a1;
    else
      sum <= b0; carry <= b1;

    end if;
  end process multiplex_process;


end multiplexer_arch;

library IEEE; use IEEE.STD_LOGIC_1164.all;
architecture structural of half_adder is
begin
  carry <= in1 and in2;
  sum <= in1 xor in2;
end structural;

-- Behaviour of full_adder, from slides (48)
architecture behavioral of full_adder is
  begin
    add_values : process (a, b, carry_in) begin
    if (a = '1' AND b = '1' AND carry_in = '1') then
      carry_out <= '1'; sum <= '1';
    elsif (a = '1' AND (b = '1' OR carry_in = '1')) then
      carry_out <= '1'; sum <= '0';
    elsif (b = '1' AND carry_in = '1') then
      carry_out <= '1'; sum <= '0';
    elsif (a = '1' OR b = '1' OR carry_in = '1' ) then
      carry_out <= '0'; sum <= '1';
    else
      carry_out <= '0'; sum <= '0';
    end if;
  end process add_values;
end behavioral;

