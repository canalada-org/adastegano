-- Licencia de uso: GNU GPL. Detalles en la parte inferior del archivo


package D_Xtras is

   type Opcion_Alternativa is range 0 .. 2; 

   -- Prec: Ruta es una ruta válida del sistema a un fichero existente y no abierto
   --       Ruta tiene como máximo 255 carácteres 
   -- Post: Devuelve el tamaño total que tenemos que contar si queremos
   --       ocultar este archivo dentro de otro, tomando en cuenta que:
   --       Se cuenta un byte para almacenar el tamaño de la ruta
   --       Se cuentan x bytes para almacenar la ruta del fichero
   --       Se cuenta un byte para almacenar el checksum de la ruta
   --       Se cuentan 4 bytes para almacenar el tamaño del fichero en bytes
   --       Se cuentan y bites para almacenar los datos binarios del fichero
   function Tamaño_Archivo (
         Ruta : String ) 
     return Positive; 

   -- Prec: S es un string de longitud 'l'>=0
   -- Post: Devuelve 'l'
   function Longitud_String (
         S : String ) 
     return Natural; 

   -- Prec: S es un string de longitud 'l' >=0
   -- Post: Si 'l'>0 devuelve un string en minúsculas con el primer caracter
   --       en mayúsculas. Si 'l'=0 devuelve 'X'.
   function Formato (
         X : in     String ) 
     return String; 

   -- Prec: Clave es un string válido de longitud mayor que 0
   -- Post: Devuelve un valor de semilla para la clave proporcionada
   function Semilla (
         Clave : String ) 
     return Integer; 

   -- Prec: Ruta es la ruta de sistema válida a un archivo, existente o no
   --       Las carpetas terminan por / o por \
   -- Post: Devuelve el nombre del archivo 
   --    P.ejemplo, Archivo("/home/pepe/prueba.txt") devuelve "prueba.txt"
   --    P.ejemplo, Archivo("E:\archivo") devuelve "archivo"
   --    Nota: no distingue entre '/' y '\'
   function Archivo (
         Ruta : String ) 
     return String; 

   -- Prec: Ruta es la ruta de sistema válida a un archivo, existente o no
   --       Las carpetas terminan por / o por \
   -- Post: Devuelve la carpeta donde está el archivo
   --    P.ejemplo, ruta_Archivo("/home/pepe/prueba.txt") devuelve "/home/pepe/"
   --    P.ejemplo, ruta_Archivo("etc/archivo") devuelve "etc/"
   --    Nota: no distingue entre '/' y '\'
   function Ruta_Archivo (
         Ruta : String ) 
     return String; 

   -- Prec: Ruta es una ruta válida de sistema
   -- Post: Devuelve TRUE si la ruta corresponde a un archivo existente
   --       y devuelve FALSE si el archivo no existe
   function Comprobar_Ruta (
         Ruta : String ) 
     return Boolean; 

   Longitud_Incorrecta : exception;  


end D_Xtras;


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