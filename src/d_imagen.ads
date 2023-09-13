-- Licencia de uso: GNU GPL. Detalles en la parte inferior del archivo

package D_Imagen is


   -- Lista de imagenes
   type T_Imagen is 
         (BMP, 
          Jpg,   
          Gif,    
          Png,    
          --  Tiff,       
          --  Raw,        
          Desconocido); 
   for T_Imagen'Size use 4;

   -- Compresión del bitmap
   type Bm_Compression is 
         (None,     
          Rle4,     
          Rle8,     
          Bitfields); 
   for Bm_Compression'Size use 2;

   -- Tipo de gif
   type T_Gif is 
         (Gif87, 
          Gif89); 
   for T_Gif'Size use 1;

   type Rango_Bpp is new Positive range 1 .. 32; 
   for Rango_Bpp'Size use 5;


   -----------------------------------------

   type Imagen (Tipo: T_Imagen:=Desconocido) is
   record
      case Tipo is
      when BMP=>
            Compresion: Bm_Compression;
            Bpp: Rango_Bpp; -- Bits por pixel
            Altura,Ancho: Positive;
         when Gif=>
            Tipo_Gif: T_Gif;
         when others=>
            null;
      end case;
   end record;
   for Imagen'Size use 128;

   -----------------------------------------
   -----------------------------------------
   -----------------------------------------


   -- Prec: "Ruta" es una ruta del sistema válida a un fichero
   -- Post: Devuelve el tipo de imagen que es según la información 
   --        proporcionada por la cabecera (no comprueba si esta información es correcta)
   function Tipo_Imagen(
         Ruta : String ) 
     return Imagen; 


   -- "Informacion_interna_corrupta" se usará cuando la información
   -- interna de la imagen sea incorrecta/imposible, por ejemplo
   -- cuando la cabecera de un bitmap indique que hay más píxeles de los que
   -- en realidad hay)
   Informacion_interna_corrupta : exception;  


end D_Imagen;

--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   It is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html     