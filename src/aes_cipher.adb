with Ada.Streams;
use type Ada.Streams.Stream_Element;
use type Ada.Streams.Stream_Element_Offset;

package body AES_Cipher is

   Hex_Digits : constant array (Ada.Streams.Stream_Element range 0 .. 15)
      of Character
      := ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
          'a', 'b', 'c', 'd', 'e', 'f');

   function To_String (K : Cipher_Block) return String is
      Result : String (1 .. 32);
   begin
      for i in K'Range loop
         Result (Integer (i)*2 + 1) := Hex_Digits (K (i) / 16);
         Result (Integer (i)*2 + 2) := Hex_Digits (K (i) and 15);
      end loop;
      return Result;
   end To_String;

   function To_String (K : Key_Block) return String is
      Result : String (1 .. 32);
   begin
      for i in K'Range loop
         Result (Integer (i)*2 + 1) := Hex_Digits (K (i) / 16);
         Result (Integer (i)*2 + 2) := Hex_Digits (K (i) and 15);
      end loop;
      return Result;
   end To_String;

   function To_String (K : Key_Block_Variable_Length) return String is
      Result : String (1 .. K'Length * 2);
   begin
      for i in K'Range loop
         Result (Integer (i)*2 + 1) := Hex_Digits (K (i) / 16);
         Result (Integer (i)*2 + 2) := Hex_Digits (K (i) and 15);
      end loop;
      return Result;
   end To_String;


   function Hex_Digit (C : Character) return Ada.Streams.Stream_Element is
   begin
      if C in '0' .. '9' then
         return Character'Pos (C) - Character'Pos ('0');
      elsif C in 'a' .. 'f' then
         return Character'Pos (C) - Character'Pos ('a') + 10;
      elsif C in 'A' .. 'F' then
         return Character'Pos (C) - Character'Pos ('A') + 10;
      else
         raise Constraint_Error;
      end if;
   end Hex_Digit;

   function To_Key (S : String) return Key_Block is
      Result : Key_Block;
   begin
      for i in Result'Range loop
         Result (i) :=
           16 * Hex_Digit (S (Integer (i * 2 + 1)))
           + Hex_Digit (S (Integer (i * 2 + 2)));
      end loop;
      return Result;
   end To_Key;
   
   function String16_To_Key (S : String) return Key_Block is
      Result : Key_Block;
   begin
      for i in Result'Range loop
         Result (i) :=character'pos( S (Integer (i+1)));
      end loop;
      return Result;
   end String16_To_Key;

   function To_Key (S : String) return Key_Block_192 is
      Result : Key_Block_192;
   begin
      for i in Result'Range loop
         Result (i) :=
            16 * Hex_Digit (S (Integer (i * 2 + 1)))
            + Hex_Digit (S (Integer (i * 2 + 2)));
      end loop;
      return Result;
   end To_Key;

   function To_Key (S : String) return Key_Block_256 is
      Result : Key_Block_256;
   begin
      for i in Result'Range loop
         Result (i) :=
            16 * Hex_Digit (S (Integer (i * 2 + 1)))
            + Hex_Digit (S (Integer (i * 2 + 2)));
      end loop;
      return Result;
   end To_Key;

   function To_Key (S : String) return Key_Block_Variable_Length is
      Result : Key_Block_Variable_Length (0 .. S'Length / 2 - 1);
   begin
      for i in Result'Range loop
         Result (i) :=
            16 * Hex_Digit (S (Integer (i * 2 + 1)))
            + Hex_Digit (S (Integer (i * 2 + 2)));
      end loop;
      return Result;
   end To_Key;

end AES_Cipher;
