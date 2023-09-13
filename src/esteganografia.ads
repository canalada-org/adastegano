with D_Imagen;
use D_Imagen;

with D_Xtras;
use type D_Xtras.Opcion_Alternativa;

package Esteganografia is



   Longitud_Minima_Clave : Positive := 8;  
   Longitud_Maxima_Clave : Positive := 16;  
   Longitud_Maxima_Ruta  : Positive := 256;  


   -- Métodos soportados de momento
   type T_Metodo is 
         (Cesar,  
          Serpent); 

   type Lista_Archivo is 
         (Img,  
          Wav,  
          Otros); 

   type T_Archivo(T: Lista_Archivo:=Otros) is
   record
      case T is
         when Img=>
            I: Imagen;
         when others=>
            null;
      end case;
   end record;


   -- Prec: "Ruta_origen" es una ruta del sistema válida a un archivo no abierto
   --       "Ruta_destino" es una ruta del sistema válida a un archivo no abierto,
   --       en el cual se puede almacenar la información del archivo de ruta "Ruta_origen" 
   --       (ruta, datos binarios, y tamaño de la ruta y del archivo)
   --       "Ruta_copia" es una ruta del sistema válida para crear un fichero o sobreecribir
   --       uno ya existente
   --       "Metodo" es el método elegido para cifrarlo
   --       "Clave" es un string válido de longitud entre 8 y 16
   -- Post: "Ruta_copia" es una ruta del sistema válida a una imagen no abierta de
   --       copia del archivo cuya ruta es "Ruta_destino", que tiene oculto en su interior
   --       la ruta y datos binarios del archivo "Ruta_origen" cifrado con "Método"; 

   -- En otras palabras, se cifra el archivo origen en el destino con el método indicado y se guarda en copia :P
   procedure Encriptar (
         Ruta_Origen  : String;   
         Ruta_Destino : String;   
         Ruta_Copia   : String;   
         Metodo       : T_Metodo; 
         Clave        : String    ); 


   -- Prec:  "Ruta_origen" es una ruta del sistema válida a un archivo no abierto
   --       el cual contiene un archivo ocultado correctamente con el procedimiento "Encriptar"
   --       "Método" es la forma en que cifró el archivo cuando se ejecutó "Encriptar"
   --       "Clave" es un string válido de longitud entre 8 y 16, el mismo usado 
   --       en el procedimiento "Encriptar" para esconder este fichero.
   --       "Ruta_alternativa" es una ruta del sistema válida para crear un fichero o sobreecribir
   --       uno ya existente; solo se tomará en cuenta si Usar_ruta_alternativa=2 
   -- Post: Si Usar_ruta_alternativa=0,
   --         Se creará un archivo nuevo cuyo contenido esté almacenado en Ruta_origen, 
   --          cuya ruta será la "Ruta_origen" del procedimiento
   --         "Encriptar" que se usó para ocultar el fichero, sobreescribiendo
   --         cualquier fichero existente.
   --       Si Usar_ruta_alternativa=1,
   --         Se creará un archivo nuevo cuyo contenido esté almacenado en Ruta_origen, 
   --         cuya ruta será la "Ruta_origen" del procedimiento
   --         "Encriptar" que se usó para ocultar el fichero; si ya existe un fichero 
   --         con ese nombre se añadirá una extension al final de su ruta entre "0" y "255". Si aún así
   --         existe un fichero con esas rutas, se guardara con la extension "256", sobreescribiendo
   --         el fichero si ya existe
   --       Si Usar_ruta_alternativa=2,
   --         Se creará un archivo nuevo cuyo contenido esté almacenado en Ruta_origen,
   --         cuya ruta será "Ruta_alternativa", sobreescribiendo cualquier archivo existente

   --       Si la contraseña no es válida, el método no es correcto o la imagen no tiene un fichero oculto, 
   --       el resultado es indeterminado  

   procedure Desencriptar (
         Ruta_Origen           : String;                          
         Metodo                : T_Metodo;                        
         Clave                 : String;                          
         Usar_Ruta_Alternativa : D_Xtras.Opcion_Alternativa := 0; 
         Ruta_Alternativa      : String                     := "" ); 



   -- Prec: I es un tipo T_Archivo válido
   -- Post: Devuelve "True" si es posible ocultar datos en el interior de un archivo de tipo I
   --       devuelve "False" en caso contrario
   function Archivo_Valido_Ocultacion (
         I : in     T_Archivo ) 
     return Boolean; 



   -- Prec: Ruta es una ruta válida a un archivo del sistema no abierto
   -- Post: Devuelve el tipo de archivo que es
   function Tipo_Archivo (
         Ruta : in     String ) 
     return T_Archivo; 


   -- Prec: "Ruta" es una ruta del sistema válida a un archivo en el cual
   --       es posible ocultar datos en su interior
   -- Post: Devuelve el número total de bits que se pueden ocultar en el archivo
   function Espacio_Disponible (
         Ruta : String ) 
     return Positive; 


   -- Prec: T es un t_archivo valido
   -- Post: Devuelve un string con la descripcion del archivo
   function Descripcion (
         T : T_Archivo ) 
     return String; 

   -- Excepciones:
   Archivo_Origen_Vacio : exception; -- El archivo origen está vacio (que vamos a ocultar?)       

   Ruta_No_Valida : exception; -- La ruta no es valida (=name_error)           

   Uso_No_Valido : exception; -- Archivo ya abierto o sin permisos (=use_error)  

   Informacion_Interna_Corrupta : exception; -- La cabecera del archivo tiene información no válida            

   Longitud_Incorrecta : exception; -- La clave tiene menos de 8 caracteres o más de 16              

   Arc_No_Valido_Ocultacion : exception; -- El archivo no es válido para ocultar datos en su interior                          

   Imposible_Desencriptar : exception; -- La clave es incorrecta, el metodo es incorrecto o el archivo no tiene oculto nada          

   Espacio_Insuficiente : exception; -- El archivo destino no puede ocultar tanta información;                   
   --------------------------------------busque un archivo destino más grande o un origen más pequeño
end Esteganografia;

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