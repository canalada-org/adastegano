------------------------------------------
------------------------------------------
---------- d_byte v0.2 -------------------
------------------------------------------
---------- Andres Soliño Klega -----------
---------- andres_age(AT)gmail.com -------
------------------------------------------

-- Version history
-- v0.2 * 18-July-2005
--         Function "Invert" was renamed to "Not" (both bit and byte)
--         Added boolean operations (Not, Or, And, Xor) (both bit and byte)
-- v0.1a * 10-July-2005 
--         Added Invert(Byte)
-- v0.1 * 03-July-2005 
--         The first one! :P

with Interfaces;
use Interfaces;
package body D_Byte is

   -----------------------
   --- Byte operations ---
   -----------------------



   -- ADT Constructors --

   -- Prec: -
   -- Post: Returns the correct byte '00000000'
   function Init_Byte return Byte is 
   begin
      return Byte(0);
   end Init_Byte;

   -- Prec: -
   -- Post: Returns the correct bit '0'
   function Zero return Bit is 
   begin
      return 0;
   end Zero;

   -- Prec: -
   -- Post: Returns the correct bit '1'
   function One return Bit is 
   begin
      return 1;
   end One;

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
     return Byte is 
      B : Integer := 0;  
   begin
      if Is_One(B7) then
         B:=B+(2**0);
      end if;
      if Is_One(B6) then
         B:=B+(2**1);
      end if;
      if Is_One(B5) then
         B:=B+(2**2);
      end if;
      if Is_One(B4) then
         B:=B+(2**3);
      end if;
      if Is_One(B3) then
         B:=B+(2**4);
      end if;
      if Is_One(B2) then
         B:=B+(2**5);
      end if;
      if Is_One(B1) then
         B:=B+(2**6);
      end if;
      if Is_One(B0) then
         B:=B+(2**7);
      end if;
      return Byte(B);
   end Create_Byte;


   -- Prec: B is a correct byte. Pos is a correct position.
   -- Post: Returns the bit of B with position "pos". By default,
   --        returns the less significant bit of B
   function Look_Bit (
         B   : in     Byte;         
         Pos : in     Position := 8 ) 
     return Bit is 
      Temp : Integer;  
   begin
      Temp:=Integer(B);
      if Pos/=8 then
         for I in 1..8-Positive(Pos) loop
            Temp:=Temp/2;
         end loop;
      end if;
      return Bit(Temp mod 2);
   end Look_Bit;


   -- Prec: Byte_to_change is a correct byte. Value is a correct bit. Pos is a correct position.
   -- Post: The bit with position "pos" of "Byte_to_change" is "value". By default, 
   --        the less significant bit of "Byte_to_change" is "value"
   procedure Change_Bit (
         Byte_To_Change : in out Byte;         
         Value          : in     Bit;          
         Pos            : in     Position := 8 ) is 
      Temp : Integer;  
      B    : Byte renames Byte_To_Change;  
   begin
      Temp:=Integer(B);
      -- Realizamos desplazamientos a la derecha del byte si el bit
      -- a cambiar no es el menos significativo
      if Pos/=8 then
         for I in 1..8-Positive(Pos) loop
            Temp:=Temp/2;
         end loop;
      end if;
      if Temp mod 2=1 and Is_Zero(Value) then
         B:=Byte(
            Integer(B) - 2** (8-Integer(Pos))
            );
      elsif Temp mod 2=0 and Is_One(Value) then
         B:=Byte(
            Integer(B) + 2** (8-Integer(Pos))
            );
      end if;
   end Change_Bit;


   -- Prec: B is a correct bit
   -- Post: Returns TRUE is B is 0, otherwise FALSE
   function Is_Zero (
         B : Bit ) 
     return Boolean is 
   begin
      return Integer(B)=0;
   end Is_Zero;

   -- Prec: B is a correct bit
   -- Post: Returns TRUE is B is 1, otherwise FALSE
   function Is_One (
         B : Bit ) 
     return Boolean is 
   begin
      return Integer(B)=1;
   end Is_One;




   -- Prec: I>=0 ^ I<=255
   -- Post: Returns the byte that corresponds to I
   function To_Byte (
         I : Integer ) 
     return Byte is 
   begin
      return Byte'Val(I);
   end To_Byte;

   -- Prec: B is a correct byte
   -- Post: Returns the integer value between 0 and 255 that corresponds to B
   function To_Integer (
         B : Byte ) 
     return Integer is 
   begin
      return Byte'Pos(B);
   end To_Integer;


   -- Prec: I is an integer
   -- Post: Returns the bit '0' is I=0, otherwise returns '1'
   function To_Bit (
         I : Integer ) 
     return Bit is 
   begin
      if I=0 then
         return 0;
      else
         return 1;
      end if;
   end To_Bit;

   -- Prec: B is a correct bit
   -- Post: Returns the integer value 0 or 1 that corresponds to B
   function To_Integer (
         B : Bit ) 
     return Integer is 
   begin
      if Is_Zero(B) then
         return 0;
      else
         return 1;
      end if;
   end To_Integer;

   -- Prec: C is an ASCII character
   -- Post: Returns the byte that corresponds to C
   function To_Byte (
         C : Character ) 
     return Byte is 
   begin
      return To_Byte(Character'Pos(C));
   end To_Byte;

   -- Prec: B is a correct byte
   -- Post: Returns the ASCII character that corresponds to B
   function To_Character (
         B : Byte ) 
     return Character is 
   begin
      return Character'Val(To_Integer(B));
   end To_Character;



   --------------------------
   --- Boolean operations ---
   --------------------------


   -- Prec: Right is a correct bit
   -- Post: Returns "not Right". If Right was '0' at the prec, now it's '1'. 
   --       If it was 1 at the prec, now it's '0'.
   function "NOT" (
         Right : in     Bit ) 
     return Bit is 
   begin
      if Right=1 then
         return 0;
      else
         return 1;
      end if;
   end "NOT";
   -- Note that Not(zero)=One

   -- Prec: Left and Right are correct bits
   -- Post: Returns the boolean operation "Left AND Right"
   function "AND" (
         Left,              
         Right : in     Bit ) 
     return Bit is 
   begin
      if Left=1 and Right=1 then
         return 1;
      else
         return 0;
      end if;
   end "AND";

   -- Prec: Left and Right are correct bits
   -- Post: Returns the boolean operation "Left OR Right"
   function "OR" (
         Left,              
         Right : in     Bit ) 
     return Bit is 
   begin
      if Left=1 or Right=1 then
         return 1;
      else
         return 0;
      end if;
   end "OR";


   -- Prec: Left and Right are correct bits
   -- Post: Returns the boolean operation "Left XOR Right"
   function "XOR" (
         Left,              
         Right : in     Bit ) 
     return Bit is 
   begin
      case Left+Right is
         when 1 =>
            return 1;
         when others=>
            return 0;
      end case;
   end "XOR";




   -- Prec: Right is a correct Byte
   -- Post: Returns a byte whose bits are inverted. 
   --      Ex: If Right is '00001101', Not(B) returns '11110010'
   function "NOT" (
         Right : in     Byte ) 
     return Byte is 
   begin
      return Byte(not Unsigned_8(Right));
   end "NOT";


   -- Prec: Left and Right are correct bytes
   -- Post: Returns the boolean operation "Left AND Right"
   function "AND" (
         Left,               
         Right : in     Byte ) 
     return Byte is 
   begin
      return Byte(Unsigned_8(Left) and Unsigned_8(Right));
   end "AND";


   -- Prec: Left and Right are correct bytes
   -- Post: Returns the boolean operation "Left OR Right"
   function "OR" (
         Left,               
         Right : in     Byte ) 
     return Byte is 
   begin
      return Byte(Unsigned_8(Left) or Unsigned_8(Right));
   end "OR";

   -- Prec: Left and Right are correct bytes
   -- Post: Returns the boolean operation "Left XOR Right"
   function "XOR" (
         Left,               
         Right : in     Byte ) 
     return Byte is 
   begin
      return Byte(Unsigned_8(Left) xor Unsigned_8(Right));
   end "XOR";



   -----------------------
   --- File Management ---
   -----------------------

   procedure Create (
         File : in out T_Binary_file;               
         Mode : in     T_Mode  := Inout_File; 
         Name : in     String  := ""          ) is 
   begin
      Direct_Byte.Create(File_Type(File),File_Mode'Val(T_Mode'Pos(Mode)),
         Name);
   end Create;

   procedure Open (
         File : in out T_Binary_file; 
         Mode : in     T_Mode;  
         Name : in     String   ) is 
   begin
      Direct_Byte.Open(File_Type(File),File_Mode'Val(T_Mode'Pos(Mode)),
         Name);
   end Open;

   procedure Close (
         File : in out T_Binary_file ) is 
   begin
      Direct_Byte.Close(File_Type(File));
   end Close;

   procedure Delete (
         File : in out T_Binary_file ) is 
   begin
      Direct_Byte.Delete(File_Type(File));
   end Delete;

   procedure Reset (
         File : in out T_Binary_file; 
         Mode : in     T_Mode   ) is 
   begin
      Direct_Byte.Reset(File_Type(File),File_Mode'Val(T_Mode'Pos(Mode)));
   end Reset;

   procedure Reset (
         File : in out T_Binary_file ) is 
   begin
      Direct_Byte.Reset(File_Type(File));
   end Reset;

   function Mode (
         File : in     T_Binary_file ) 
     return T_Mode is 
   begin
      return T_Mode'Val(File_Mode'Pos(Direct_Byte.Mode(File_Type(File))));
   end Mode;

   function Name (
         File : in     T_Binary_file ) 
     return String is 
   begin
      return Direct_Byte.Name(File_Type(File));
   end Name;

   function Is_Open (
         File : in     T_Binary_file ) 
     return Boolean is 
   begin
      return Direct_Byte.Is_Open(File_Type(File));
   end Is_Open;


   --------------
   -- In / Out --
   --------------

   procedure Read (
         File : in     T_Binary_file; 
         Item :    out Byte;    
         From : in     Positive ) is 
   begin
      Direct_Byte.Read(File_Type(File),Item,Positive_Count(From));
   end Read;

   procedure Read (
         File : in     T_Binary_file; 
         Item :    out Byte     ) is 
   begin
      Direct_Byte.Read(File_Type(File),Item);
   end Read;

   procedure Write (
         File : in     T_Binary_file; 
         Item : in     Byte;    
         To   : in     Positive ) is 
   begin
      Direct_Byte.Write(File_Type(File),Item,Positive_Count(To));
   end Write;

   procedure Write (
         File : in     T_Binary_file; 
         Item : in     Byte     ) is 
   begin
      Direct_Byte.Write(File_Type(File),Item);
   end Write;

   procedure Set_Index (
         File : in     T_Binary_file; 
         To   : in     Positive ) is 
   begin
      Direct_Byte.Set_Index(File_Type(File),Positive_Count(To));
   end Set_Index;

   function Index (
         File : in     T_Binary_file ) 
     return Positive is 
   begin
      return Positive( Direct_Byte.Index(File_Type(File)) );
   end Index;

   function Size (
         File : in     T_Binary_file ) 
     return Natural is 
   begin
      return Natural(Direct_Byte.Size(File_Type(File)) );
   end Size;

   function End_Of_File (
         File : in     T_Binary_file ) 
     return Boolean is 
   begin
      return Direct_Byte.End_Of_File(File_Type(File));
   end End_Of_File;


end D_Byte;