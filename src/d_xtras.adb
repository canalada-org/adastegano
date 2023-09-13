with D_Byte;
use D_Byte;
with Ada.Characters.Handling,Ada.Strings.Unbounded;
use Ada.Characters.Handling,Ada.Strings.Unbounded;

package body D_Xtras is



   -- Prec: S es un string de longitud 'l'>=0
   -- Post: Devuelve 'l'
   function Longitud_String (
         S : String ) 
     return Natural is 
   begin
      return Length(To_Unbounded_String(S));
   end Longitud_String;

   -- Prec: S es un string de longitud 'l' >=0
   -- Post: Si 'l'>0 devuelve un string en minúsculas con el primer caracter
   --       en mayúsculas. Si 'l'=0 devuelve 'X'.
   function Formato (
         X : in     String ) 
     return String is 
      Y : Unbounded_String;  
   begin
      if Longitud_String(X)>0 then
         Y:=To_Unbounded_String(To_Lower(X));
         Replace_Element(Y,1,To_Upper(Element(Y,1)));
         return To_String(Y);
      else
         return X;
      end if;
   end Formato;

   -- Prec: Ruta es una ruta válida del sistema a un fichero existente no abierto
   --       Ruta tiene como máximo 255 carácteres 
   -- Post: Devuelve el tamaño total que tenemos que contar si queremos
   --       ocultar este archivo dentro de otro, tomando en cuenta que:
   --       Se cuenta un byte para almacenar el tamaño de la ruta
   --       Se cuentan x bytes para almacenar la ruta del fichero
   --       Se cuentan 4 bytes para almacenar el tamaño del fichero en bytes
   --       Se cuentan y bites para almacenar los datos binarios del fichero
   function Tamaño_Archivo (
         Ruta : String ) 
     return Positive is 
      Tamaño : Positive      := 6;  
      F      : T_Binary_File;  
   begin
      Tamaño:=Tamaño+Longitud_String(Ruta);
      Open(F,In_File,Ruta);
      Tamaño:=Tamaño+Size(F);
      Close(F);
      return Tamaño;
   end Tamaño_Archivo;


   -- Prec: Clave es un string válido de longitud mayor que 0
   -- Post: Devuelve un valor de semilla para la clave proporcionada
   function Semilla (
         Clave : String ) 
     return Integer is 
      Longitud,  
      Temp1,  
      Temp2    : Integer := 1;  
   begin
      Longitud:=Longitud_String(Clave);
      if Longitud<1 then
         raise   Longitud_Incorrecta;
      end if;

      for I in 1..Longitud loop
         Temp1:=(Character'Pos(Clave(I))-100);
         if Temp2>13854000 or Temp2<-13854000 then
            Temp2:=(Temp2 mod (Character'Pos(Clave(I))*128))+1;
         end if;
         if Temp2*Temp1/=0 then
            Temp2:=Temp2*Temp1;
         else
            Temp2:=Temp2*100;
         end if;
      end loop;
      return Temp2;
   end Semilla;



   -- Prec: Ruta es la ruta de sistema válida a un archivo, existente o no. 
   -- Post: Devuelve el nombre del archivo 
   --    P.ejemplo, Archivo("/home/pepe/prueba.txt") devuelve "prueba.txt"
   --    P.ejemplo, Archivo("E:\archivo") devuelve "archivo"
   --    Nota: no distingue entre '/' y '\'
   function Archivo (
         Ruta : String ) 
     return String is 
      Longitud,  
      Indice   : Natural := 0;  
   begin
      Longitud:=Longitud_String(Ruta);
      if Longitud=0 then
         return "";
      end if;

      for I in 1..Longitud loop
         if Ruta(I)='/' or Ruta(I)='\' then
            Indice:=I;
         end if;
      end loop;
      if Indice=Longitud then
         return "";
      elsif Indice=1 then
         return Ruta(Indice..Longitud);
      else
         return Ruta(Indice+1..Longitud);
      end if;
   end Archivo;

   -- Prec: Ruta es la ruta de sistema válida a un archivo, existente o no
   --       Las carpetas terminan por / o por \
   -- Post: Devuelve la carpeta donde está el archivo
   --    P.ejemplo, ruta_Archivo("/home/pepe/prueba.txt") devuelve "/home/pepe/"
   --    P.ejemplo, ruta_Archivo("etc/archivo") devuelve "etc/"
   --    Nota: no distingue entre '/' y '\'
   function Ruta_Archivo (
         Ruta : String ) 
     return String is 
      Longitud,  
      Indice   : Natural := 0;  
   begin
      Longitud:=Longitud_String(Ruta);
      if Longitud=0 then
         return "";
      end if;
      for I in 1..Longitud loop
         if Ruta(I)='/' or Ruta(I)='\' then
            Indice:=I;
         end if;
      end loop;
      if Indice=1 then
         return "";
      else
         return Ruta(1..Indice);
      end if;


   end Ruta_Archivo;



   -- Prec: Ruta es una ruta válida de sistema
   -- Post: Devuelve TRUE si la ruta corresponde a un archivo existente
   --       y devuelve FALSE si el archivo no existe
   function Comprobar_Ruta (
         Ruta : String ) 
     return Boolean is 
      F : T_Binary_File;  
   begin
      Open(F,In_File,Ruta);
      Close(F);
      return True;
   exception
      when others=>
         return False;
   end Comprobar_Ruta;


end D_Xtras;