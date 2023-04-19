
-- We can just compute for every input bit the sum, with and without carriage with the full adder. Then we put it back together.
--> NO, just make 2 carry ripple adders for 4 bit, and let them run parallel


library IEEE; use IEEE.STD_LOGIC_1164.all;  -- must be added before each entity/arch.
entity adder is
  port(a,b: in  std_ulogic_vector(7 downto 0);
       c:   in  std_ulogic;
       s:   out std_ulogic_vector(8 downto 0));
end;

library IEEE; use IEEE.STD_LOGIC_1164.all;
architecture adder_arch of adder is
  
  -- Initzialize the 2 components of the adder
  component adder_4bit
    port(a, b: in std_ulogic_vector(3 downto 0);
    c_in : in std_ulogic;
    sum : out std_ulogic_vector(3 downto 0);
    c_out: out std_ulogic);

  end component;

  component multiplexer
     port(a, b: in std_ulogic_vector(4 downto 0);
       control : in std_ulogic;
       c : out std_ulogic_vector(4 downto 0));
  end component;

  -- Intermediate carry declaration
  -- add1: First adder
  -- add2: second adder, carry_in 0
  -- add3: third adder,carry_in 1
  signal sum_add1: std_ulogic_vector(3 downto 0); -- The result of the first adder, the lower side of the overall result
  signal car_add1: std_ulogic; -- carry of the first adder, used as control-input for the multiplexer
  signal sum_add2: std_ulogic_vector(3 downto 0);
  signal car_add2: std_ulogic;
  signal sum_add3: std_ulogic_vector(3 downto 0);
  signal car_add3: std_ulogic;
  signal mul_out: std_ulogic_vector(4 downto 0); -- output of the multiplexer, upper part of final result


  begin
    add1: adder_4bit port map(a(3 downto 0), b(3 downto 0), c, sum_add1, car_add1); --Mapping the first 4 digits of the input of adder as input of add1
    add2: adder_4bit port map(a(7 downto 4), b(7 downto 4), '0', sum_add2, car_add2);
    add3: adder_4bit port map(a(7 downto 4), b(7 downto 4), '1', sum_add3, car_add3);

    mult: multiplexer port map(car_add3 & sum_add3(3 downto 0), car_add2 & sum_add2(3 downto 0), car_add1); -- Gets 2 5-bit inputs, which are created by combining carry and sum of the 4-bit adders

    s <= mul_out(4 downto 0) & sum_add1(3 downto 0);
  end adder_arch;

  

-- Multplexer gets 2 2-bit inputs (a, b), where a0 is the sum and a1 is the carry of the prev. addition
-- input a is the addition with carry, input b the addition without, hence a gets propagated if control = 1
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity multiplexer is
   port(a, b: in std_ulogic_vector(4 downto 0);
       control : in std_ulogic;
       c : out std_ulogic_vector(4 downto 0));
end multiplexer;
  
library IEEE; use IEEE.STD_LOGIC_1164.all;
architecture multiplexer_arch of multiplexer is
begin 
  multiplex_process : process(a, b, control) begin
    if(control = '1') then
      c <= a;
    else
      c <= b;
    end if;
  end process multiplex_process;
end multiplexer_arch;


-- 4-bit Adder
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity adder_4bit is
port(a, b: in std_ulogic_vector(3 downto 0);
    c_in : in std_ulogic;
    sum : out std_ulogic_vector(3 downto 0);
    c_out: out std_ulogic);
end adder_4bit;


library IEEE; use IEEE.STD_LOGIC_1164.all;
architecture adder_4bit_arch of adder_4bit is

-- Full Adder component
component full_adder
port(a, b, carry_in: in std_ulogic; -- input ports
  sum, carry_out: out std_ulogic); -- output ports
  end component;

-- Intermediate carry signals
signal c1, c2, c3 : std_ulogic;

begin

-- port mapping
-- Sets the first bit of the input of the 4bitadder as arguments for the full_adder (and output).
-- Sets the carry of the first full_adder to the intermediate signal c1, which is used as input for the second full_adder.
-- Uses the carriage input of the 4-bit adder as carriage input for the full_adder (useful for subtracting)
fa1: full_adder port map(a(0), b(0), c_in, sum(0), c1);
fa2: full_adder port map(a(1), b(1), c1, sum(1), c2);
fa3: full_adder port map(a(2), b(2), c2, sum(2), c3);
fa4: full_adder port map(a(3), b(3), c3, sum(3), c_out);

end adder_4bit_arch;


-- FROM SLIDES


-- Full adder from slide 42
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity full_adder is
  port(a, b, carry_in: in std_ulogic; -- input ports
  sum, carry_out: out std_ulogic); -- output ports
end full_adder;

-- Structural elements for full_adder, from slides (47)
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity half_adder is
  port (in1,in2: in std_ulogic; carry: out std_ulogic; sum: out std_ulogic);
end half_adder;

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

