-- Licencia de uso: GNU GPL. Detalles en la parte inferior del archivo
with d_xtras;

package D_Imagen_Bmp24 is



   -- Prec: "Ruta" es una ruta del sistema válida a una imagen no abierta de 
   --       tipo Bitmap de 24 bits por pixel de al menos un pixel 
   -- Post: Devuelve el número total de bits que se pueden ocultar en la imagen
   --       En caso de que la cabecera de la imagen tenga información incorrecta 
   --       se lanza la excepción "Informacion_interna_corrupta"
   function Espacio_Disponible_Bmp24 (
         Ruta : String ) 
     return Positive; 



   -- Prec: "Ruta_origen" es una ruta del sistema válida a un archivo no abierto
   --       "Ruta_destino" es una ruta del sistema válida a una imagen no abierta de 
   --       tipo Bitmap de 24 bits por pixel de al menos un pixel, con espacio suficiente
   --       para almacenar la información del archivo de ruta "Ruta_origen" 
   --       (ruta, datos binarios, y tamaño de la ruta y del archivo)
   --       "Ruta_copia" es una ruta del sistema válida para crear un fichero o sobreecribir
   --       uno ya existente
   --       "Clave" es un string válido de longitud entre 8 y 16
   -- Post: "Ruta_copia" es una ruta del sistema válida a una imagen no abierta de
   --       tipo Bitmap de 24 bits por pixel de al menos un pixel, copia del archivo cuya ruta
   --       es "Ruta_destino", que tiene oculto en el bit menos significativo de cada byte de 
   --       color de sus píxeles la ruta y datos binarios del archivo "Ruta_origen"; 

   -- En otras palabras, se cifra el archivo origen en el destino y se guarda en copia :P
   procedure Encriptar_Cesar (
         Ruta_Origen  : String; 
         Ruta_Destino : String; 
         Ruta_Copia   : String; 
         Clave        : String  ); 
   -- Detalles del cifrado:
   -- * Los datos están desordenados: el orden de las posiciones de los bits cifrados ha sido
   --   generado mediante un generador pseudo aleatorio con una semilla obtenida a partir de la clave
   -- * Siendo 'l' la longitud de la clave, se han agrupado los bytes del archivo de origen en grupos de 
   --   l bytes, y se ha realizado un XOR byte a byte con la clave
   -- * Se le ha aplicado a cada byte un desplazamiento módulo 256 (método Cesar) según los bytes de la clave



   -- Prec:  "Ruta_origen" es una ruta del sistema válida a una imagen no abierta de 
   --       tipo Bitmap de 24 bits por pixel, el cual contiene un archivo
   --       ocultado correctamente con el procedimiento "Encriptar_cesar"
   --       "Clave" es un string válido de longitud entre 8 y 16, el mismo usado 
   --       en el procedimiento "Encriptar_cesar" para esconder este fichero.
   --       "Ruta_alternativa" es una ruta del sistema válida para crear un fichero o sobreecribir
   --       uno ya existente; solo se tomará en cuenta si Usar_ruta_alternativa=2
   -- Post:    -- Post: Si Usar_ruta_alternativa=0,
   --         Se creará un archivo nuevo cuyo contenido esté almacenado en Ruta_origen, 
   --          cuya ruta será la "Ruta_origen" del procedimiento
   --         "Encriptar_Cesar" que se usó para ocultar el fichero, sobreescribiendo
   --         cualquier fichero existente.
   --       Si Usar_ruta_alternativa=1,
   --         Se creará un archivo nuevo cuyo contenido esté almacenado en Ruta_origen, 
   --         cuya ruta será la "Ruta_origen" del procedimiento
   --         "Encriptar_Cesar" que se usó para ocultar el fichero; si ya existe un fichero 
   --         con ese nombre se añadirá una extension al final de su ruta entre 0 y 255. Si aún así
   --         existe un fichero con esa ruta, se guardara con la extension "256", sobreescribiendo
   --         el fichero si ya existe
   --       Si Usar_ruta_alternativa=2,
   --         Se creará un archivo nuevo cuyo contenido esté almacenado en Ruta_origen,
   --         cuya ruta será "Ruta_alternativa", sobreescribiendo cualquier archivo existente
   --
   --       Si la contraseña no es válida o la imagen no tiene un fichero oculto, 
   --       el resultado es indeterminado  
   procedure Desencriptar_Cesar (
         Ruta_Origen           : String;                  
         Clave                 : String;                  
         Usar_Ruta_Alternativa : D_Xtras.Opcion_Alternativa := 0; 
         Ruta_Alternativa      : String             := "" ); 




   -- Prec: "Ruta_origen" es una ruta del sistema válida a un archivo no abierto
   --       "Ruta_destino" es una ruta del sistema válida a una imagen no abierta de 
   --       tipo Bitmap de 24 bits por pixel de al menos un pixel, con espacio suficiente
   --       para almacenar la información del archivo de ruta "Ruta_origen" 
   --       (ruta, datos binarios, y tamaño de la ruta y del archivo)
   --       "Ruta_copia" es una ruta del sistema válida para crear un fichero o sobreecribir
   --       uno ya existente
   --       "Clave" es un string válido de longitud entre 8 y 16
   -- Post: "Ruta_copia" es una ruta del sistema válida a una imagen no abierta de
   --       tipo Bitmap de 24 bits por pixel de al menos un pixel, copia del archivo cuya ruta
   --       es "Ruta_destino", que tiene oculto en los bits menos significativo de cada byte de 
   --       color de sus píxeles la ruta y datos binarios del archivo "Ruta_origen"; 

   -- En otras palabras, se cifra el archivo origen en el destino y se guarda en copia :P
   procedure Encriptar_Serpent (
         Ruta_Origen  : String; 
         Ruta_Destino : String; 
         Ruta_Copia   : String; 
         Clave        : String  ); 
   -- Detalles del cifrado:
   -- * Los datos están desordenados: el orden de las posiciones de los bits cifrados ha sido
   --   generado mediante un generador pseudo aleatorio con una semilla obtenida a partir de la clave
   -- * Se le ha aplicado a cada grupo de 16 bytes un cifrado Serpent




   -- Prec:  "Ruta_origen" es una ruta del sistema válida a una imagen no abierta de 
   --       tipo Bitmap de 24 bits por pixel, el cual contiene un archivo
   --       ocultado correctamente con el procedimiento "Encriptar_Serpent"
   --       "Clave" es un string válido de longitud entre 8 y 16, el mismo usado 
   --       en el procedimiento "Encriptar_Serpent" para esconder este fichero.
   --       "Ruta_alternativa" es una ruta del sistema válida para crear un fichero o sobreecribir
   --       uno ya existente; solo se tomará en cuenta si Usar_ruta_alternativa=2
   -- Post: Si Usar_ruta_alternativa=0,
   --         Se creará un archivo nuevo cuyo contenido esté almacenado en Ruta_origen, 
   --          cuya ruta será la "Ruta_origen" del procedimiento
   --         "Encriptar_Serpent" que se usó para ocultar el fichero, sobreescribiendo
   --         cualquier fichero existente.
   --       Si Usar_ruta_alternativa=1,
   --         Se creará un archivo nuevo cuyo contenido esté almacenado en Ruta_origen, 
   --         cuya ruta será la "Ruta_origen" del procedimiento
   --         "Encriptar_Serpent" que se usó para ocultar el fichero; si ya existe un fichero 
   --         con ese nombre se añadirá una extension al final de su ruta entre 0 y 255. Si aún así
   --         existe un fichero con esa ruta, se guardara con la extension "256", sobreescribiendo
   --         el fichero si ya existe
   --       Si Usar_ruta_alternativa=2,
   --         Se creará un archivo nuevo cuyo contenido esté almacenado en Ruta_origen,
   --         cuya ruta será "Ruta_alternativa", sobreescribiendo cualquier archivo existente
   --
   --       Si la contraseña no es válida o la imagen no tiene un fichero oculto, 
   --       el resultado es indeterminado   
   procedure Desencriptar_Serpent (
         Ruta_Origen           : String;                  
         Clave                 : String;                  
         Usar_Ruta_Alternativa : D_Xtras.Opcion_Alternativa := 0; 
         Ruta_Alternativa      : String             := "" ); 

   Archivo_Origen_Vacio : exception;  
   Checksum_Fail        : exception;  


end D_Imagen_Bmp24;

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