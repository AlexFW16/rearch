library IEEE; use IEEE.STD_LOGIC_1164.all;  -- must be added before each entity/arch.
entity adder is
  port(a,b: in  std_ulogic_vector(7 downto 0);
       c:   in  std_ulogic;
       s:   out std_ulogic_vector(8 downto 0));
end;


--TODO implement conditional sum adder
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity full_adder is
  port(a,b,c: in STD_LOGIC;
       c_out, s: out STD_LOGIC);
end;

architecture behaviour of full_adder is
  begin
    c_out <= (a AND b) OR (a AND c) OR (b AND c);
    s <= a XOR b XOR c;
  end behaviour ; -- behaviour

architecture behaviour of adder is
  component full_adder
    port(a,b,c: in STD_LOGIC;
      c_out, s: out STD_LOGIC);
  end component;
  signal c1,c2,c3,c4,c5,c6,c7,c8,c20,c21,c30,c31,c40,c41,c50,c51,c60,c61,c70,c71,c80,c81,s10,s11,s20,s21,s30,s31,s40,s41,s50,s51,s60,s61,s70,s71: STD_LOGIC;
  constant zero : STD_LOGIC := '0';
  constant one : STD_LOGIC := '1';
begin
  fa0: full_adder port map(a(0),b(0),c,c1,s(0));
  fa10: full_adder port map(a(1),b(1),zero,c20,s10);
  fa11: full_adder port map(a(1),b(1),one,c21,s11);
  fa20: full_adder port map(a(2),b(2),zero,c30,s20);
  fa21: full_adder port map(a(2),b(2),one,c31,s21);
  fa30: full_adder port map(a(3),b(3),zero,c40,s30);
  fa31: full_adder port map(a(3),b(3),one,c41,s31);
  fa40: full_adder port map(a(4),b(4),zero,c50,s40);
  fa41: full_adder port map(a(4),b(4),one,c51,s41);
  fa50: full_adder port map(a(5),b(5),zero,c60,s50);
  fa51: full_adder port map(a(5),b(5),one,c61,s51);
  fa60: full_adder port map(a(6),b(6),zero,c70,s60);
  fa61: full_adder port map(a(6),b(6),one,c71,s61);
  fa70: full_adder port map(a(7),b(7),zero,c80,s70);
  fa71: full_adder port map(a(7),b(7),one,c81,s71);

  c2<= (c20 NAND NOT c1) NAND (c21 NAND c1);
  c3<= (c30 NAND NOT c2) NAND (c31 NAND c2);
  c4<= (c40 NAND NOT c3) NAND (c41 NAND c3);
  c5<= (c50 NAND NOT c4) NAND (c51 NAND c4);
  c6<= (c60 NAND NOT c5) NAND (c61 NAND c5);
  c7<= (c70 NAND NOT c6) NAND (c71 NAND c6);
  s(1)<= (s10 NAND NOT c1) NAND (s11 NAND c1);
  s(2)<= (s20 NAND NOT c2) NAND (s21 NAND c2);
  s(3)<= (s30 NAND NOT c3) NAND (s31 NAND c3);
  s(4)<= (s40 NAND NOT c4) NAND (s41 NAND c4);
  s(5)<= (s50 NAND NOT c5) NAND (s51 NAND c5);
  s(6)<= (s60 NAND NOT c6) NAND (s61 NAND c6);
  s(7)<= (s70 NAND NOT c7) NAND (s71 NAND c7);
  s(8)<= (c80 NAND NOT c7) NAND (c81 NAND c7);

end behaviour ; -- behaviour
