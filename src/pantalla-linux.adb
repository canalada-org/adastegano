

with Ada.Text_Io;
use Ada.Text_Io;



package body Pantalla is


   procedure Coger_Caracter (
         C :    out Character ) is 
   begin
      Get_Immediate(C);
   end Coger_Caracter;



   function Intro return Character is 
   begin
      return Ascii.Lf;
   end Intro;

   function Back return Character is 
   begin
      return ascii.del;
   end Back;

   function Esc return Character is 
   begin
      return Ascii.Esc;
   end Esc;

   procedure Borrar_Caracter is 
   begin
      Put(Ascii.Bs & ' ' & Ascii.Bs);
   end Borrar_Caracter;



   procedure Limpiar_Pantalla is 
   begin
     Put( ASCII.Esc & "[2J" );
   end Limpiar_Pantalla;

   procedure Borra_Linea is 
   begin
       Put (ASCII.Esc & "[24;0H");
       Put (ASCII.Esc & "[J");
   end borra_linea;



end Pantalla;
