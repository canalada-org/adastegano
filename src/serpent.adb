
------------------------------------------------------------------------------
--
-- Serpent Blockcipher - (C) Gisle Sælensminde 2000
--
--  An implementation of the AES candidate algorithm Serpent, made by        --
--  Gisle Sælensminde. The algorithm encrypts a 128 bit block on just below  --
--  800 clock cycles, depending on compiler version and options.             --
--  The implementation is based on the optimized sbox functions of           --
--  Dag Arne Osvik. For the principles behind the optimization, see          --
--  <URL: http://www.ii.uib.no/~gisle/serpent.html> or see the doc           --
--  directory if you downloaded this file from University of Bergen's site.  --
--                                                                           --
--  This implementation uses the specification and some utility functions    --
--  from Markus Kuhn's implementation, with modeifications by Michael Roe,   --
--  to keep it compatible with existing interfaces. Otherwise it is a        --
--  new implementation.                                                      --
                                                                             --
--                    (C) 1999 Gisle Sælensminde                             --
--                                                                           --
--   This is  free software;  you can  redistribute it  and/or  modify       --
--   it  under terms of the GNU  General  Public License as published by     --
--   the Free Software Foundation; either version 2, or (at your option)     --
--   any later version.   AdaGMP  is distributed  in the  hope  that  it     --
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     --
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     --
--   See the GNU General Public  License  for more details.  You  should     --
--   have received a copy of the  GNU General Public License distributed     --
--   with AdaGMP; see   file   COPYING.  If  not,  write  to  the   Free     --
--   Software  Foundation, 59   Temple Place -   Suite  330,  Boston, MA     --
--   02111-1307, USA.                                                        --
--                                                                           --
--   As a special exception, if  other  files instantiate generics  from     --
--   this unit, or  you link this  unit with other  files to produce  an     --
--   executable,  this  unit does  not  by  itself cause  the  resulting     --
--   executable to be  covered by the  GNU General Public License.  This     --
--   exception does  not  however invalidate any  other reasons  why the     --
--   executable file might be covered by the GNU Public License.             --
--                                                                           --
-------------------------------------------------------------------------------

with System; use System;
with Ada.Streams; use type Ada.Streams.Stream_Element_Offset;
with Ada.Unchecked_Conversion;

