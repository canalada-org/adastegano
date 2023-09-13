-- This is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion. It is distributed in the hope that it will be useful, but WITHOUT  --
-- ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY     --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the Free Software Foundation,  59 Temple Place - Suite 330,  Boston, --
-- MA 02111-1307, USA.                                                      --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --

with Ada.Streams;

package AES_Cipher is

   pragma Pure (AES_Cipher);

   --                          Symmetric_Key
   --
   --  This object class represents a block cipher, or more precisely, a
   --  block cipher with the key fixed to a particular value.
   --
   --  Two methods are provided, Encrypt and Decrypt, which encrypt and
   --  decrypt data using the key (whose value is contained within the object)
   --
   --  The size of the blocks of data to be encrpted or decrypted is fixed
   --  at 128 bits (16 octets), as this is only block size supported by
   --  the Advanced Encryption Standard.

   subtype Block_Offset is Ada.Streams.Stream_Element_Offset range 0 .. 15;

   type Cipher_Block is array (Block_Offset) of Ada.Streams.Stream_Element;

   type Symmetric_Key is abstract tagged limited null record;

   procedure Encrypt (Key    : Symmetric_Key;
                      Input  : in Cipher_Block;
                      Output : out Cipher_Block) is abstract;

   procedure Decrypt (Key    : Symmetric_Key;
                      Input  : in Cipher_Block;
                      Output : out Cipher_Block) is abstract;

   --                     Symmetric_Key_128
   --
   --  This object class extends Symmetric_Key by adding the method New_Key,
   --  which permits the value of the encryption key to be changed. The
   --  '128' in the name of the class refers to the size of the encryption
   --  key: all members of this class have 128-bit keys (16 octets).
   --
   --  Support for other key sizes is provided by defining other extensions
   --  of the base class. These also have a method called New_Key, but it
   --  takes a different size key as parameter.
   --
   --  As Ada supports variable-length array parameters, you may wonder why
   --  things are done this way, rather than with a single class whose New_Key
   --  method takes a variable-length key. The reason is that for some
   --  block ciphers the implementation of the Encrypt and Decrypt methods
   --  change significantly when the key size changes. This approach allows
   --  the Encrypt and Decrypt methods to be overridden with an implementation
   --  that is optimized for a particular key length.
   --
   --  In addition, some protocols require the cryptographic algorithm to
   --  to have a particular block size - for example, some require the key
   --  size to equal the block size so that a key can be encrypted in one
   --  block. An implementation of such a protocol can refer to this class
   --  rather than the base class Symmetric_Key to indicate the fact that it
   --  will only work with algorithms of one particular key size.

   subtype Key_Offset is Ada.Streams.Stream_Element_Offset range 0 .. 15;
   type Key_Block is array (Key_Offset) of Ada.Streams.Stream_Element;

   type Symmetric_Key_128 is abstract new Symmetric_Key with null record;

   procedure New_Key (Key_Schedule : out Symmetric_Key_128;
                      Key_Bits : in Key_Block) is abstract;

   --                       Symmetric_Key_192
   --
   --  This object class is used for block ciphers with 192-bit keys.
   --  Apart from the key length, it is similar to Symmetric_Key_128.
   --
   --  The key sizes of 128, 192 and 256 bits have been selected because
   --  the Advanced Encryption Standard requires support for these three
   --  sizes.
   
   subtype Key_Offset_192 is Ada.Streams.Stream_Element_Offset range 0 .. 23;
   type Key_Block_192 is array (Key_Offset_192) of Ada.Streams.Stream_Element;

   type Symmetric_Key_192 is abstract new Symmetric_Key with null record;

   procedure New_Key (Key_Schedule : out Symmetric_Key_192;
                      Key_Bits : in Key_Block) is abstract;

   --                       Symmetric_Key_256
   --
   --  This object class is used for block ciphers with 256-bit keys.
   --  Apart from the key length, it is similar to Symmetric_Key_128.
   --
   --  The key sizes of 128, 192 and 256 bits have been selected because
   --  the Advanced Encryption Standard requires support for these three
   --  sizes.
   
   subtype Key_Offset_256 is Ada.Streams.Stream_Element_Offset range 0 .. 31;
   type Key_Block_256 is array (Key_Offset_256) of Ada.Streams.Stream_Element;

   type Symmetric_Key_256 is abstract new Symmetric_Key with null record;

   procedure New_Key (Key_Schedule : out Symmetric_Key_256;
                      Key_Bits : in Key_Block) is abstract;

   --                   Symmetric_Key_Variable_Length
   --
   --  This object class is used for block ciphers with variable length keys;
   --  That is, block ciphers where exactly the same encrypt and decrypt
   --  procedure can be used with different key lengths

   subtype Key_Offset_Variable_Length is Ada.Streams.Stream_Element_Offset;
   type Key_Block_Variable_Length is
      array (Key_Offset_Variable_Length range <>)
      of Ada.Streams.Stream_Element;

   type Symmetric_Key_Variable_Length is
      abstract new Symmetric_Key with null record;

   procedure New_Key (Key_Schedule : out Symmetric_Key_Variable_Length;
                      Key_Bits : in Key_Block_Variable_Length) is abstract;

   --                      Utility functions
   --
   --  The function To_String is used to convert cipher or key blocks to a
   --  printable representation

   function To_String (K : Cipher_Block) return String;

   function To_String (K : Key_Block) return String;

   function To_String (K : Key_Block_Variable_Length) return String;

   --  The function To_Key converts the hexdecimal string representation
   --  back into a key

   function To_Key (S : String) return Key_Block;

   function To_Key (S : String) return Key_Block_192;

   function To_Key (S : String) return Key_Block_256;

   function To_Key (S : String) return Key_Block_Variable_Length;

end AES_Cipher;
