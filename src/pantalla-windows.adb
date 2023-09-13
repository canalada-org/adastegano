
pragma C_Pass_By_Copy (128);

with Ada.Text_Io;
use Ada.Text_Io;
with Interfaces;
use Interfaces;


package body Pantalla is


   pragma Linker_Options ("-luser32");

   -- Funciona como get_immediate pero sin eco, es decir no muestra el caracter 
   procedure Coger_Caracter (
         C :    out Character ) is 
   begin
      Get_Immediate(C);
   end Coger_Caracter;



   function Intro return Character is 
   begin
      return Ascii.Cr;
   end Intro;

   function Back return Character is 
   begin
      return Ascii.Bs;
   end Back;

   function Esc return Character is 
   begin
      return Ascii.Esc;
   end Esc;

   procedure Borrar_Caracter is 
   begin
      Put(Ascii.Bs & ' ' & Ascii.Bs);
   end Borrar_Caracter;


   -----------------------------------------------------------------------------------


   ---------------------
   -- WIN32 INTERFACE --
   ---------------------

   Beep_Error            : exception;  
   Fill_Char_Error       : exception;  
   Cursor_Get_Error      : exception;  
   Cursor_Set_Error      : exception;  
   Cursor_Pos_Error      : exception;  
   Buffer_Info_Error     : exception;  
   Set_Attribute_Error   : exception;  
   Invalid_Handle_Error  : exception;  
   Fill_Attribute_Error  : exception;  
   Cursor_Position_Error : exception;  

   subtype Dword  is  Unsigned_32;
   subtype Handle is  Unsigned_32;
   subtype Short  is  Short_Integer;
   subtype Winbool is Integer;

   type Lpdword is access all Dword; 
   pragma Convention (C, Lpdword);

   type Nibble is mod 2**4; 
   for Nibble'Size use 4;

   type Attribute is 
      record 
         Foreground : Nibble;  
         Background : Nibble;  
         Reserved   : Unsigned_8 := 0;  
      end record; 

   for Attribute use
      record
      Foreground at 0 range 0 .. 3;
      Background at 0 range 4 .. 7;
      Reserved   at 1 range 0 .. 7;
   end record;

   for Attribute'Size use 16;
   pragma Convention (C, Attribute);

   type Coord is 
      record 
         X : Short;  
         Y : Short;  
      end record; 
   pragma Convention (C, Coord);

   type Small_Rect is 
      record 
         Left   : Short;  
         Top    : Short;  
         Right  : Short;  
         Bottom : Short;  
      end record; 
   pragma Convention (C, Small_Rect);

   type Console_Screen_Buffer_Info is 
      record 
         Size       : Coord;  
         Cursor_Pos : Coord;  
         Attrib     : Attribute;  
         Window     : Small_Rect;  
         Max_Size   : Coord;  
      end record; 
   pragma Convention (C, Console_Screen_Buffer_Info);

   type Pconsole_Screen_Buffer_Info is access all Console_Screen_Buffer_Info; 
   pragma Convention (C, Pconsole_Screen_Buffer_Info);

   type Console_Cursor_Info is 
      record 
         Size    : Dword;  
         Visible : Winbool;  
      end record; 
   pragma Convention (C, Console_Cursor_Info);

   type Pconsole_Cursor_Info is access all Console_Cursor_Info; 
   pragma Convention (C, Pconsole_Cursor_Info);

   function Getch return Integer; 
   pragma Import (C, Getch, "_getch");

   function Kbhit return Integer; 
   pragma Import (C, Kbhit, "_kbhit");

   function Messagebeep (
         Kind : Dword ) 
     return Dword; 
   pragma Import (Stdcall, Messagebeep, "MessageBeep");

   function Getstdhandle (
         Value : Dword ) 
     return Handle; 
   pragma Import (Stdcall, Getstdhandle, "GetStdHandle");

   function Getconsolecursorinfo (
         Buffer : Handle;              
         Cursor : Pconsole_Cursor_Info ) 
     return Winbool; 
   pragma Import (Stdcall, Getconsolecursorinfo, "GetConsoleCursorInfo");

   function Setconsolecursorinfo (
         Buffer : Handle;              
         Cursor : Pconsole_Cursor_Info ) 
     return Winbool; 
   pragma Import (Stdcall, Setconsolecursorinfo, "SetConsoleCursorInfo");

   function Setconsolecursorposition (
         Buffer : Handle; 
         Pos    : Coord   ) 
     return Dword; 
   pragma Import (Stdcall, Setconsolecursorposition, "SetConsoleCursorPosition");

   function Setconsoletextattribute (
         Buffer : Handle;   
         Attr   : Attribute ) 
     return Dword; 
   pragma Import (Stdcall, Setconsoletextattribute, "SetConsoleTextAttribute");

   function Getconsolescreenbufferinfo (
         Buffer : Handle;                     
         Info   : Pconsole_Screen_Buffer_Info ) 
     return Dword; 
   pragma Import (Stdcall, Getconsolescreenbufferinfo, "GetConsoleScreenBufferInfo");

   function Fillconsoleoutputcharacter (
         Console : Handle;    
         Char    : Character; 
         Length  : Dword;     
         Start   : Coord;     
         Written : Lpdword    ) 
     return Dword; 
   pragma Import (Stdcall, Fillconsoleoutputcharacter, "FillConsoleOutputCharacterA");

   function Fillconsoleoutputattribute (
         Console : Handle;    
         Attr    : Attribute; 
         Length  : Dword;     
         Start   : Coord;     
         Written : Lpdword    ) 
     return Dword; 
   pragma Import (Stdcall, Fillconsoleoutputattribute, "FillConsoleOutputAttribute");

   Win32_Error          : constant Dword  := 0;  
   Invalid_Handle_Value : constant Handle := - 1;  
   Std_Output_Handle    : constant Dword  := - 11;  

   type Color_Type is 
         (Black,         
          Blue,          
          Green,         
          Cyan,          
          Red,           
          Magenta,       
          Brown,         
          Gray,          
          Light_Blue,    
          Light_Green,   
          Light_Cyan,    
          Light_Red,     
          Light_Magenta, 
          Yellow,        
          White); 

   Color_Value : constant
   array (Color_Type) of Nibble := (0, 1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15);
   Color_Type_Value : constant
   array (Nibble) of Color_Type :=
      (Black, Blue, Green, Cyan, Red, Magenta, Brown, Gray,
      Black, Light_Blue, Light_Green, Light_Cyan, Light_Red,
      Light_Magenta, Yellow, White);

   -----------------------
   -- PACKAGE VARIABLES --
   -----------------------

   Output_Buffer    : Handle;  
   Num_Bytes        : aliased Dword;  
   Num_Bytes_Access : Lpdword                            := Num_Bytes'access;  
   Buffer_Info_Rec  : aliased Console_Screen_Buffer_Info;  
   Buffer_Info      : Pconsole_Screen_Buffer_Info        := Buffer_Info_Rec'access;  

   -------------------------
   -- SUPPORTING SERVICES --
   -------------------------
   procedure Get_Buffer_Info is 
   begin
      if Getconsolescreenbufferinfo (Output_Buffer, Buffer_Info) = Win32_Error then
         raise Buffer_Info_Error;
      end if;
   end Get_Buffer_Info;

   -------------------------------------------------------------------------

   -- Codigo de NT_Console 
   -- Ver licencia de NT_Console abajo del todo
   procedure Limpiar_Pantalla is 

      ----
      Length : Dword;  
      Attr   : Attribute;  
      Home   : Coord     := (0, 0);  

   begin
      Get_Buffer_Info;
      Length := Dword (Buffer_Info_Rec.Size.X) * Dword (Buffer_Info_Rec.Size.Y);
      Attr.Background := Color_Value (Black);
      Attr.Foreground := Buffer_Info_Rec.Attrib.Foreground;
      if Setconsoletextattribute (Output_Buffer, Attr) = Win32_Error then
         raise Set_Attribute_Error;
      end if;
      if Fillconsoleoutputattribute (Output_Buffer, Attr, Length, Home, Num_Bytes_Access) = Win32_Error then
         raise Fill_Attribute_Error;
      end if;
      if Fillconsoleoutputcharacter (Output_Buffer, ' ', Length, Home, Num_Bytes_Access) = Win32_Error then
         raise Fill_Char_Error;
      end if;
      if Setconsolecursorposition (Output_Buffer, Home) = Win32_Error then
         raise Cursor_Position_Error;
      end if;
   exception
      when others=>
         raise Error_Limpiando_Pantalla;
   end Limpiar_Pantalla;


   ----
   subtype X_Pos is Natural range 0 .. 79;
   --subtype Y_Pos is Natural range 0 .. 24;

   function Where_X return X_Pos is 
   begin
      Get_Buffer_Info;
      return X_Pos (Buffer_Info_Rec.Cursor_Pos.X);
   end Where_X;

   ----

   procedure Borra_Linea is 
      X : X_Pos := Where_X;   
   begin
      for C in reverse X_Pos'First..X loop
         Put(Ascii.Bs & ' ' & Ascii.Bs);
      end loop;
   end Borra_Linea;

begin

   --------------------------
   -- WIN32 INITIALIZATION --
   --------------------------

   Output_Buffer := Getstdhandle (Std_Output_Handle);
   if Output_Buffer = Invalid_Handle_Value then
      raise Invalid_Handle_Error;
   end if;

end Pantalla;
-- Licencia de NT_Console (hemos usado su código para limpiar la pantalla)
-----------------------------------------------------------------------
--
--  File:        nt_console.ads
--  Description: Win95/NT console support
--  Rev:         0.2
--  Date:        08-june-1999
--  Author:      Jerry van Dijk
--  Mail:        jdijk@acm.org
--
--  Copyright (c) Jerry van Dijk, 1997, 1998, 1999
--  Billie Holidaystraat 28
--  2324 LK  LEIDEN
--  THE NETHERLANDS
--  tel int + 31 71 531 43 65
--
--  Permission granted to use for any purpose, provided this copyright
--  remains attached and unmodified.
--
--  THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
--  IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
--  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
--
-----------------------------------------------------------------------      