
-------------------------------------------------------------------------------
--                                                                           --
--   Serpent Blockcipher                                                     --
--                                                                           --
--  $Id: serpent.ads,v 1.4 2000/03/22 13:01:22 gisle Exp $                   --
--                                                                           --
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

with Ada.Streams;
with Interfaces;
use Interfaces;
with AES_Cipher;
use AES_Cipher;

package Serpent is

   pragma Pure (Serpent);

   type Bytes is array (Integer range <>) of Unsigned_8;
   type Words is array (Integer range <>) of Unsigned_32;
   subtype Key_Offset is Ada.Streams.Stream_Element_Offset range 0 .. 31;
   type Key is array (Key_Offset) of Ada.Streams.Stream_Element;
   subtype Key_Schedule is Words (-8 .. 131);

   --procedure Prepare_Key (K : in Key; W : out Key_Schedule);

   type Serpent_Key is new AES_Cipher.Symmetric_Key_Variable_Length with
      record
         schedule : Key_Schedule;
      end record;

   procedure New_Key (Key_Schedule : out Serpent_Key;
                      Key_Bits : in Key_Block_Variable_Length);

   procedure Encrypt (Key : Serpent_Key;
                      Input : in Cipher_Block;
                      Output : out Cipher_Block);

   procedure Decrypt (Key : Serpent_Key;
                      Input : in Cipher_Block;
                      Output : out Cipher_Block);

end Serpent;
