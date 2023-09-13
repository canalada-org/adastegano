with D_Imagen,D_Imagen_Bmp24,D_Xtras;
use  D_Imagen,D_Imagen_Bmp24,D_Xtras;

with Ada.Text_Io,Ada.Strings.Unbounded;
use Ada.Text_Io,Ada.Strings.Unbounded;


package body Esteganografia is



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
         Clave        : String    ) is 

      Archivo  : T_Archivo;  
      Esp_Disp : Positive;  
      Esp_Ocup : Positive;  
      F        : File_Type;  
      Aux      : Natural;  
   begin

      -- Comprobando rutas
      Put("Comprobando ruta de origen: ");
      Open(F,In_File,Ruta_Origen);
      Close(F);
      Put_Line("OK");


      Put("Comprobando ruta de destino: ");
      Open(F,In_File,Ruta_Destino);
      Close(F);
      Put_Line("OK");
      -- No comprobamos la ruta copia porque podria tendriamos que hacer un 
      -- create() y borrariamos el archivo anterior!

      -- Comprobamos el tipo de archivo
      Put("Comprobando tipo de archivo: ");
      Archivo:=Tipo_Archivo(Ruta_Destino);
      if not Archivo_Valido_Ocultacion(Archivo) then
         raise Arc_No_Valido_Ocultacion;
      end if;
      Put_Line("OK");

      -- Comprobamos el espacio
      Put("Comprobando tamano de archivos: ");
      Esp_Disp:=Espacio_Disponible(Ruta_Destino);
      Esp_Ocup:=Tamaño_Archivo(Ruta_Origen);

      if Metodo=Serpent then
         Esp_Ocup:=Esp_Ocup+(2*(Esp_Ocup mod 16)); -- para el metodo serpeant escribimos en grupos completos de 16 bytes
      end if;
      if Esp_Ocup*8>Esp_Disp then
         Aux:=Esp_Ocup*8;
         New_Line(2);
         Put_Line("Espacio necesario en bits: " & Aux'Img);
         Put_Line("Espacio disponible en bits: " & Esp_Disp'Img);
         raise Espacio_Insuficiente;
      end if;
      Put_Line("OK");

      -- Comprobamos la longitud de la clave
      Put("Comprobando longitud de clave: ");
      if Longitud_String(Clave)<Longitud_Minima_Clave or  Longitud_String(Clave)>Longitud_Maxima_Clave then
         raise Esteganografia.Longitud_Incorrecta;
      end if;
      Put_Line("OK");
      New_Line(2);

      -- Por ahora solo soportamos bmps de 24bits
      if Archivo.T=Img then
         if Archivo.I.Tipo=Bmp then
            if Archivo.I.Bpp=24 and Archivo.I.Compresion=None then
               if Metodo=Cesar then
                  D_Imagen_Bmp24.Encriptar_Cesar (Ruta_Origen,Ruta_Destino,Ruta_Copia,Clave );
               elsif Metodo=Serpent then
                  D_Imagen_Bmp24.Encriptar_Serpent(Ruta_Origen,Ruta_Destino,Ruta_Copia,Clave );

               end if;

            end if;
         end if;
      end if;


   exception
      when D_Imagen.Informacion_Interna_Corrupta =>
         raise Esteganografia.Informacion_Interna_Corrupta;
      when Name_Error =>
         raise Ruta_No_Valida;
      when D_Imagen_Bmp24.Archivo_Origen_Vacio =>
         raise Esteganografia.Archivo_Origen_Vacio;
      when Use_Error=>
         raise Uso_No_Valido;

   end Encriptar;


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
         Ruta_Alternativa      : String                     := "" ) is 

      Archivo : T_Archivo;  


      procedure Comprobar_Ruta is 
         F : File_Type;  
      begin
         -- Comprobando rutas
         Put("Comprobando ruta de origen: ");
         Open(F,In_File,Ruta_Origen);
         Close(F);
         Put_Line("OK");
      exception
         when Name_Error=>
            raise Ruta_No_Valida;
      end Comprobar_Ruta;

   begin

      Comprobar_Ruta;

      -- Comprobamos el tipo de archivo
      Put("Comprobando tipo de archivo: ");
      Archivo:=Tipo_Archivo(Ruta_Origen);
      if not Archivo_Valido_Ocultacion(Archivo) then
         raise Arc_No_Valido_Ocultacion;
      end if;
      Put_Line("OK");

      -- Comprobamos la longitud de la clave
      Put("Comprobando longitud de clave: ");
      if Longitud_String(Clave)<Longitud_Minima_Clave or  Longitud_String(Clave)>Longitud_Maxima_Clave then
         raise Esteganografia.Longitud_Incorrecta;
      end if;
      Put_Line("OK");
      New_Line(2);

      -- Por ahora solo soportamos bmps de 24bits
      if Archivo.T=Img then
         if Archivo.I.Tipo=Bmp then
            if Archivo.I.Bpp=24 and Archivo.I.Compresion=None then
               if Metodo=Cesar then
                  D_Imagen_Bmp24.Desencriptar_Cesar (Ruta_Origen,Clave,Usar_Ruta_Alternativa,Ruta_Alternativa );
               elsif Metodo=Serpent then
                  D_Imagen_Bmp24.Desencriptar_Serpent (Ruta_Origen,Clave,Usar_Ruta_Alternativa,Ruta_Alternativa );
               end if;

            end if;
         end if;
      end if;

   exception
      when Checksum_Fail=>
         raise Imposible_Desencriptar;
      when Name_Error=>
         raise Imposible_Desencriptar;
      when Constraint_Error=>
         raise Imposible_Desencriptar;
      when Use_Error=>
         raise Uso_No_Valido;
   end Desencriptar;




   ----------------------------------------------------------------------------------------------------------



   -- Prec: I es un tipo T_Archivo válido
   -- Post: Devuelve "True" si es posible ocultar datos en el interior de un archivo de tipo I
   --       devuelve "False" en caso contrario
   function Archivo_Valido_Ocultacion (
         I : in     T_Archivo ) 
     return Boolean is 
   begin
      -- por ahora solo soportamos bmps de 24 bits
      if I.T=Img then
         if I.I.Tipo=Bmp then
            if I.I.Bpp=24 and I.I.Compresion=None then
               return True;
            end if;
         end if;
      end if;
      return False;

   end Archivo_Valido_Ocultacion;



   -- Prec: Ruta es una ruta válida a un archivo del sistema no abierto
   -- Post: Devuelve el tipo de archivo que es
   function Tipo_Archivo (
         Ruta : in     String ) 
     return T_Archivo is 
      V_Img : Imagen;  
   begin
      -- por ahora solo soportamos bmps
      V_Img:= Tipo_Imagen(Ruta);
      return (
         T => Img,  
         I => V_Img);
   end Tipo_Archivo;


   -- Prec: "Ruta" es una ruta del sistema válida a un archivo en el cual
   --       es posible ocultar datos en su interior
   -- Post: Devuelve el número total de bits que se pueden ocultar en el archivo
   function Espacio_Disponible (
         Ruta : String ) 
     return Positive is 
      Tipo : T_Archivo := Tipo_Archivo (Ruta);  
   begin
      -- por ahora solo soportamos bmps de 24 bits
      if Tipo.T=Img then
         if Tipo.I.Tipo=Bmp then
            if Tipo.I.Bpp=24 and Tipo.I.Compresion=None then
               return Espacio_Disponible_Bmp24(Ruta);
            end if;
         end if;
      end if;
      raise Arc_No_Valido_Ocultacion;
   end Espacio_Disponible;



   -- Prec: T es un t_archivo valido
   -- Post: Devuelve un string con la descripcion del archivo
   function Descripcion (
         T : T_Archivo ) 
     return String is 
      Desc : Unbounded_String := Null_Unbounded_String;  
   begin
      if T.T=Img then
         Desc:=Desc & To_Unbounded_String(T_Imagen'Image(T.I.Tipo)) & To_Unbounded_String(" ");

         case T.I.Tipo is
            when Bmp=>
               Desc:=Desc & To_Unbounded_String(Rango_Bpp'Image(T.I.Bpp)) & To_Unbounded_String("Bpp Compresion: ")
                  & To_Unbounded_String(Bm_Compression'Image(T.I.Compresion))& To_Unbounded_String(" ")
                  & To_Unbounded_String(Positive'Image(T.I.Ancho))& To_Unbounded_String("x")
                  & To_Unbounded_String(Positive'Image(T.I.Altura)) ;
            when Gif=>
               Desc:=Desc & To_Unbounded_String(T_Gif'Image(T.I.Tipo_Gif));
            when others=>
               null;
         end case;
      else
         Desc:=Desc & To_Unbounded_String(Lista_Archivo'Image(T.T));
      end if;
      return To_String(Desc);
   end Descripcion;


end Esteganografia;