------------------------------------------
------------------------------------------
---------- d_byte v0.2 -------------------
------------------------------------------
---------- Andres Soliño Klega -----------
---------- andres_age(AT)gmail.com -------
------------------------------------------
--
-- Byte handling package implementation for Ada95 
--
-- Version history
-- v0.2 * 18-July-2005
--         Function "Invert" was renamed to "Not" (both bit and byte)
--         Added boolean operations (Not, Or, And, Xor) (both bit and byte)
-- v0.1a * 10-July-2005 
--         Added Invert(Byte)
-- v0.1 * 03-July-2005 
--         The first one! :P

-------------------------------------------------------------------------------
----                                                                         --
--   This is  free software;  you can  redistribute it  and/or  modify       --
--   it  under terms of the GNU  General  Public License as published by     --
--   the Free Software Foundation; either version 2, or (at your option)     --
--   any later version.   d_byte is distributed  in the  hope  that  it     --
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



with Ada.Direct_Io;
with Io_Exceptions;
use Io_Exceptions;

package D_Byte is


   -- Bit is '1' or '0'
   type Bit is private; 

   -- Byte is a group of 8 bits.
   type Byte is private; 

   -- 'Position' represents the order of a bit in a byte.
   type Position is range 1 .. 8; 


   -- Type Binary File (use instead of file_type)
   type T_Binary_file is limited private; 

   type T_Mode is 
         (In_File,    
          Inout_File, 
          Out_File); 

   ---------------------------
   --- Byte/Bit operations ---
   ---------------------------

   -- ADT Constructors --

   -- Prec: -
   -- Post: Returns the correct byte '00000000'
   function Init_Byte return Byte; 

   -- Prec: -
   -- Post: Returns the correct bit '0'
   function Zero return Bit; 

   -- Prec: -
   -- Post: Returns the correct bit '1'
   function One return Bit; 

   ---------------------------------------
   ---------------------------------------



   -- Prec: b0..b7 are correct bits
   -- Post: Returns a byte composed by the bits b0 to b7.
   --       Ex: Create_byte(Zero,Zero,One,Zero,One,One,Zero,One) 
   --           returns '00101101'
   function Create_Byte (
         B0,      
         B1,      
         B2,      
         B3,      
         B4,      
         B5,      
         B6,      
         B7 : Bit ) 
     return Byte; 
   -- Note that Create_byte(Zero,Zero,Zero,Zero,Zero,Zero,Zero,Zero)=Init_byte


   -- Prec: B is a correct byte. Pos is a correct position.
   -- Post: Returns the bit of B with position "pos". By default,
   --        returns the less significant bit of B
   function Look_Bit (
         B   : in     Byte;         
         Pos : in     Position := 8 ) 
     return Bit; 

   -- Prec: Byte_to_change is a correct byte. Value is a correct bit. Pos is a correct position.
   -- Post: The bit with position "pos" of "Byte_to_change" is "value". By default, 
   --        the less significant bit of "Byte_to_change" is "value"
   procedure Change_Bit (
         Byte_To_Change : in out Byte;         
         Value          : in     Bit;          
         Pos            : in     Position := 8 ); 

   -- Prec: B is a correct bit
   -- Post: Returns TRUE is B is 0, otherwise FALSE
   function Is_Zero (
         B : Bit ) 
     return Boolean; 

   -- Prec: B is a correct bit
   -- Post: Returns TRUE is B is 1, otherwise FALSE
   function Is_One (
         B : Bit ) 
     return Boolean; 

   ---------------------------------------------------
   -- Conversion between bytes and (short) integers --
   ---------------------------------------------------

   -- Prec: I>=0 ^ I<=255
   -- Post: Returns the byte that corresponds to I
   function To_Byte (
         I : Integer ) 
     return Byte; 

   -- Prec: B is a correct byte
   -- Post: Returns the integer value between 0 and 255 that corresponds to B
   function To_Integer (
         B : Byte ) 
     return Integer; 

   ---------------------------------------------------
   -- Conversion between bytes and ASCII characters --
   ---------------------------------------------------

   -- Prec: C is an ASCII character
   -- Post: Returns the byte that corresponds to C
   function To_Byte (
         C : Character ) 
     return Byte; 

   -- Prec: B is a correct byte
   -- Post: Returns the ASCII character that corresponds to B
   function To_Character (
         B : Byte ) 
     return Character; 
   ------------------------------------------
   -- Conversion between bits and integers --
   ------------------------------------------

   -- Prec: I is an integer
   -- Post: Returns the bit '0' if I=0, otherwise returns '1'
   function To_Bit (
         I : Integer ) 
     return Bit; 

   -- Prec: B is a correct bit
   -- Post: Returns the integer value 0 or 1 that corresponds to B
   function To_Integer (
         B : Bit ) 
     return Integer; 




   --------------------------
   --- Boolean operations ---
   --------------------------

   -- Bits

   -- Prec: Right is a correct bit
   -- Post: Returns the inverted bit. If Right was '0' at the prec, now it's '1'. 
   --       If it was 1 at the prec, now it's '0'.
   function "NOT" (
         Right : in     Bit ) 
     return Bit; 
   -- Note that Not(zero)=One

   -- Prec: Left and Right are correct bits
   -- Post: Returns the boolean operation "Left AND Right"
   function "AND" (
         Left,              
         Right : in     Bit ) 
     return Bit; 

   -- Prec: Left and Right are correct bits
   -- Post: Returns the boolean operation "Left OR Right"
   function "OR" (
         Left,              
         Right : in     Bit ) 
     return Bit; 

   -- Prec: Left and Right are correct bits
   -- Post: Returns the boolean operation "Left XOR Right"
   function "XOR" (
         Left,              
         Right : in     Bit ) 
     return Bit; 

   -- Bytes

   -- Prec: Right is a correct Byte
   -- Post: Returns a byte whose bits are inverted. 
   --      Ex: If Right is '00001101', Not(B) returns '11110010'
   function "NOT" (
         Right : in     Byte ) 
     return Byte; 

   -- Prec: Left and Right are correct bytes
   -- Post: Returns the boolean operation "Left AND Right"
   function "AND" (
         Left,              
         Right : in     Byte) 
      return Byte;
      
  -- Prec: Left and Right are correct bytes
   -- Post: Returns the boolean operation "Left OR Right"
   function "OR" (
         Left,              
         Right : in     byte) 
     return byte; 

   -- Prec: Left and Right are correct bytes
   -- Post: Returns the boolean operation "Left XOR Right"
   function "XOR" (
         Left,              
         Right : in     byte) 
     return byte; 



   -----------------------
   --- File Management ---
   -----------------------


   procedure Create (
         File : in out T_Binary_file;               
         Mode : in     T_Mode  := Inout_File; 
         Name : in     String  := ""          ); 

   procedure Open (
         File : in out T_Binary_file; 
         Mode : in     T_Mode;  
         Name : in     String   ); 

   procedure Close (
         File : in out T_Binary_file ); 

   procedure Delete (
         File : in out T_Binary_file ); 

   procedure Reset (
         File : in out T_Binary_file; 
         Mode : in     T_Mode   ); 

   procedure Reset (
         File : in out T_Binary_file ); 

   function Mode (
         File : in     T_Binary_file ) 
     return T_Mode; 

   function Name (
         File : in     T_Binary_file ) 
     return String; 

   function Is_Open (
         File : in     T_Binary_file ) 
     return Boolean; 


   --------------
   -- In / Out --
   --------------

   procedure Read (
         File : in     T_Binary_file; 
         Item :    out Byte;    
         From : in     Positive ); 

   procedure Read (
         File : in     T_Binary_file; 
         Item :    out Byte     ); 

   procedure Write (
         File : in     T_Binary_file; 
         Item : in     Byte;    
         To   : in     Positive ); 

   procedure Write (
         File : in     T_Binary_file; 
         Item : in     Byte     ); 

   procedure Set_Index (
         File : in     T_Binary_file; 
         To   : in     Positive ); 

   function Index (
         File : in     T_Binary_file ) 
     return Positive; 

   function Size (
         File : in     T_Binary_file ) 
     return Natural; 

   function End_Of_File (
         File : in     T_Binary_file ) 
     return Boolean; 


   -- Exceptions

   Status_Error : exception renames Io_Exceptions.Status_Error;  
   Mode_Error   : exception renames Io_Exceptions.Mode_Error;  
   Name_Error   : exception renames Io_Exceptions.Name_Error;  
   Use_Error    : exception renames Io_Exceptions.Use_Error;  
   Device_Error : exception renames Io_Exceptions.Device_Error;  
   End_Error    : exception renames Io_Exceptions.End_Error;  
   Data_Error   : exception renames Io_Exceptions.Data_Error;  

private

   type Byte is mod 2**8; 
   type Bit is range 0 .. 1; 
   for Bit'Size use 1;

   -----------------------
   -- File management ---
   -----------------------

   -- Will use ada.Direct_IO 'cause is more complete than ada.Sequential_IO

   package Direct_Byte is new Ada.Direct_Io(Byte);
   use Direct_Byte;

   type T_Binary_file is new Direct_Byte.File_Type; 



end D_Byte;