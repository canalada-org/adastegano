separate(serpent)
procedure Do_Schedule(W : in out Key_Schedule) is
 R0, R1, R2, R3, R4 : Unsigned_32;
begin

   W(0) := Rotate_Left(W(0-8) xor W(0-5) xor
              W(0-3) xor W(0-1) xor
              16#9e3779b9# xor Unsigned_32(0), 11);

   W(0+1) := Rotate_Left(W(0-7) xor W(0-4) xor
              W(0-2) xor W(0-0) xor
              16#9e3779b9# xor Unsigned_32(0+1), 11);





   W(2) := Rotate_Left(W(2-8) xor W(2-5) xor
              W(2-3) xor W(2-1) xor
              16#9e3779b9# xor Unsigned_32(2), 11);

   W(2+1) := Rotate_Left(W(2-7) xor W(2-4) xor
              W(2-2) xor W(2-0) xor
              16#9e3779b9# xor Unsigned_32(2+1), 11);





   W(4) := Rotate_Left(W(4-8) xor W(4-5) xor
              W(4-3) xor W(4-1) xor
              16#9e3779b9# xor Unsigned_32(4), 11);

   W(4+1) := Rotate_Left(W(4-7) xor W(4-4) xor
              W(4-2) xor W(4-0) xor
              16#9e3779b9# xor Unsigned_32(4+1), 11);





   W(6) := Rotate_Left(W(6-8) xor W(6-5) xor
              W(6-3) xor W(6-1) xor
              16#9e3779b9# xor Unsigned_32(6), 11);

   W(6+1) := Rotate_Left(W(6-7) xor W(6-4) xor
              W(6-2) xor W(6-0) xor
              16#9e3779b9# xor Unsigned_32(6+1), 11);





   W(8) := Rotate_Left(W(8-8) xor W(8-5) xor
              W(8-3) xor W(8-1) xor
              16#9e3779b9# xor Unsigned_32(8), 11);

   W(8+1) := Rotate_Left(W(8-7) xor W(8-4) xor
              W(8-2) xor W(8-0) xor
              16#9e3779b9# xor Unsigned_32(8+1), 11);





   W(10) := Rotate_Left(W(10-8) xor W(10-5) xor
              W(10-3) xor W(10-1) xor
              16#9e3779b9# xor Unsigned_32(10), 11);

   W(10+1) := Rotate_Left(W(10-7) xor W(10-4) xor
              W(10-2) xor W(10-0) xor
              16#9e3779b9# xor Unsigned_32(10+1), 11);





   W(12) := Rotate_Left(W(12-8) xor W(12-5) xor
              W(12-3) xor W(12-1) xor
              16#9e3779b9# xor Unsigned_32(12), 11);

   W(12+1) := Rotate_Left(W(12-7) xor W(12-4) xor
              W(12-2) xor W(12-0) xor
              16#9e3779b9# xor Unsigned_32(12+1), 11);





   W(14) := Rotate_Left(W(14-8) xor W(14-5) xor
              W(14-3) xor W(14-1) xor
              16#9e3779b9# xor Unsigned_32(14), 11);

   W(14+1) := Rotate_Left(W(14-7) xor W(14-4) xor
              W(14-2) xor W(14-0) xor
              16#9e3779b9# xor Unsigned_32(14+1), 11);





   W(16) := Rotate_Left(W(16-8) xor W(16-5) xor
              W(16-3) xor W(16-1) xor
              16#9e3779b9# xor Unsigned_32(16), 11);

   W(16+1) := Rotate_Left(W(16-7) xor W(16-4) xor
              W(16-2) xor W(16-0) xor
              16#9e3779b9# xor Unsigned_32(16+1), 11);





   W(18) := Rotate_Left(W(18-8) xor W(18-5) xor
              W(18-3) xor W(18-1) xor
              16#9e3779b9# xor Unsigned_32(18), 11);

   W(18+1) := Rotate_Left(W(18-7) xor W(18-4) xor
              W(18-2) xor W(18-0) xor
              16#9e3779b9# xor Unsigned_32(18+1), 11);





   W(20) := Rotate_Left(W(20-8) xor W(20-5) xor
              W(20-3) xor W(20-1) xor
              16#9e3779b9# xor Unsigned_32(20), 11);

   W(20+1) := Rotate_Left(W(20-7) xor W(20-4) xor
              W(20-2) xor W(20-0) xor
              16#9e3779b9# xor Unsigned_32(20+1), 11);





   W(22) := Rotate_Left(W(22-8) xor W(22-5) xor
              W(22-3) xor W(22-1) xor
              16#9e3779b9# xor Unsigned_32(22), 11);

   W(22+1) := Rotate_Left(W(22-7) xor W(22-4) xor
              W(22-2) xor W(22-0) xor
              16#9e3779b9# xor Unsigned_32(22+1), 11);





   W(24) := Rotate_Left(W(24-8) xor W(24-5) xor
              W(24-3) xor W(24-1) xor
              16#9e3779b9# xor Unsigned_32(24), 11);

   W(24+1) := Rotate_Left(W(24-7) xor W(24-4) xor
              W(24-2) xor W(24-0) xor
              16#9e3779b9# xor Unsigned_32(24+1), 11);





   W(26) := Rotate_Left(W(26-8) xor W(26-5) xor
              W(26-3) xor W(26-1) xor
              16#9e3779b9# xor Unsigned_32(26), 11);

   W(26+1) := Rotate_Left(W(26-7) xor W(26-4) xor
              W(26-2) xor W(26-0) xor
              16#9e3779b9# xor Unsigned_32(26+1), 11);





   W(28) := Rotate_Left(W(28-8) xor W(28-5) xor
              W(28-3) xor W(28-1) xor
              16#9e3779b9# xor Unsigned_32(28), 11);

   W(28+1) := Rotate_Left(W(28-7) xor W(28-4) xor
              W(28-2) xor W(28-0) xor
              16#9e3779b9# xor Unsigned_32(28+1), 11);





   W(30) := Rotate_Left(W(30-8) xor W(30-5) xor
              W(30-3) xor W(30-1) xor
              16#9e3779b9# xor Unsigned_32(30), 11);

   W(30+1) := Rotate_Left(W(30-7) xor W(30-4) xor
              W(30-2) xor W(30-0) xor
              16#9e3779b9# xor Unsigned_32(30+1), 11);





   W(32) := Rotate_Left(W(32-8) xor W(32-5) xor
              W(32-3) xor W(32-1) xor
              16#9e3779b9# xor Unsigned_32(32), 11);

   W(32+1) := Rotate_Left(W(32-7) xor W(32-4) xor
              W(32-2) xor W(32-0) xor
              16#9e3779b9# xor Unsigned_32(32+1), 11);





   W(34) := Rotate_Left(W(34-8) xor W(34-5) xor
              W(34-3) xor W(34-1) xor
              16#9e3779b9# xor Unsigned_32(34), 11);

   W(34+1) := Rotate_Left(W(34-7) xor W(34-4) xor
              W(34-2) xor W(34-0) xor
              16#9e3779b9# xor Unsigned_32(34+1), 11);





   W(36) := Rotate_Left(W(36-8) xor W(36-5) xor
              W(36-3) xor W(36-1) xor
              16#9e3779b9# xor Unsigned_32(36), 11);

   W(36+1) := Rotate_Left(W(36-7) xor W(36-4) xor
              W(36-2) xor W(36-0) xor
              16#9e3779b9# xor Unsigned_32(36+1), 11);





   W(38) := Rotate_Left(W(38-8) xor W(38-5) xor
              W(38-3) xor W(38-1) xor
              16#9e3779b9# xor Unsigned_32(38), 11);

   W(38+1) := Rotate_Left(W(38-7) xor W(38-4) xor
              W(38-2) xor W(38-0) xor
              16#9e3779b9# xor Unsigned_32(38+1), 11);





   W(40) := Rotate_Left(W(40-8) xor W(40-5) xor
              W(40-3) xor W(40-1) xor
              16#9e3779b9# xor Unsigned_32(40), 11);

   W(40+1) := Rotate_Left(W(40-7) xor W(40-4) xor
              W(40-2) xor W(40-0) xor
              16#9e3779b9# xor Unsigned_32(40+1), 11);





   W(42) := Rotate_Left(W(42-8) xor W(42-5) xor
              W(42-3) xor W(42-1) xor
              16#9e3779b9# xor Unsigned_32(42), 11);

   W(42+1) := Rotate_Left(W(42-7) xor W(42-4) xor
              W(42-2) xor W(42-0) xor
              16#9e3779b9# xor Unsigned_32(42+1), 11);





   W(44) := Rotate_Left(W(44-8) xor W(44-5) xor
              W(44-3) xor W(44-1) xor
              16#9e3779b9# xor Unsigned_32(44), 11);

   W(44+1) := Rotate_Left(W(44-7) xor W(44-4) xor
              W(44-2) xor W(44-0) xor
              16#9e3779b9# xor Unsigned_32(44+1), 11);





   W(46) := Rotate_Left(W(46-8) xor W(46-5) xor
              W(46-3) xor W(46-1) xor
              16#9e3779b9# xor Unsigned_32(46), 11);

   W(46+1) := Rotate_Left(W(46-7) xor W(46-4) xor
              W(46-2) xor W(46-0) xor
              16#9e3779b9# xor Unsigned_32(46+1), 11);





   W(48) := Rotate_Left(W(48-8) xor W(48-5) xor
              W(48-3) xor W(48-1) xor
              16#9e3779b9# xor Unsigned_32(48), 11);

   W(48+1) := Rotate_Left(W(48-7) xor W(48-4) xor
              W(48-2) xor W(48-0) xor
              16#9e3779b9# xor Unsigned_32(48+1), 11);





   W(50) := Rotate_Left(W(50-8) xor W(50-5) xor
              W(50-3) xor W(50-1) xor
              16#9e3779b9# xor Unsigned_32(50), 11);

   W(50+1) := Rotate_Left(W(50-7) xor W(50-4) xor
              W(50-2) xor W(50-0) xor
              16#9e3779b9# xor Unsigned_32(50+1), 11);





   W(52) := Rotate_Left(W(52-8) xor W(52-5) xor
              W(52-3) xor W(52-1) xor
              16#9e3779b9# xor Unsigned_32(52), 11);

   W(52+1) := Rotate_Left(W(52-7) xor W(52-4) xor
              W(52-2) xor W(52-0) xor
              16#9e3779b9# xor Unsigned_32(52+1), 11);





   W(54) := Rotate_Left(W(54-8) xor W(54-5) xor
              W(54-3) xor W(54-1) xor
              16#9e3779b9# xor Unsigned_32(54), 11);

   W(54+1) := Rotate_Left(W(54-7) xor W(54-4) xor
              W(54-2) xor W(54-0) xor
              16#9e3779b9# xor Unsigned_32(54+1), 11);





   W(56) := Rotate_Left(W(56-8) xor W(56-5) xor
              W(56-3) xor W(56-1) xor
              16#9e3779b9# xor Unsigned_32(56), 11);

   W(56+1) := Rotate_Left(W(56-7) xor W(56-4) xor
              W(56-2) xor W(56-0) xor
              16#9e3779b9# xor Unsigned_32(56+1), 11);





   W(58) := Rotate_Left(W(58-8) xor W(58-5) xor
              W(58-3) xor W(58-1) xor
              16#9e3779b9# xor Unsigned_32(58), 11);

   W(58+1) := Rotate_Left(W(58-7) xor W(58-4) xor
              W(58-2) xor W(58-0) xor
              16#9e3779b9# xor Unsigned_32(58+1), 11);





   W(60) := Rotate_Left(W(60-8) xor W(60-5) xor
              W(60-3) xor W(60-1) xor
              16#9e3779b9# xor Unsigned_32(60), 11);

   W(60+1) := Rotate_Left(W(60-7) xor W(60-4) xor
              W(60-2) xor W(60-0) xor
              16#9e3779b9# xor Unsigned_32(60+1), 11);





   W(62) := Rotate_Left(W(62-8) xor W(62-5) xor
              W(62-3) xor W(62-1) xor
              16#9e3779b9# xor Unsigned_32(62), 11);

   W(62+1) := Rotate_Left(W(62-7) xor W(62-4) xor
              W(62-2) xor W(62-0) xor
              16#9e3779b9# xor Unsigned_32(62+1), 11);





   W(64) := Rotate_Left(W(64-8) xor W(64-5) xor
              W(64-3) xor W(64-1) xor
              16#9e3779b9# xor Unsigned_32(64), 11);

   W(64+1) := Rotate_Left(W(64-7) xor W(64-4) xor
              W(64-2) xor W(64-0) xor
              16#9e3779b9# xor Unsigned_32(64+1), 11);





   W(66) := Rotate_Left(W(66-8) xor W(66-5) xor
              W(66-3) xor W(66-1) xor
              16#9e3779b9# xor Unsigned_32(66), 11);

   W(66+1) := Rotate_Left(W(66-7) xor W(66-4) xor
              W(66-2) xor W(66-0) xor
              16#9e3779b9# xor Unsigned_32(66+1), 11);





   W(68) := Rotate_Left(W(68-8) xor W(68-5) xor
              W(68-3) xor W(68-1) xor
              16#9e3779b9# xor Unsigned_32(68), 11);

   W(68+1) := Rotate_Left(W(68-7) xor W(68-4) xor
              W(68-2) xor W(68-0) xor
              16#9e3779b9# xor Unsigned_32(68+1), 11);





   W(70) := Rotate_Left(W(70-8) xor W(70-5) xor
              W(70-3) xor W(70-1) xor
              16#9e3779b9# xor Unsigned_32(70), 11);

   W(70+1) := Rotate_Left(W(70-7) xor W(70-4) xor
              W(70-2) xor W(70-0) xor
              16#9e3779b9# xor Unsigned_32(70+1), 11);





   W(72) := Rotate_Left(W(72-8) xor W(72-5) xor
              W(72-3) xor W(72-1) xor
              16#9e3779b9# xor Unsigned_32(72), 11);

   W(72+1) := Rotate_Left(W(72-7) xor W(72-4) xor
              W(72-2) xor W(72-0) xor
              16#9e3779b9# xor Unsigned_32(72+1), 11);





   W(74) := Rotate_Left(W(74-8) xor W(74-5) xor
              W(74-3) xor W(74-1) xor
              16#9e3779b9# xor Unsigned_32(74), 11);

   W(74+1) := Rotate_Left(W(74-7) xor W(74-4) xor
              W(74-2) xor W(74-0) xor
              16#9e3779b9# xor Unsigned_32(74+1), 11);





   W(76) := Rotate_Left(W(76-8) xor W(76-5) xor
              W(76-3) xor W(76-1) xor
              16#9e3779b9# xor Unsigned_32(76), 11);

   W(76+1) := Rotate_Left(W(76-7) xor W(76-4) xor
              W(76-2) xor W(76-0) xor
              16#9e3779b9# xor Unsigned_32(76+1), 11);





   W(78) := Rotate_Left(W(78-8) xor W(78-5) xor
              W(78-3) xor W(78-1) xor
              16#9e3779b9# xor Unsigned_32(78), 11);

   W(78+1) := Rotate_Left(W(78-7) xor W(78-4) xor
              W(78-2) xor W(78-0) xor
              16#9e3779b9# xor Unsigned_32(78+1), 11);





   W(80) := Rotate_Left(W(80-8) xor W(80-5) xor
              W(80-3) xor W(80-1) xor
              16#9e3779b9# xor Unsigned_32(80), 11);

   W(80+1) := Rotate_Left(W(80-7) xor W(80-4) xor
              W(80-2) xor W(80-0) xor
              16#9e3779b9# xor Unsigned_32(80+1), 11);





   W(82) := Rotate_Left(W(82-8) xor W(82-5) xor
              W(82-3) xor W(82-1) xor
              16#9e3779b9# xor Unsigned_32(82), 11);

   W(82+1) := Rotate_Left(W(82-7) xor W(82-4) xor
              W(82-2) xor W(82-0) xor
              16#9e3779b9# xor Unsigned_32(82+1), 11);





   W(84) := Rotate_Left(W(84-8) xor W(84-5) xor
              W(84-3) xor W(84-1) xor
              16#9e3779b9# xor Unsigned_32(84), 11);

   W(84+1) := Rotate_Left(W(84-7) xor W(84-4) xor
              W(84-2) xor W(84-0) xor
              16#9e3779b9# xor Unsigned_32(84+1), 11);





   W(86) := Rotate_Left(W(86-8) xor W(86-5) xor
              W(86-3) xor W(86-1) xor
              16#9e3779b9# xor Unsigned_32(86), 11);

   W(86+1) := Rotate_Left(W(86-7) xor W(86-4) xor
              W(86-2) xor W(86-0) xor
              16#9e3779b9# xor Unsigned_32(86+1), 11);





   W(88) := Rotate_Left(W(88-8) xor W(88-5) xor
              W(88-3) xor W(88-1) xor
              16#9e3779b9# xor Unsigned_32(88), 11);

   W(88+1) := Rotate_Left(W(88-7) xor W(88-4) xor
              W(88-2) xor W(88-0) xor
              16#9e3779b9# xor Unsigned_32(88+1), 11);





   W(90) := Rotate_Left(W(90-8) xor W(90-5) xor
              W(90-3) xor W(90-1) xor
              16#9e3779b9# xor Unsigned_32(90), 11);

   W(90+1) := Rotate_Left(W(90-7) xor W(90-4) xor
              W(90-2) xor W(90-0) xor
              16#9e3779b9# xor Unsigned_32(90+1), 11);





   W(92) := Rotate_Left(W(92-8) xor W(92-5) xor
              W(92-3) xor W(92-1) xor
              16#9e3779b9# xor Unsigned_32(92), 11);

   W(92+1) := Rotate_Left(W(92-7) xor W(92-4) xor
              W(92-2) xor W(92-0) xor
              16#9e3779b9# xor Unsigned_32(92+1), 11);





   W(94) := Rotate_Left(W(94-8) xor W(94-5) xor
              W(94-3) xor W(94-1) xor
              16#9e3779b9# xor Unsigned_32(94), 11);

   W(94+1) := Rotate_Left(W(94-7) xor W(94-4) xor
              W(94-2) xor W(94-0) xor
              16#9e3779b9# xor Unsigned_32(94+1), 11);





   W(96) := Rotate_Left(W(96-8) xor W(96-5) xor
              W(96-3) xor W(96-1) xor
              16#9e3779b9# xor Unsigned_32(96), 11);

   W(96+1) := Rotate_Left(W(96-7) xor W(96-4) xor
              W(96-2) xor W(96-0) xor
              16#9e3779b9# xor Unsigned_32(96+1), 11);





   W(98) := Rotate_Left(W(98-8) xor W(98-5) xor
              W(98-3) xor W(98-1) xor
              16#9e3779b9# xor Unsigned_32(98), 11);

   W(98+1) := Rotate_Left(W(98-7) xor W(98-4) xor
              W(98-2) xor W(98-0) xor
              16#9e3779b9# xor Unsigned_32(98+1), 11);





   W(100) := Rotate_Left(W(100-8) xor W(100-5) xor
              W(100-3) xor W(100-1) xor
              16#9e3779b9# xor Unsigned_32(100), 11);

   W(100+1) := Rotate_Left(W(100-7) xor W(100-4) xor
              W(100-2) xor W(100-0) xor
              16#9e3779b9# xor Unsigned_32(100+1), 11);





   W(102) := Rotate_Left(W(102-8) xor W(102-5) xor
              W(102-3) xor W(102-1) xor
              16#9e3779b9# xor Unsigned_32(102), 11);

   W(102+1) := Rotate_Left(W(102-7) xor W(102-4) xor
              W(102-2) xor W(102-0) xor
              16#9e3779b9# xor Unsigned_32(102+1), 11);





   W(104) := Rotate_Left(W(104-8) xor W(104-5) xor
              W(104-3) xor W(104-1) xor
              16#9e3779b9# xor Unsigned_32(104), 11);

   W(104+1) := Rotate_Left(W(104-7) xor W(104-4) xor
              W(104-2) xor W(104-0) xor
              16#9e3779b9# xor Unsigned_32(104+1), 11);





   W(106) := Rotate_Left(W(106-8) xor W(106-5) xor
              W(106-3) xor W(106-1) xor
              16#9e3779b9# xor Unsigned_32(106), 11);

   W(106+1) := Rotate_Left(W(106-7) xor W(106-4) xor
              W(106-2) xor W(106-0) xor
              16#9e3779b9# xor Unsigned_32(106+1), 11);





   W(108) := Rotate_Left(W(108-8) xor W(108-5) xor
              W(108-3) xor W(108-1) xor
              16#9e3779b9# xor Unsigned_32(108), 11);

   W(108+1) := Rotate_Left(W(108-7) xor W(108-4) xor
              W(108-2) xor W(108-0) xor
              16#9e3779b9# xor Unsigned_32(108+1), 11);





   W(110) := Rotate_Left(W(110-8) xor W(110-5) xor
              W(110-3) xor W(110-1) xor
              16#9e3779b9# xor Unsigned_32(110), 11);

   W(110+1) := Rotate_Left(W(110-7) xor W(110-4) xor
              W(110-2) xor W(110-0) xor
              16#9e3779b9# xor Unsigned_32(110+1), 11);





   W(112) := Rotate_Left(W(112-8) xor W(112-5) xor
              W(112-3) xor W(112-1) xor
              16#9e3779b9# xor Unsigned_32(112), 11);

   W(112+1) := Rotate_Left(W(112-7) xor W(112-4) xor
              W(112-2) xor W(112-0) xor
              16#9e3779b9# xor Unsigned_32(112+1), 11);





   W(114) := Rotate_Left(W(114-8) xor W(114-5) xor
              W(114-3) xor W(114-1) xor
              16#9e3779b9# xor Unsigned_32(114), 11);

   W(114+1) := Rotate_Left(W(114-7) xor W(114-4) xor
              W(114-2) xor W(114-0) xor
              16#9e3779b9# xor Unsigned_32(114+1), 11);





   W(116) := Rotate_Left(W(116-8) xor W(116-5) xor
              W(116-3) xor W(116-1) xor
              16#9e3779b9# xor Unsigned_32(116), 11);

   W(116+1) := Rotate_Left(W(116-7) xor W(116-4) xor
              W(116-2) xor W(116-0) xor
              16#9e3779b9# xor Unsigned_32(116+1), 11);





   W(118) := Rotate_Left(W(118-8) xor W(118-5) xor
              W(118-3) xor W(118-1) xor
              16#9e3779b9# xor Unsigned_32(118), 11);

   W(118+1) := Rotate_Left(W(118-7) xor W(118-4) xor
              W(118-2) xor W(118-0) xor
              16#9e3779b9# xor Unsigned_32(118+1), 11);





   W(120) := Rotate_Left(W(120-8) xor W(120-5) xor
              W(120-3) xor W(120-1) xor
              16#9e3779b9# xor Unsigned_32(120), 11);

   W(120+1) := Rotate_Left(W(120-7) xor W(120-4) xor
              W(120-2) xor W(120-0) xor
              16#9e3779b9# xor Unsigned_32(120+1), 11);





   W(122) := Rotate_Left(W(122-8) xor W(122-5) xor
              W(122-3) xor W(122-1) xor
              16#9e3779b9# xor Unsigned_32(122), 11);

   W(122+1) := Rotate_Left(W(122-7) xor W(122-4) xor
              W(122-2) xor W(122-0) xor
              16#9e3779b9# xor Unsigned_32(122+1), 11);





   W(124) := Rotate_Left(W(124-8) xor W(124-5) xor
              W(124-3) xor W(124-1) xor
              16#9e3779b9# xor Unsigned_32(124), 11);

   W(124+1) := Rotate_Left(W(124-7) xor W(124-4) xor
              W(124-2) xor W(124-0) xor
              16#9e3779b9# xor Unsigned_32(124+1), 11);





   W(126) := Rotate_Left(W(126-8) xor W(126-5) xor
              W(126-3) xor W(126-1) xor
              16#9e3779b9# xor Unsigned_32(126), 11);

   W(126+1) := Rotate_Left(W(126-7) xor W(126-4) xor
              W(126-2) xor W(126-0) xor
              16#9e3779b9# xor Unsigned_32(126+1), 11);





   W(128) := Rotate_Left(W(128-8) xor W(128-5) xor
              W(128-3) xor W(128-1) xor
              16#9e3779b9# xor Unsigned_32(128), 11);

   W(128+1) := Rotate_Left(W(128-7) xor W(128-4) xor
              W(128-2) xor W(128-0) xor
              16#9e3779b9# xor Unsigned_32(128+1), 11);





   W(130) := Rotate_Left(W(130-8) xor W(130-5) xor
              W(130-3) xor W(130-1) xor
              16#9e3779b9# xor Unsigned_32(130), 11);

   W(130+1) := Rotate_Left(W(130-7) xor W(130-4) xor
              W(130-2) xor W(130-0) xor
              16#9e3779b9# xor Unsigned_32(130+1), 11);





      R0 := W(0+0);
      R1 := W(0+1);
      R2 := W(0+2);
      R3 := W(0+3);


      R4  := R0 ;
      R0  := R0  or R3 ;
      R3  := R3  xor R1 ;
      R1  := R1  and R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R0 ;
      R4  := R4  or  R1 ;
      R3  := R3  xor R4 ;
      R0  := R0  xor R1 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R2 ;
      R0  := R0  xor R3 ;
      R2  := R1 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R0 ;

      --Permutation: 1 2 3 4 0
      --w := R1 ; x := R2 ; y := R3 ; z := R4 ;

      W(0+0) := R1;
      W(0+1) := R2;
      W(0+2) := R3;
      W(0+3) := R4;

      R0 := W(4+0);
      R1 := W(4+1);
      R2 := W(4+2);
      R3 := W(4+3);

      R4  := R0 ;
      R0  := R0  and R2 ;
      R0  := R0  xor R3 ;
      R2  := R2  xor R1 ;
      R2  := R2  xor R0 ;
      R3  := R3  or  R4 ;
      R3  := R3  xor R1 ;
      R4  := R4  xor R2 ;
      R1  := R3 ;
      R3  := R3  or  R4 ;
      R3  := R3  xor R0 ;
      R0  := R0  and R1 ;
      R4  := R4  xor R0 ;
      R1  := R1  xor R3 ;
      R1  := R1  xor R4 ;
      R4  := -1  xor R4 ;

      --Permutation: 2 3 1 4 0
      -- w := R2 ; x := R3 ; y := R1 ; z := R4 ;

      W(4+0) := R2;
      W(4+1) := R3;
      W(4+2) := R1;
      W(4+3) := R4;

      R0 := W(8+0);
      R1 := W(8+1);
      R2 := W(8+2);
      R3 := W(8+3);

      R1  := -1 xor  R1 ;
      R4  := R0 ;
      R0  := R0  xor R1 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R0 ;
      R2  := R2  xor R4 ;
      R3  := R3  xor R1 ;
      R3  := R3  or  R2 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R0 ;
      R1  := R1  and R2 ;
      R0  := R0  or  R1 ;
      R1  := R1  xor R4 ;
      R0  := R0  xor R2 ;
      R4  := R4  or  R3 ;
      R0  := R0  xor R4 ;
      R4  := -1  xor  R4 ;
      R1  := R1  xor R3 ;
      R4  := R4  and R2 ;
      R1  := -1  xor  R1 ;
      R4  := R4  xor R0 ;
      R1  := R1  xor R4 ;

      --Permutation: 3 1 2 0 4
      --w := R3 ; x := R1 ; y := R2 ; z := R0 ;




      W(8+0) := R3;
      W(8+1) := R1;
      W(8+2) := R2;
      W(8+3) := R0;

      R0 := W(12+0);
      R1 := W(12+1);
      R2 := W(12+2);
      R3 := W(12+3);


      R3  := R3  xor R0 ;
      R4  := R1 ;
      R1  := R1  and R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R1 ;
      R2  := R2  xor R4 ;
      R4  := -1  xor R4 ;
      R4  := R4  or  R1 ;
      R1  := R1  xor R3 ;
      R1  := R1  xor R4 ;
      R3  := R3  or  R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R3 ;

      --Permutation: 1 4 2 0 3
      --w := R1; x := R4; y := R2; z := R0;


      W(12+0) := R1;
      W(12+1) := R4;
      W(12+2) := R2;
      W(12+3) := R0;

      R0 := W(16+0);
      R1 := W(16+1);
      R2 := W(16+2);
      R3 := W(16+3);

      R4  := R2 ;
      R2  := R2  and R1 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R1 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R1 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R4 ;
      R0  := R0  xor R2 ;
      R3  := R3  xor R1 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R0 ;
      R3  := R3  xor R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  and R0 ;
      R4  := -1  xor R4 ;
      R2  := R2  xor R4 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R1 ;

      --Permutation: 2 4 3 0 1
      --w := R2 ; x := R4 ; y := R3 ; z := R0 ;


      W(16+0) := R2;
      W(16+1) := R4;
      W(16+2) := R3;
      W(16+3) := R0;

      R0 := W(20+0);
      R1 := W(20+1);
      R2 := W(20+2);
      R3 := W(20+3);



      R2  := -1  xor R2 ;
      R4  := R3 ;
      R3  := R3  and R0 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R4 ;
      R1  := R1  xor R3 ;
      R2  := R2  xor R0 ;
      R0  := R0  or  R1 ;
      R2  := R2  xor R1 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R2 ;
      R4  := R4  xor R3 ;
      R4  := R4  xor R0 ;
      R3  := -1  xor R3 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R3 ;

      --Permutation: 0 1 4 2 3
      --w := R0 ; x := R1 ; y := R4 ; z := R2 ;


      W(20+0) := R0;
      W(20+1) := R1;
      W(20+2) := R4;
      W(20+3) := R2;

      R0 := W(24+0);
      R1 := W(24+1);
      R2 := W(24+2);
      R3 := W(24+3);


      R0  := R0  xor R1 ;
      R1  := R1  xor R3 ;
      R3  := -1  xor R3 ;
      R4  := R1 ;
      R1  := R1  and R0 ;
      R2  := R2  xor R3 ;
      R1  := R1  xor R2 ;
      R2  := R2  or  R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R1 ;
      R3  := R3  xor R0 ;
      R4  := R4  xor R1 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R3 ;
      R2  := -1  xor R2 ;
      R0  := R0  xor R4 ;
      R4  := R4  or  R3 ;
      R2  := R2  xor R4 ;

      --Permutation: 1 3 0 2 4
      --w := R1 ; x := R3 ; y := R0 ; z := R2 ;


      W(24+0) := R1;
      W(24+1) := R3;
      W(24+2) := R0;
      W(24+3) := R2;

      R0 := W(28+0);
      R1 := W(28+1);
      R2 := W(28+2);
      R3 := W(28+3);

      R1  := R1  xor R3 ;
      R3  := -1  xor  R3 ;
      R2  := R2  xor R3 ;
      R3  := R3  xor R0 ;
      R4  := R1 ;
      R1  := R1  and R3 ;
      R1  := R1  xor R2 ;
      R4  := R4  xor R3 ;
      R0  := R0  xor R4 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R1 ;
      R3  := R3  xor R0 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R2 ;
      R2  := R2  and R3 ;
      R0  := -1  xor R0 ;
      R4  := R4  xor R2 ;

      --Permutation: 1 4 0 3 2
      -- w := R1 ; x := R4 ; y := R0 ; z := R3 ;


      W(28+0) := R1;
      W(28+1) := R4;
      W(28+2) := R0;
      W(28+3) := R3;

      R0 := W(32+0);
      R1 := W(32+1);
      R2 := W(32+2);
      R3 := W(32+3);


      R4  := R0 ;
      R0  := R0  or R3 ;
      R3  := R3  xor R1 ;
      R1  := R1  and R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R0 ;
      R4  := R4  or  R1 ;
      R3  := R3  xor R4 ;
      R0  := R0  xor R1 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R2 ;
      R0  := R0  xor R3 ;
      R2  := R1 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R0 ;

      --Permutation: 1 2 3 4 0
      --w := R1 ; x := R2 ; y := R3 ; z := R4 ;

      W(32+0) := R1;
      W(32+1) := R2;
      W(32+2) := R3;
      W(32+3) := R4;

      R0 := W(36+0);
      R1 := W(36+1);
      R2 := W(36+2);
      R3 := W(36+3);

      R4  := R0 ;
      R0  := R0  and R2 ;
      R0  := R0  xor R3 ;
      R2  := R2  xor R1 ;
      R2  := R2  xor R0 ;
      R3  := R3  or  R4 ;
      R3  := R3  xor R1 ;
      R4  := R4  xor R2 ;
      R1  := R3 ;
      R3  := R3  or  R4 ;
      R3  := R3  xor R0 ;
      R0  := R0  and R1 ;
      R4  := R4  xor R0 ;
      R1  := R1  xor R3 ;
      R1  := R1  xor R4 ;
      R4  := -1  xor R4 ;

      --Permutation: 2 3 1 4 0
      -- w := R2 ; x := R3 ; y := R1 ; z := R4 ;

      W(36+0) := R2;
      W(36+1) := R3;
      W(36+2) := R1;
      W(36+3) := R4;

      R0 := W(40+0);
      R1 := W(40+1);
      R2 := W(40+2);
      R3 := W(40+3);

      R1  := -1 xor  R1 ;
      R4  := R0 ;
      R0  := R0  xor R1 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R0 ;
      R2  := R2  xor R4 ;
      R3  := R3  xor R1 ;
      R3  := R3  or  R2 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R0 ;
      R1  := R1  and R2 ;
      R0  := R0  or  R1 ;
      R1  := R1  xor R4 ;
      R0  := R0  xor R2 ;
      R4  := R4  or  R3 ;
      R0  := R0  xor R4 ;
      R4  := -1  xor  R4 ;
      R1  := R1  xor R3 ;
      R4  := R4  and R2 ;
      R1  := -1  xor  R1 ;
      R4  := R4  xor R0 ;
      R1  := R1  xor R4 ;

      --Permutation: 3 1 2 0 4
      --w := R3 ; x := R1 ; y := R2 ; z := R0 ;




      W(40+0) := R3;
      W(40+1) := R1;
      W(40+2) := R2;
      W(40+3) := R0;

      R0 := W(44+0);
      R1 := W(44+1);
      R2 := W(44+2);
      R3 := W(44+3);


      R3  := R3  xor R0 ;
      R4  := R1 ;
      R1  := R1  and R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R1 ;
      R2  := R2  xor R4 ;
      R4  := -1  xor R4 ;
      R4  := R4  or  R1 ;
      R1  := R1  xor R3 ;
      R1  := R1  xor R4 ;
      R3  := R3  or  R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R3 ;

      --Permutation: 1 4 2 0 3
      --w := R1; x := R4; y := R2; z := R0;


      W(44+0) := R1;
      W(44+1) := R4;
      W(44+2) := R2;
      W(44+3) := R0;

      R0 := W(48+0);
      R1 := W(48+1);
      R2 := W(48+2);
      R3 := W(48+3);

      R4  := R2 ;
      R2  := R2  and R1 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R1 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R1 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R4 ;
      R0  := R0  xor R2 ;
      R3  := R3  xor R1 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R0 ;
      R3  := R3  xor R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  and R0 ;
      R4  := -1  xor R4 ;
      R2  := R2  xor R4 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R1 ;

      --Permutation: 2 4 3 0 1
      --w := R2 ; x := R4 ; y := R3 ; z := R0 ;


      W(48+0) := R2;
      W(48+1) := R4;
      W(48+2) := R3;
      W(48+3) := R0;

      R0 := W(52+0);
      R1 := W(52+1);
      R2 := W(52+2);
      R3 := W(52+3);



      R2  := -1  xor R2 ;
      R4  := R3 ;
      R3  := R3  and R0 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R4 ;
      R1  := R1  xor R3 ;
      R2  := R2  xor R0 ;
      R0  := R0  or  R1 ;
      R2  := R2  xor R1 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R2 ;
      R4  := R4  xor R3 ;
      R4  := R4  xor R0 ;
      R3  := -1  xor R3 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R3 ;

      --Permutation: 0 1 4 2 3
      --w := R0 ; x := R1 ; y := R4 ; z := R2 ;


      W(52+0) := R0;
      W(52+1) := R1;
      W(52+2) := R4;
      W(52+3) := R2;

      R0 := W(56+0);
      R1 := W(56+1);
      R2 := W(56+2);
      R3 := W(56+3);


      R0  := R0  xor R1 ;
      R1  := R1  xor R3 ;
      R3  := -1  xor R3 ;
      R4  := R1 ;
      R1  := R1  and R0 ;
      R2  := R2  xor R3 ;
      R1  := R1  xor R2 ;
      R2  := R2  or  R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R1 ;
      R3  := R3  xor R0 ;
      R4  := R4  xor R1 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R3 ;
      R2  := -1  xor R2 ;
      R0  := R0  xor R4 ;
      R4  := R4  or  R3 ;
      R2  := R2  xor R4 ;

      --Permutation: 1 3 0 2 4
      --w := R1 ; x := R3 ; y := R0 ; z := R2 ;


      W(56+0) := R1;
      W(56+1) := R3;
      W(56+2) := R0;
      W(56+3) := R2;

      R0 := W(60+0);
      R1 := W(60+1);
      R2 := W(60+2);
      R3 := W(60+3);

      R1  := R1  xor R3 ;
      R3  := -1  xor  R3 ;
      R2  := R2  xor R3 ;
      R3  := R3  xor R0 ;
      R4  := R1 ;
      R1  := R1  and R3 ;
      R1  := R1  xor R2 ;
      R4  := R4  xor R3 ;
      R0  := R0  xor R4 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R1 ;
      R3  := R3  xor R0 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R2 ;
      R2  := R2  and R3 ;
      R0  := -1  xor R0 ;
      R4  := R4  xor R2 ;

      --Permutation: 1 4 0 3 2
      -- w := R1 ; x := R4 ; y := R0 ; z := R3 ;


      W(60+0) := R1;
      W(60+1) := R4;
      W(60+2) := R0;
      W(60+3) := R3;

      R0 := W(64+0);
      R1 := W(64+1);
      R2 := W(64+2);
      R3 := W(64+3);


      R4  := R0 ;
      R0  := R0  or R3 ;
      R3  := R3  xor R1 ;
      R1  := R1  and R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R0 ;
      R4  := R4  or  R1 ;
      R3  := R3  xor R4 ;
      R0  := R0  xor R1 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R2 ;
      R0  := R0  xor R3 ;
      R2  := R1 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R0 ;

      --Permutation: 1 2 3 4 0
      --w := R1 ; x := R2 ; y := R3 ; z := R4 ;

      W(64+0) := R1;
      W(64+1) := R2;
      W(64+2) := R3;
      W(64+3) := R4;

      R0 := W(68+0);
      R1 := W(68+1);
      R2 := W(68+2);
      R3 := W(68+3);

      R4  := R0 ;
      R0  := R0  and R2 ;
      R0  := R0  xor R3 ;
      R2  := R2  xor R1 ;
      R2  := R2  xor R0 ;
      R3  := R3  or  R4 ;
      R3  := R3  xor R1 ;
      R4  := R4  xor R2 ;
      R1  := R3 ;
      R3  := R3  or  R4 ;
      R3  := R3  xor R0 ;
      R0  := R0  and R1 ;
      R4  := R4  xor R0 ;
      R1  := R1  xor R3 ;
      R1  := R1  xor R4 ;
      R4  := -1  xor R4 ;

      --Permutation: 2 3 1 4 0
      -- w := R2 ; x := R3 ; y := R1 ; z := R4 ;

      W(68+0) := R2;
      W(68+1) := R3;
      W(68+2) := R1;
      W(68+3) := R4;

      R0 := W(72+0);
      R1 := W(72+1);
      R2 := W(72+2);
      R3 := W(72+3);

      R1  := -1 xor  R1 ;
      R4  := R0 ;
      R0  := R0  xor R1 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R0 ;
      R2  := R2  xor R4 ;
      R3  := R3  xor R1 ;
      R3  := R3  or  R2 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R0 ;
      R1  := R1  and R2 ;
      R0  := R0  or  R1 ;
      R1  := R1  xor R4 ;
      R0  := R0  xor R2 ;
      R4  := R4  or  R3 ;
      R0  := R0  xor R4 ;
      R4  := -1  xor  R4 ;
      R1  := R1  xor R3 ;
      R4  := R4  and R2 ;
      R1  := -1  xor  R1 ;
      R4  := R4  xor R0 ;
      R1  := R1  xor R4 ;

      --Permutation: 3 1 2 0 4
      --w := R3 ; x := R1 ; y := R2 ; z := R0 ;




      W(72+0) := R3;
      W(72+1) := R1;
      W(72+2) := R2;
      W(72+3) := R0;

      R0 := W(76+0);
      R1 := W(76+1);
      R2 := W(76+2);
      R3 := W(76+3);


      R3  := R3  xor R0 ;
      R4  := R1 ;
      R1  := R1  and R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R1 ;
      R2  := R2  xor R4 ;
      R4  := -1  xor R4 ;
      R4  := R4  or  R1 ;
      R1  := R1  xor R3 ;
      R1  := R1  xor R4 ;
      R3  := R3  or  R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R3 ;

      --Permutation: 1 4 2 0 3
      --w := R1; x := R4; y := R2; z := R0;


      W(76+0) := R1;
      W(76+1) := R4;
      W(76+2) := R2;
      W(76+3) := R0;

      R0 := W(80+0);
      R1 := W(80+1);
      R2 := W(80+2);
      R3 := W(80+3);

      R4  := R2 ;
      R2  := R2  and R1 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R1 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R1 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R4 ;
      R0  := R0  xor R2 ;
      R3  := R3  xor R1 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R0 ;
      R3  := R3  xor R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  and R0 ;
      R4  := -1  xor R4 ;
      R2  := R2  xor R4 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R1 ;

      --Permutation: 2 4 3 0 1
      --w := R2 ; x := R4 ; y := R3 ; z := R0 ;


      W(80+0) := R2;
      W(80+1) := R4;
      W(80+2) := R3;
      W(80+3) := R0;

      R0 := W(84+0);
      R1 := W(84+1);
      R2 := W(84+2);
      R3 := W(84+3);



      R2  := -1  xor R2 ;
      R4  := R3 ;
      R3  := R3  and R0 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R4 ;
      R1  := R1  xor R3 ;
      R2  := R2  xor R0 ;
      R0  := R0  or  R1 ;
      R2  := R2  xor R1 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R2 ;
      R4  := R4  xor R3 ;
      R4  := R4  xor R0 ;
      R3  := -1  xor R3 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R3 ;

      --Permutation: 0 1 4 2 3
      --w := R0 ; x := R1 ; y := R4 ; z := R2 ;


      W(84+0) := R0;
      W(84+1) := R1;
      W(84+2) := R4;
      W(84+3) := R2;

      R0 := W(88+0);
      R1 := W(88+1);
      R2 := W(88+2);
      R3 := W(88+3);


      R0  := R0  xor R1 ;
      R1  := R1  xor R3 ;
      R3  := -1  xor R3 ;
      R4  := R1 ;
      R1  := R1  and R0 ;
      R2  := R2  xor R3 ;
      R1  := R1  xor R2 ;
      R2  := R2  or  R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R1 ;
      R3  := R3  xor R0 ;
      R4  := R4  xor R1 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R3 ;
      R2  := -1  xor R2 ;
      R0  := R0  xor R4 ;
      R4  := R4  or  R3 ;
      R2  := R2  xor R4 ;

      --Permutation: 1 3 0 2 4
      --w := R1 ; x := R3 ; y := R0 ; z := R2 ;


      W(88+0) := R1;
      W(88+1) := R3;
      W(88+2) := R0;
      W(88+3) := R2;

      R0 := W(92+0);
      R1 := W(92+1);
      R2 := W(92+2);
      R3 := W(92+3);

      R1  := R1  xor R3 ;
      R3  := -1  xor  R3 ;
      R2  := R2  xor R3 ;
      R3  := R3  xor R0 ;
      R4  := R1 ;
      R1  := R1  and R3 ;
      R1  := R1  xor R2 ;
      R4  := R4  xor R3 ;
      R0  := R0  xor R4 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R1 ;
      R3  := R3  xor R0 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R2 ;
      R2  := R2  and R3 ;
      R0  := -1  xor R0 ;
      R4  := R4  xor R2 ;

      --Permutation: 1 4 0 3 2
      -- w := R1 ; x := R4 ; y := R0 ; z := R3 ;


      W(92+0) := R1;
      W(92+1) := R4;
      W(92+2) := R0;
      W(92+3) := R3;

      R0 := W(96+0);
      R1 := W(96+1);
      R2 := W(96+2);
      R3 := W(96+3);


      R4  := R0 ;
      R0  := R0  or R3 ;
      R3  := R3  xor R1 ;
      R1  := R1  and R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R0 ;
      R4  := R4  or  R1 ;
      R3  := R3  xor R4 ;
      R0  := R0  xor R1 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R2 ;
      R0  := R0  xor R3 ;
      R2  := R1 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R0 ;

      --Permutation: 1 2 3 4 0
      --w := R1 ; x := R2 ; y := R3 ; z := R4 ;

      W(96+0) := R1;
      W(96+1) := R2;
      W(96+2) := R3;
      W(96+3) := R4;

      R0 := W(100+0);
      R1 := W(100+1);
      R2 := W(100+2);
      R3 := W(100+3);

      R4  := R0 ;
      R0  := R0  and R2 ;
      R0  := R0  xor R3 ;
      R2  := R2  xor R1 ;
      R2  := R2  xor R0 ;
      R3  := R3  or  R4 ;
      R3  := R3  xor R1 ;
      R4  := R4  xor R2 ;
      R1  := R3 ;
      R3  := R3  or  R4 ;
      R3  := R3  xor R0 ;
      R0  := R0  and R1 ;
      R4  := R4  xor R0 ;
      R1  := R1  xor R3 ;
      R1  := R1  xor R4 ;
      R4  := -1  xor R4 ;

      --Permutation: 2 3 1 4 0
      -- w := R2 ; x := R3 ; y := R1 ; z := R4 ;

      W(100+0) := R2;
      W(100+1) := R3;
      W(100+2) := R1;
      W(100+3) := R4;

      R0 := W(104+0);
      R1 := W(104+1);
      R2 := W(104+2);
      R3 := W(104+3);

      R1  := -1 xor  R1 ;
      R4  := R0 ;
      R0  := R0  xor R1 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R0 ;
      R2  := R2  xor R4 ;
      R3  := R3  xor R1 ;
      R3  := R3  or  R2 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R0 ;
      R1  := R1  and R2 ;
      R0  := R0  or  R1 ;
      R1  := R1  xor R4 ;
      R0  := R0  xor R2 ;
      R4  := R4  or  R3 ;
      R0  := R0  xor R4 ;
      R4  := -1  xor  R4 ;
      R1  := R1  xor R3 ;
      R4  := R4  and R2 ;
      R1  := -1  xor  R1 ;
      R4  := R4  xor R0 ;
      R1  := R1  xor R4 ;

      --Permutation: 3 1 2 0 4
      --w := R3 ; x := R1 ; y := R2 ; z := R0 ;




      W(104+0) := R3;
      W(104+1) := R1;
      W(104+2) := R2;
      W(104+3) := R0;

      R0 := W(108+0);
      R1 := W(108+1);
      R2 := W(108+2);
      R3 := W(108+3);


      R3  := R3  xor R0 ;
      R4  := R1 ;
      R1  := R1  and R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R1 ;
      R2  := R2  xor R4 ;
      R4  := -1  xor R4 ;
      R4  := R4  or  R1 ;
      R1  := R1  xor R3 ;
      R1  := R1  xor R4 ;
      R3  := R3  or  R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R3 ;

      --Permutation: 1 4 2 0 3
      --w := R1; x := R4; y := R2; z := R0;


      W(108+0) := R1;
      W(108+1) := R4;
      W(108+2) := R2;
      W(108+3) := R0;

      R0 := W(112+0);
      R1 := W(112+1);
      R2 := W(112+2);
      R3 := W(112+3);

      R4  := R2 ;
      R2  := R2  and R1 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R1 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R1 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R4 ;
      R0  := R0  xor R2 ;
      R3  := R3  xor R1 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R0 ;
      R3  := R3  xor R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  and R0 ;
      R4  := -1  xor R4 ;
      R2  := R2  xor R4 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R1 ;

      --Permutation: 2 4 3 0 1
      --w := R2 ; x := R4 ; y := R3 ; z := R0 ;


      W(112+0) := R2;
      W(112+1) := R4;
      W(112+2) := R3;
      W(112+3) := R0;

      R0 := W(116+0);
      R1 := W(116+1);
      R2 := W(116+2);
      R3 := W(116+3);



      R2  := -1  xor R2 ;
      R4  := R3 ;
      R3  := R3  and R0 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R4 ;
      R1  := R1  xor R3 ;
      R2  := R2  xor R0 ;
      R0  := R0  or  R1 ;
      R2  := R2  xor R1 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R2 ;
      R4  := R4  xor R3 ;
      R4  := R4  xor R0 ;
      R3  := -1  xor R3 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R3 ;

      --Permutation: 0 1 4 2 3
      --w := R0 ; x := R1 ; y := R4 ; z := R2 ;


      W(116+0) := R0;
      W(116+1) := R1;
      W(116+2) := R4;
      W(116+3) := R2;

      R0 := W(120+0);
      R1 := W(120+1);
      R2 := W(120+2);
      R3 := W(120+3);


      R0  := R0  xor R1 ;
      R1  := R1  xor R3 ;
      R3  := -1  xor R3 ;
      R4  := R1 ;
      R1  := R1  and R0 ;
      R2  := R2  xor R3 ;
      R1  := R1  xor R2 ;
      R2  := R2  or  R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R1 ;
      R3  := R3  xor R0 ;
      R4  := R4  xor R1 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R3 ;
      R2  := -1  xor R2 ;
      R0  := R0  xor R4 ;
      R4  := R4  or  R3 ;
      R2  := R2  xor R4 ;

      --Permutation: 1 3 0 2 4
      --w := R1 ; x := R3 ; y := R0 ; z := R2 ;


      W(120+0) := R1;
      W(120+1) := R3;
      W(120+2) := R0;
      W(120+3) := R2;

      R0 := W(124+0);
      R1 := W(124+1);
      R2 := W(124+2);
      R3 := W(124+3);

      R1  := R1  xor R3 ;
      R3  := -1  xor  R3 ;
      R2  := R2  xor R3 ;
      R3  := R3  xor R0 ;
      R4  := R1 ;
      R1  := R1  and R3 ;
      R1  := R1  xor R2 ;
      R4  := R4  xor R3 ;
      R0  := R0  xor R4 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R1 ;
      R3  := R3  xor R0 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R2 ;
      R2  := R2  and R3 ;
      R0  := -1  xor R0 ;
      R4  := R4  xor R2 ;

      --Permutation: 1 4 0 3 2
      -- w := R1 ; x := R4 ; y := R0 ; z := R3 ;


      W(124+0) := R1;
      W(124+1) := R4;
      W(124+2) := R0;
      W(124+3) := R3;

      R0 := W(128+0);
      R1 := W(128+1);
      R2 := W(128+2);
      R3 := W(128+3);


      R4  := R0 ;
      R0  := R0  or R3 ;
      R3  := R3  xor R1 ;
      R1  := R1  and R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R0 ;
      R4  := R4  or  R1 ;
      R3  := R3  xor R4 ;
      R0  := R0  xor R1 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R2 ;
      R0  := R0  xor R3 ;
      R2  := R1 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R0 ;

      --Permutation: 1 2 3 4 0
      --w := R1 ; x := R2 ; y := R3 ; z := R4 ;

      W(128+0) := R1;
      W(128+1) := R2;
      W(128+2) := R3;
      W(128+3) := R4;
end;