package body Serpent is


   -- Auxiliary functions for byte array to word array conversion with
   -- Bigendian/Littleendian handling.

   function Bytes_To_Word (Block : Cipher_Block; Offset : Block_Offset)
      return Unsigned_32 is
   begin
      return Unsigned_32 (Block (Offset)) +
         Shift_Left (Unsigned_32 (Block (Offset+1)), 8) +
         Shift_Left (Unsigned_32 (Block (Offset+2)), 16) +
         Shift_Left (Unsigned_32 (Block (Offset+3)), 24);
   end Bytes_To_Word;

   function Bytes_To_Word (Block : Key; Offset : Key_Offset)
      return Unsigned_32 is
   begin
      return Unsigned_32 (Block (Offset)) +
         Shift_Left (Unsigned_32 (Block (Offset+1)), 8) +
         Shift_Left (Unsigned_32 (Block (Offset+2)), 16) +
         Shift_Left (Unsigned_32 (Block (Offset+3)), 24);
   end Bytes_To_Word;

   function Words_To_Bytes (X0, X1, X2, X3 : Unsigned_32)
                            return Cipher_Block is
      Result : Cipher_Block;
   begin
      Result (0) := Ada.Streams.Stream_Element (X0 and 16#FF#);
      Result (1) := Ada.Streams.Stream_Element (Shift_Right (X0, 8) and 16#FF#);
      Result (2) := Ada.Streams.Stream_Element (Shift_Right (X0, 16) and 16#FF#);
      Result (3) := Ada.Streams.Stream_Element (Shift_Right (X0, 24) and 16#FF#);

      Result (4) := Ada.Streams.Stream_Element (X1 and 16#FF#);
      Result (5) := Ada.Streams.Stream_Element (Shift_Right (X1, 8) and 16#FF#);
      Result (6) := Ada.Streams.Stream_Element (Shift_Right (X1, 16) and 16#FF#);
      Result (7) := Ada.Streams.Stream_Element (Shift_Right (X1, 24) and 16#FF#);

      Result (8) := Ada.Streams.Stream_Element (X2 and 16#FF#);
      Result (9) := Ada.Streams.Stream_Element (Shift_Right (X2, 8) and 16#FF#);
      Result (10) := Ada.Streams.Stream_Element (Shift_Right (X2, 16) and 16#FF#);
      Result (11) := Ada.Streams.Stream_Element (Shift_Right (X2, 24) and 16#FF#);

      Result (12) := Ada.Streams.Stream_Element (X3 and 16#FF#);
      Result (13) := Ada.Streams.Stream_Element (Shift_Right (X3, 8) and 16#FF#);
      Result (14) := Ada.Streams.Stream_Element (Shift_Right (X3, 16) and 16#FF#);
      Result (15) := Ada.Streams.Stream_Element (Shift_Right (X3, 24) and 16#FF#);
      return Result;
   end Words_To_Bytes;

   pragma Inline(Bytes_To_Word, Words_To_Bytes);

   -- unchecked onversion functions to be used on little endian
   -- computers to convert from string to 4 32-bit words. Because
   -- serpent is defined to be litleendian, we need no moving of
   -- data in this case.

   type Uint32_array is array (1..4) of Unsigned_32;

   function Stream_To_Unsigned32 is new
     Ada.Unchecked_Conversion(Cipher_Block, Uint32_array);

   function Unsigned32_To_Stream is new
     Ada.Unchecked_Conversion(Uint32_array, Cipher_Block);

   -- Import of the machine generated encryption, decryption and
   -- key schedule functions, which is separate to avoid a
   -- mix of handwritten and machine generated code.

   procedure Do_Schedule(W : in out Key_Schedule) is separate;

   procedure Do_Encrypt(W : Key_Schedule;
                        R0, R1, R2, R3 : in out Unsigned_32) is separate;
   procedure Do_Decrypt(W : Key_Schedule;
                        R0, R1, R2, R3 : in out Unsigned_32) is separate;


   procedure New_Key (Key_Schedule : out Serpent_Key;
                      Key_Bits : in Key_Block_Variable_Length) is
      Expanded_Key : Key;
   begin

      for i in Key_Bits'Range loop
         Expanded_Key (i) := Key_Bits (i);
      end loop;
      if Key_Bits'Length < Expanded_Key'Length then
         Expanded_Key (Key_Bits'Last + 1) := 1;
         for i in Key_Bits'Last + 2 .. Expanded_Key'Last loop
            Expanded_Key (i) := 0;
         end loop;
      end if;

      for I in 0..7 loop
         Key_Schedule.Schedule(-8+I) := Bytes_To_Word(Expanded_Key, Key_Offset(4*I));
      end loop;
      Do_Schedule(Key_Schedule.Schedule);

   end New_Key;


   procedure Encrypt (Key : Serpent_Key;
                      Input  : in Cipher_Block;
                      Output : out Cipher_Block) is
      X0, X1, X2, X3 : Unsigned_32;
      words : Uint32_Array;
      W : Key_Schedule renames Key.schedule;
   begin

      if Default_Bit_Order = Low_Order_First then
         Words := Stream_To_Unsigned32(Input);
         X0 := Words(1);
         X1 := Words(2);
         X2 := Words(3);
         X3 := Words(4);
      else
         X0 := Bytes_To_Word(Input, 0);
         X1 := Bytes_To_Word(Input, 4);
         X2 := Bytes_To_Word(Input, 8);
         X3 := Bytes_To_Word(Input, 12);
      end if;

      Do_Encrypt(W, X0, X1, X2, X3);

      if Default_Bit_Order = Low_Order_First then
         Words(1) := X0;
         Words(2) := X1;
         Words(3) := X2;
         Words(4) := X3;
         Output := Unsigned32_To_Stream(Words);
      else
         Output := Words_To_Bytes (X0, X1, X2, X3);
      end if;
   end Encrypt;


   procedure Decrypt (Key : Serpent_Key;
                      Input : in Cipher_Block;
                      Output : out Cipher_Block) is
      X0, X1, X2, X3 : Unsigned_32;
      words : Uint32_Array;
      W : Key_Schedule renames Key.schedule;
   begin
      if Default_Bit_Order = Low_Order_First then
         Words := Stream_To_Unsigned32(Input);
         X0 := Words(1);
         X1 := Words(2);
         X2 := Words(3);
         X3 := Words(4);
      else
         X0 := Bytes_To_Word(Input, 0);
         X1 := Bytes_To_Word(Input, 4);
         X2 := Bytes_To_Word(Input, 8);
         X3 := Bytes_To_Word(Input, 12);
      end if;

      Do_Decrypt(W, X0,X1,X2,X3);

      if Default_Bit_Order = Low_Order_First then
         Words(1) := X0;
         Words(2) := X1;
         Words(3) := X2;
         Words(4) := X3;
         Output := Unsigned32_To_Stream(Words);
      else
         Output := Words_To_Bytes (X0, X1, X2, X3);
      end if;

   end Decrypt;

end Serpent;
