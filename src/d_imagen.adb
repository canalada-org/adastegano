with D_Byte;
use D_Byte;

package body D_Imagen is



   -- Prec: "Ruta" es una ruta del sistema válida a un fichero
   -- Post: Devuelve el tipo de imagen que es con su información
   function Tipo_Imagen(
         Ruta : String ) 
     return Imagen is 
      F        : T_Binary_File;  
      Cabecera : String (1 .. 5);  
      B        : Byte;  
      Bpp      : Rango_Bpp;  
      W,  
      H        : Integer;  
   begin
      Open(F,In_File,Ruta);
      if Size(F)<5 then -- si el archivo no tiene un cierto tamaño minimo, no puede ser una imagen
         Close(F);
         return (Tipo => Desconocido);
      end if;
      for I in 1..5 loop
         Read(F,B);
         Cabecera(I):=To_Character(B);
      end loop;
      -- Miramos si es un Bitmap
      if Cabecera(1..2)="BA" or Cabecera(1..2)="BM" then
         if Size(F)<36 then -- Un bitmap debe tener al menos 36 bytes antes de la información de imagen
            Close(F);
            return (Tipo => Desconocido);
         end if;

         -- Miramos la profundida en bits por pixel
         Read(F,B,29);
         if To_Integer(B)<33 and To_Integer(B)>0 then
            Bpp:=Rango_Bpp(To_Integer(B));
         else
            Close(F);
            return (Tipo => Desconocido);
         end if;

         -- Miramos la altura y anchura de la imagen en pixeles
         Read(F,B,19);
         W:=To_Integer(B);
         Read(F,B,20);
         W:=W+256*To_Integer(B);
         Read(F,B,21);
         W:=W+65536*To_Integer(B);-- Solo leemos los primeros 24 bits, no tomamos en cuenta los 8 restantes porque es 
         Read(F,B,23); -- poco probable que usemos una imagen BMP de + de 16 millones de pixeles de ancho o alto :P
         H:=To_Integer(B);
         Read(F,B,24);
         H:=H+256*To_Integer(B);
         Read(F,B,25);
         H:=H+65536*To_Integer(B);

         -- Miramos el tipo de compresion
         Read(F,B,31);
         Close(F);
         case To_Integer(B) is
            when 0=>
               return (
                  Tipo       => BMP,       
                  Bpp        => Bpp,          
                  Compresion => None,         
                  Altura     => Positive (H), 
                  Ancho      => Positive (W));
            when 1=>
               return (
                  Tipo       => BMP,       
                  Bpp        => Bpp,          
                  Compresion => Rle8,         
                  Altura     => Positive (H), 
                  Ancho      => Positive (W));
            when 2=>
               return (
                  Tipo       => BMP,       
                  Bpp        => Bpp,          
                  Compresion => Rle4,         
                  Altura     => Positive (H), 
                  Ancho      => Positive (W));
            when 3=>
               return (
                  Tipo       => BMP,       
                  Bpp        => Bpp,          
                  Compresion => Bitfields,    
                  Altura     => Positive (H), 
                  Ancho      => Positive (W));
            when others=>
               return (Tipo => Desconocido);
         end case;

         -- Miramos si es un PNG
      elsif Cabecera(2..4)="PNG" then
         Close(F);
         return (Tipo => Png);

         -- Miramos si es un GIF
      elsif Cabecera(1..4)="GIF8" then
         Close(F);
         if Cabecera(5)='7' then
            return (
               Tipo     => Gif,  
               Tipo_Gif => Gif87);
         elsif Cabecera(5)='9' then
            return (
               Tipo     => Gif,  
               Tipo_Gif => Gif89);
         else
            return (Tipo => Desconocido);

         end if;
      end if;
      -- Miramos si es un jpg
      -- Leemos los siguientes bytes. Los bytes 6,7,8 y 9 nos dirán si es jpg o no 
      if Size(F)<10 then
         Close(F);
         return (Tipo => Desconocido);
      end if;

      for I in 1..5 loop
         Read(F,B);
         Cabecera(I):=To_Character(B);
      end loop;
      Close(F);
      if Cabecera(2..5)="JFIF" then
         return (Tipo => Jpg);
      else
         return (Tipo => Desconocido);
      end if;

   end Tipo_Imagen;



end D_Imagen;