with D_Imagen,D_Byte, D_Xtras, D_Orden_Secuencia;
use D_Imagen, D_Byte, D_Xtras;

with Ada.Direct_Io,Ada.Text_Io,Ada.Real_Time,Unchecked_Deallocation;
use Ada.Text_Io,Ada.Real_Time;

with Passwords;
use type Passwords.String16;
use type Passwords.String32;

package body D_Imagen_Bmp24 is

   -- Prec: "Ruta" es una ruta del sistema válida a una imagen Bitmap de 24 bits por pixel de al menos un pixel
   -- Post: Devuelve el número total de bits que se pueden ocultar en la imagen
   function Espacio_Disponible_Bmp24 (
         Ruta : String ) 
     return Positive is 
      F               : T_Binary_File;  
      B               : Byte;  
      Altura_Pixeles,  
      Anchura_Pixeles,  
      Tamaño_Total,  
      Temp            : Integer       := 0;  
   begin
      Open(F,In_File,Ruta);
      -- Miramos que el tamaño del archivo según la cabecera coincida con el real
      for I in 3..6 loop
         Read(F,B,I);
         Tamaño_Total:=Tamaño_Total+To_Integer(B)*(256**(I-3));
      end loop;
      if Integer(Size(F))/=Tamaño_Total then
         Close(F);
         raise  Informacion_Interna_Corrupta;
      end if;

      -- Comprobamos que la resolución sea correcta
      for I in 19..22 loop
         Read(F,B,I);
         Anchura_Pixeles:=Anchura_Pixeles+To_Integer(B)*(256**(I-19));
      end loop;
      for I in 23..26 loop
         Read(F,B,I);
         Altura_Pixeles:=Altura_Pixeles+To_Integer(B)*(256**(I-23));
      end loop;
      -- Miramos donde empieza la información del bitmap, almacenandola en temp
      for I in 11..13 loop
         Read(F,B,I);
         Temp:=Temp+To_Integer(B)*(256**(I-11));
      end loop;
      Temp:=Integer(Size(F))-Temp;
      if Temp<Anchura_Pixeles*Altura_Pixeles*3 then
         Close(F);
         raise  Informacion_Interna_Corrupta;
      end if;
      Close(F);
      return Anchura_Pixeles*Altura_Pixeles*3;
   end Espacio_Disponible_Bmp24;







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
         Clave        : String  ) is 
      -- Detalles del cifrado:
      -- * Los datos están desordenados: el orden de las posiciones de los bits cifrados ha sido
      --   generado mediante un generador pseudo aleatorio con una semilla obtenida a partir de la clave
      -- * Siendo 'l' la longitud de la clave, se han agrupado los bytes del archivo de origen en grupos de 
      --   l bytes, y se ha realizado un XOR byte a byte con la clave
      -- * Se le ha aplicado a cada byte un desplazamiento módulo 256 (método Cesar) según los bytes de la clave

      Tiempo            : Duration      := 0.0; -- Estadísticas                                                                                                                                     
      F                 : T_Binary_File;  
      Tamaño_Bytes_Orig,  
      Tamaño_Bytes_Dest : Positive;  

      procedure Codificar (
            Tam_Bytes_Orig,            
            Tam_Bytes_Dest,            
            Tam_Disp       : Positive; 
            Long           : Positive  ) is 
         package Aleatorio is new D_Orden_Secuencia(Tam_Disp);
         use Aleatorio;

         -- Cargamos los archivos en memoria principal
         -- Así no leemos los archivos directamente y conseguimos
         -- acelerar el recorrido de éstos 10 veces más
         -- Tiempo para encriptar un archivo de 200kb en una imagen de 1024x768
         -- en un AMD 2100, 1GB RAM: 38 segundos sin buffer
         -- Tiempo para encriptar un archivo de 200kb en una imagen de 1024x768
         -- en un AMD 2100, 1GB RAM: 4 segundos con buffer


         type Buffer_Dest is array (1 .. Tam_Bytes_Dest) of Byte; 
         type Tbuffer_Dest is access Buffer_Dest; 
         procedure Lib_Buffer_Dest is           -- Obligamos a que esté en el heap para que no salte Storage_Error
         new Unchecked_Deallocation(Buffer_Dest,Tbuffer_Dest);

         type Buffer_Orig is array (1 .. Tam_Bytes_Orig) of Byte; 
         type Tbuffer_Orig is access Buffer_Orig; 
         procedure Lib_Buffer_Orig is 
         new Unchecked_Deallocation(Buffer_Orig,Tbuffer_Orig);

         type Vector is array (1 .. Long) of Byte; 
         type Tvector is access Vector; 
         procedure Lib_Vector is 
         new Unchecked_Deallocation(Vector,Tvector);

         package Directo_Dest is new Ada.Direct_Io(Buffer_Dest);
         use Directo_Dest;
         package Directo_Orig is new Ada.Direct_Io(Buffer_Orig);
         use Directo_Orig;

         F_Dest : Directo_Dest.File_Type;  
         F_Orig : Directo_Orig.File_Type;  

         Sec     : T_Secuencia;  
         V_Bytes : Tvector     :=
         new Vector;
         B_Dest : Tbuffer_Dest :=
         new Buffer_Dest;
         B_Orig : Tbuffer_Orig :=
         new Buffer_Orig;

         Offset_Data : Integer  := 0;  
         Estadistica,  
         Aux         : Positive := 1;  

         procedure Escribir (
               B : Byte ) is 
            Temp : Byte;  
            Pos  : Positive;  
         begin
            Estadistica:=Estadistica+1;
            for I in 1..8 loop
               Siguiente_Posicion(Sec,Positive(Pos));
               Temp:=B_Dest(Pos+Positive(Offset_Data));
               Change_Bit(Temp,Look_Bit(B,Position(I)));
               B_Dest(Pos+Positive(Offset_Data)):=Temp;
            end loop;
         end Escribir;


         Inicio,  
         Final  : Time;  

      begin
         Put_Line("Generando secuencia de posiciones");
         Inicio:=Clock;
         Sec:=Generador (Semilla (Clave));
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Secuencia de posiciones generada");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;


         Open(F_Dest,Inout_File, Ruta_Destino);
         Read(F_Dest,B_Dest.All);
         Close(F_Dest);

         Open(F_Orig,Inout_File, Ruta_Origen);
         Read(F_Orig,B_Orig.All);
         Close(F_Orig);

         -- Miramos el offset donde empiezan los datos
         for I in 11..13 loop
            V_Bytes(1):=B_Dest(I);
            Offset_Data:=Offset_Data+To_Integer(V_Bytes(1))*(256**(I-11));
         end loop;
         Offset_Data:=Offset_Data;



         -- Escribimos la longitud de la ruta
         Put_Line("Escribiendo longitud de ruta");
         Inicio:=Clock;
         V_Bytes(1):=To_Byte(Integer(Longitud_String(Ruta_Origen)));
         V_Bytes(1):=V_Bytes(1) xor To_Byte(Clave(1)); -- XOR
         V_Bytes(1):=To_Byte((To_Integer(V_Bytes(1))+Character'Pos(Clave(
                     1))) mod 256); -- Cesar
         Escribir(V_Bytes(1));
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Longitud de ruta escrita correctamente");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;

         -- Escribimos la ruta
         Put_Line("Escribiendo ruta");
         Inicio:=Clock;
         for I in 0..Longitud_String(Ruta_Origen)-1 loop
            V_Bytes((I mod Long)+1):=To_Byte(Ruta_Origen(I+1));
            V_Bytes((I mod Long)+1):=V_Bytes((I mod Long)+1) xor To_Byte(
               Clave((I mod Long)+1)); -- XOR
            V_Bytes((I mod Long)+1):=To_Byte((To_Integer(V_Bytes((I mod
                           Long)+1))+Character'Pos(Clave((I mod Long)+1))) mod
               256);                -- Cesar
            -- Escribimos en fichero si:
            -- * Hemos completado todo el vector V_Bytes
            -- * Hemos analizado toda la ruta
            if (I mod Long)+1=Long then
               for J in 1..Long loop
                  Escribir(V_Bytes(J));
               end loop;
            elsif I=Longitud_String(Ruta_Origen)-1 then
               for J in 1..(I mod Long)+1 loop
                  Escribir(V_Bytes(J));
               end loop;
            end if;
         end loop;
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Ruta escrita correctamente");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;

         -- Escribimos el checksum de la ruta
         Put_Line("Escribiendo checksum de la ruta");
         Inicio:=Clock;
         V_Bytes(1):=To_Byte(Semilla (Ruta_Origen(1..Longitud_String(
                     Ruta_Origen))) mod 256);
         V_Bytes(1):=V_Bytes(1) xor To_Byte(Clave(1)); -- XOR
         V_Bytes(1):=To_Byte((To_Integer(V_Bytes(1))+Character'Pos(Clave(
                     1))) mod 256); -- Cesar
         Escribir(V_Bytes(1));
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Checksum de ruta escrita correctamente");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;

         -- Escribimos el tamaño del archivo
         Put_Line("Escribiendo tamano de archivo");
         Inicio:=Clock;
         for I in 1..4 loop
            V_Bytes(I):=To_Byte(Integer((Tam_Bytes_Orig/(256**(I-1))) mod
                  256));
            V_Bytes(I):=V_Bytes(I) xor To_Byte(Clave(I)); -- XOR
            V_Bytes(I):=To_Byte((To_Integer(V_Bytes(I))+Character'Pos(
                     Clave(I))) mod 256); -- Cesar
            Escribir(V_Bytes(I));
         end loop;
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Tamano de archivo escrito correctamente");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;


         -- Escribimos el fichero
         Put_Line("Escribiendo datos de fichero");
         Inicio:=Clock;
         for I in 1..Tam_Bytes_Orig  loop
            V_Bytes(Aux):=B_Orig(I);
            V_Bytes(Aux):=V_Bytes(Aux) xor To_Byte(Clave(Aux)); -- XOR
            V_Bytes(Aux):=To_Byte((To_Integer(V_Bytes(Aux))+Character'Pos(
                     Clave(Aux))) mod 256); -- Cesar
            if Aux=Long then
               Aux:=1;
               for I in 1..Long loop
                  Escribir(V_Bytes(I));
               end loop;
            else
               Aux:=Aux+1;
            end if;
         end loop;

         if Aux/=1 then
            for I in 1..Aux loop
               Escribir(V_Bytes(I));
            end loop;
         end if;
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Datos de fichero escritos correctamente");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);

         Lib_Buffer_Orig(B_Orig);
         Lib_Vector(V_Bytes);

         New_Line;
         Put_Line("Creando archivo");
         Inicio:=Clock;
         Create(F_Dest,Out_File,Ruta_Copia);
         Write(F_Dest,B_Dest.All);
         Close(F_Dest);
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Archivo creado correctamente");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;
         Put_Line("Se han escrito un total de " & Estadistica'Img &
            " bytes");
         New_Line;

         Lib_Buffer_Dest(B_Dest);
         Borrar(Sec);
      end Codificar;

   begin


      Open(F,In_File,Ruta_Destino);
      Tamaño_Bytes_Dest:=Size(F);
      Close(F);
      begin
         Open(F,In_File,Ruta_Origen);
         Tamaño_Bytes_Orig:=Size(F);
         Close(F);
      exception
         when Constraint_Error=>
            -- Size(F) da error si el fichero origen está vacio
            -- El fichero destino debe ser un BMP por la precondition, 
            -- por tanto no puede estar vacio
            raise Archivo_Origen_Vacio;
      end;
      Codificar(Tamaño_Bytes_Orig, Tamaño_Bytes_Dest,
         Espacio_Disponible_Bmp24(Ruta_Destino),Longitud_String(
            Clave));
      Put_Line("Tiempo total requerido: " & Tiempo'Img);
      New_Line;
   end Encriptar_Cesar;














   -- Prec:  "Ruta_origen" es una ruta del sistema válida a una imagen no abierta de 
   --       tipo Bitmap de 24 bits por pixel, el cual contiene un archivo
   --       ocultado correctamente con el procedimiento "Encriptar_cesar"
   --       "Clave" es un string válido de longitud entre 8 y 16, el mismo usado 
   --       en el procedimiento "Encriptar_cesar" para esconder este fichero.
   --       "Ruta_alternativa" es una ruta del sistema válida para crear un fichero o sobreecribir
   --       uno ya existente; solo se tomará en cuenta si Usar_ruta_alternativa=2
   -- Post: Si Usar_ruta_alternativa=0,
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
         Usar_Ruta_Alternativa : Opcion_Alternativa := 0; 
         Ruta_Alternativa      : String             := "" ) is 

      Tiempo : Duration      := 0.0; -- Estadísticas                                                                                                                                      
      F      : T_Binary_File;  

      Tamaño_Origen : Positive;  

      procedure Descodificar (
            Tam_Origen,            
            Tam_Disp   : Positive; 
            Long       : Positive  ) is 
         package Aleatorio is new D_Orden_Secuencia(Tam_Disp);
         use Aleatorio;

         -- Cargamos el archivo a leer en memoria principal
         -- Así no lo leemos directamente y conseguimos
         -- acelerar el recorrido de la lectura 10 veces más
         -- Tiempo para desencriptar un archivo de 200kb en una imagen de 1024x768
         -- en un AMD 2100, 1GB RAM: 48 segundos sin buffer
         -- Tiempo para desencriptar un archivo de 200kb en una imagen de 1024x768
         -- en un AMD 2100, 1GB RAM: 5 segundos con buffer
         type Vbuffer is array (1 .. Tam_Origen) of Byte; 
         type Tbuffer is access Vbuffer; 
         procedure Lib_Buffer is           -- Obligamos a que esté en el heap para que no salte Storage_Error
         new Unchecked_Deallocation(Vbuffer,Tbuffer);

         type Vector is array (1 .. Long) of Byte; 
         type Tvector is access Vector; 
         procedure Lib_Vector is 
         new Unchecked_Deallocation(Vector,Tvector);

         package Directo is new Ada.Direct_Io (Vbuffer);
         use Directo;

         F_Orig : Directo.File_Type;  

         Tamaño_Archivo,  
         Longitud_Ruta  : Integer;  
         Ruta_Destino   : String (1 .. 256);  
         Sec            : T_Secuencia;  
         V_Bytes        : Tvector           :=
         new Vector;
         Buffer : Tbuffer :=
         new Vbuffer;
         Offset_Data : Integer  := 0;  
         Estadistica : Positive := 1;  

         function Leer return Byte is 
            Devolver,  
            Leer     : Byte     := Init_Byte;  
            Pos      : Positive;  
         begin
            Estadistica:=Estadistica+1;
            for I in 1..8 loop
               Siguiente_Posicion(Sec,Positive(Pos));
               Leer:=Buffer(Pos+Positive(Offset_Data));
               Change_Bit(Devolver,Look_Bit(Leer),Position(I));
            end loop;
            return Devolver;
         end Leer;

         Inicio,  
         Final  : Time;  

         Aux_Boolean : Boolean := True;  
         Aux         : Natural := 0;  
      begin
         Put_Line("Generando secuencia de posiciones");
         Inicio:=Clock;
         Sec:=Generador (Semilla (Clave));
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Secuencia de posiciones generada");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;



         Open(F_Orig,In_File, Ruta_Origen);
         Read(F_Orig,Buffer.All);
         Close(F_Orig);

         -- Miramos el offset donde empiezan los datos
         for I in 11..13 loop
            V_Bytes(1):=Buffer(I);
            Offset_Data:=Offset_Data+To_Integer(V_Bytes(1))*(256**(I-11));
         end loop;
         Offset_Data:=Offset_Data;



         -- Leemos longitud de la ruta
         Put_Line("Leyendo longitud de ruta");
         Inicio:=Clock;
         V_Bytes(1):=Leer;
         V_Bytes(1):=To_Byte((To_Integer(V_Bytes(1))-Character'Pos(Clave(
                     1))) mod 256); -- Cesar
         V_Bytes(1):=V_Bytes(1) xor To_Byte(Clave(1)); -- XOR
         Longitud_Ruta:=To_Integer(V_Bytes(1));
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Longitud de ruta leida correctamente: " & Longitud_Ruta'
            Img);
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;

         -- Leemos la ruta
         Put_Line("Leyendo ruta");
         Inicio:=Clock;
         for I in 0..Longitud_Ruta-1 loop
            V_Bytes(1):=Leer;
            V_Bytes(1):=To_Byte((To_Integer(V_Bytes(1))-Character'Pos(
                     Clave((I mod Long)+1))) mod 256);  -- Cesar
            V_Bytes(1):=V_Bytes(1) xor To_Byte(Clave((I mod Long)+1));
            -- XOR 
            Ruta_Destino(I+1):=To_Character(V_Bytes(1));
         end loop;
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Ruta leida correctamente: " & Ruta_Destino(1..
               Longitud_Ruta));
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;

         -- Comprobamos ruta
         Put_Line("Comprobando ruta con checksum");
         Inicio:=Clock;
         V_Bytes(1):=Leer;
         V_Bytes(1):=To_Byte((To_Integer(V_Bytes(1))-Character'Pos(Clave(
                     1))) mod 256);  -- Cesar
         V_Bytes(1):=V_Bytes(1) xor To_Byte(Clave(1));-- XOR 
         if (Semilla (Ruta_Destino(1..Longitud_Ruta)) mod 256) /=
               To_Integer(V_Bytes(1)) then
            Put_Line("Ha fallado el checksum");
            New_Line;
            raise Checksum_Fail;
         end if;
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Ruta verificada correctamente");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;

         Put(Usar_Ruta_Alternativa'Img);
         case Usar_Ruta_Alternativa is
            when 0=> -- Creamos el archivo y sobreescribimos 
               Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(
                     Ruta_Destino(1..Longitud_Ruta)));
            when 1=>
               -- Creamos el archivo. Si ya existe, lo creamos con una extensión entre 0 y 255
               -- Si aún así existe, lo creamos con extensión 256 y sobreescribimos
               if Comprobar_Ruta (Ruta_Archivo(Ruta_Origen) & Archivo(Ruta_Destino(1..Longitud_Ruta))) then
                  while (Aux_Boolean) and Aux<=255 loop
                     Aux_Boolean:=Comprobar_Ruta(Ruta_Destino(1..Longitud_Ruta)& Aux'Img);
                     Aux:=Aux+1;
                  end loop;
                  if not Aux_Boolean then
                     Aux:=Aux-1;
                     Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(
                           Ruta_Destino(1..Longitud_Ruta)& Aux'Img));
                  else
                     Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(
                           Ruta_Destino(1..Longitud_Ruta)& Aux'Img));
                  end if;
               else
                  Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(
                        Ruta_Destino(1..Longitud_Ruta)));
               end if;
            when 2=>
               -- Creamos el fichero con la ruta proporcionada 
               if Ruta_Archivo(Ruta_Alternativa)="" then
                  Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(Ruta_Alternativa));
               else
                  Create(F,Out_File,Ruta_Alternativa);
               end if;
         end case;


         -- Leemos el tamaño del archivo
         Put_Line("Leyendo tamano de archivo");
         Inicio:=Clock;
         Tamaño_Archivo:=0;
         for I in 1..4 loop
            V_Bytes(1):=Leer;
            V_Bytes(1):=To_Byte((To_Integer(V_Bytes(1))-Character'Pos(
                     Clave(I))) mod 256); -- Cesar
            V_Bytes(1):=V_Bytes(1) xor To_Byte(Clave(I)); -- XOR   
            Tamaño_Archivo:=Tamaño_Archivo+To_Integer(V_Bytes(1))*(256**(
                  I-1));
         end loop;
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Tamano de archivo leido correctamente: " &
            Tamaño_Archivo'Img);
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;


         -- Escribimos el fichero
         Put_Line("Leyendo datos y escribiendo fichero");
         Inicio:=Clock;
         for I in 0..Tamaño_Archivo-1 loop
            V_Bytes((I mod Long)+1):=Leer;
            V_Bytes((I mod Long)+1):=To_Byte((To_Integer(V_Bytes((I mod
                           Long)+1))-Character'Pos(
                     Clave((I mod Long)+1))) mod 256); -- Cesar
            V_Bytes((I mod Long)+1):=V_Bytes((I mod Long)+1) xor To_Byte(
               Clave((I mod Long)+1)); -- XOR

            if (I mod Long)+1=Long then
               for J in 1..Long loop
                  Write(F,V_Bytes(J));
               end loop;
            elsif I=Tamaño_Archivo-1 then
               for J in 1..(I mod Long)+1 loop
                  Write(F,V_Bytes(J));
               end loop;

            end if;
         end loop;
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Fichero escrito correctamente");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;
         Put_Line("Se han descifrado un total de " & Estadistica'Img &
            " bytes");
         New_Line;
         Close(F);
         Borrar(Sec);
         Lib_Vector(V_Bytes);
         Lib_Buffer(Buffer);
      end Descodificar;

   begin
      Open (F,In_File,Ruta_Origen);
      Tamaño_Origen:=Size(F);
      Close(F);
      Descodificar(Tamaño_Origen,Espacio_Disponible_Bmp24(Ruta_Origen),
         Longitud_String(
            Clave));
      Put_Line("Tiempo total requerido: " & Tiempo'Img);
      New_Line;
   end Desencriptar_Cesar;


   --------------------------------------------------------------------------------------



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
         Clave        : String  ) is 
      -- Detalles del cifrado:
      -- * Los datos están desordenados: el orden de las posiciones de los bits cifrados ha sido
      --   generado mediante un generador pseudo aleatorio con una semilla obtenida a partir de la clave
      -- * Se le ha aplicado a cada grupo de 16 bytes un cifrado Serpent

      Tiempo            : Duration      := 0.0; -- Estadísticas                                                                                                                                     
      F                 : T_Binary_File;  
      Tamaño_Bytes_Orig,  
      Tamaño_Bytes_Dest : Positive;  

      procedure Codificar (
            Tam_Bytes_Orig,            
            Tam_Bytes_Dest,            
            Tam_Disp       : Positive; 
            Long           : Positive  ) is 
         package Aleatorio is new D_Orden_Secuencia(Tam_Disp);
         use Aleatorio;

         -- Cargamos los archivos en memoria principal
         -- Así no leemos los archivos directamente y conseguimos
         -- acelerar el recorrido de éstos 10 veces más
         -- Tiempo para encriptar un archivo de 200kb en una imagen de 1024x768
         -- en un AMD 2100, 1GB RAM: 38 segundos sin buffer
         -- Tiempo para encriptar un archivo de 200kb en una imagen de 1024x768
         -- en un AMD 2100, 1GB RAM: 4 segundos con buffer


         type Buffer_Dest is array (1 .. Tam_Bytes_Dest) of Byte; 
         type Tbuffer_Dest is access Buffer_Dest; 
         procedure Lib_Buffer_Dest is           -- Obligamos a que esté en el heap para que no salte Storage_Error
         new Unchecked_Deallocation(Buffer_Dest,Tbuffer_Dest);

         type Buffer_Orig is array (1 .. Tam_Bytes_Orig) of Byte; 
         type Tbuffer_Orig is access Buffer_Orig; 
         procedure Lib_Buffer_Orig is 
         new Unchecked_Deallocation(Buffer_Orig,Tbuffer_Orig);


         package Directo_Dest is new Ada.Direct_Io(Buffer_Dest);
         use Directo_Dest;
         package Directo_Orig is new Ada.Direct_Io(Buffer_Orig);
         use Directo_Orig;

         F_Dest : Directo_Dest.File_Type;  
         F_Orig : Directo_Orig.File_Type;  

         Byte_Aux : Byte;  
         Sec      : T_Secuencia;  
         Vector16 : Passwords.String16;  
         Vector32 : Passwords.String32;  
         Clave16  : Passwords.String16 := (others => ' ');  
         B_Dest   : Tbuffer_Dest       :=
         new Buffer_Dest;
         B_Orig : Tbuffer_Orig :=
         new Buffer_Orig;

         Offset_Data        : Integer  := 0;  
         Estadistica        : Positive := 1;  
         Checksum_Realizado : Boolean  := False;  

         procedure Escribir is 
            Temp : Byte;  
            Pos  : Positive;  
         begin
            for J in 1..32 loop
               Estadistica:=Estadistica+1;
               for I in 1..4 loop
                  Siguiente_Posicion(Sec,Positive(Pos));
                  Temp:=B_Dest(Pos+Positive(Offset_Data));
                  Change_Bit(Temp,Look_Bit(To_Byte(Vector32(J)),Position((
                              2*I)-1)),7);
                  Change_Bit(Temp,Look_Bit(To_Byte(Vector32(J)),Position(
                           2*I)),8);
                  B_Dest(Pos+Positive(Offset_Data)):=Temp;
               end loop;
            end loop;
         end Escribir;


         Inicio,  
         Final  : Time;  

         Ind_Ruta,  
         Ind_Tamaño,  
         Ind_Datos,  
         Var16      : Positive := 1;  



      begin
         Put_Line("Generando secuencia de posiciones");
         Inicio:=Clock;
         Sec:=Generador (Semilla (Clave));
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Secuencia de posiciones generada");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;


         Open(F_Dest,Inout_File, Ruta_Destino);
         Read(F_Dest,B_Dest.All);
         Close(F_Dest);

         Open(F_Orig,Inout_File, Ruta_Origen);
         Read(F_Orig,B_Orig.All);
         Close(F_Orig);

         -- Miramos el offset donde empiezan los datos
         for I in 11..13 loop
            Byte_Aux:=B_Dest(I);
            Offset_Data:=Offset_Data+To_Integer(Byte_Aux)*(256**(I-11));
         end loop;
         Offset_Data:=Offset_Data;

         -- Ponemos la clave en Clave16
         Clave16(1..Long):=Clave(1..Long);

         Put_Line("Iniciando codificacion");
         Inicio:=Clock;
         loop
            if Var16=1 and Ind_Ruta=1 and Ind_Tamaño=1 and Ind_Datos=1 then
               -- Tamaño de la ruta
               Vector16(1):=To_Character(To_Byte(Integer(Longitud_String(
                           Ruta_Origen))));

            elsif Ind_Ruta<=Longitud_String(Ruta_Origen) then -- Ruta
               Vector16(Var16):=Ruta_Origen(Ind_Ruta);
               Ind_Ruta:=Ind_Ruta+1;

            elsif (not Checksum_Realizado) then
               -- Checksum
               Vector16(Var16):=Character'Val(Semilla(Ruta_Origen(1..Longitud_String(Ruta_Origen))) mod 256);
               Checksum_Realizado:=True;

            elsif Ind_Tamaño<=4  then -- Tamaño del fichero
               Vector16(Var16):=To_Character(To_Byte(Integer((
                           Tam_Bytes_Orig/(256**(Ind_Tamaño-1))) mod 256)));
               Ind_Tamaño:=Ind_Tamaño+1;
            else -- Datos del fichero
               Vector16(Var16):=To_Character(B_Orig(Ind_Datos));
               Ind_Datos:=Ind_Datos+1;
            end if;

            if Var16=16 then
               Var16:=1;
               -- Codificamos 
               Vector32:= Passwords.Password_Encrypt(Clave16, Vector16);
               -- Escribimos los datos en la imagen
               Escribir;
            else
               Var16:=Var16+1;
            end if;

            exit when Tam_Bytes_Orig+1=Ind_Datos;
         end loop;
         if Var16/=1 then -- codificamos y escribimos por última vez...
            Vector32:= Passwords.Password_Encrypt(Clave16, Vector16);
            Escribir;
         end if;
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Codificacion completada");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;


         Lib_Buffer_Orig(B_Orig);

         New_Line;
         Put_Line("Creando archivo");
         Inicio:=Clock;
         Create(F_Dest,Out_File,Ruta_Copia);
         Write(F_Dest,B_Dest.All);
         Close(F_Dest);
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Archivo creado correctamente");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;
         Put_Line("Se han escrito un total de " & Estadistica'Img &
            " bytes");
         New_Line;

         Lib_Buffer_Dest(B_Dest);
         Borrar(Sec);
      end Codificar;

   begin

      Open(F,In_File,Ruta_Destino);
      Tamaño_Bytes_Dest:=Size(F);
      Close(F);
      Open(F,In_File,Ruta_Origen);
      Tamaño_Bytes_Orig:=Size(F);
      Close(F);
      Codificar(Tamaño_Bytes_Orig, Tamaño_Bytes_Dest,
         Espacio_Disponible_Bmp24(Ruta_Destino),Longitud_String(
            Clave));
      Put_Line("Tiempo total requerido: " & Tiempo'Img);
      New_Line;

   end Encriptar_Serpent;


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
         Usar_Ruta_Alternativa : Opcion_Alternativa := 0; 
         Ruta_Alternativa      : String             := "" ) is 

      Tiempo : Duration      := 0.0; -- Estadísticas                                                                                                                                      
      F      : T_Binary_File;  

      Tamaño_Origen : Positive;  

      procedure Descodificar (
            Tam_Origen,            
            Tam_Disp   : Positive; 
            Long       : Positive  ) is 
         package Aleatorio is new D_Orden_Secuencia(Tam_Disp);
         use Aleatorio;

         -- Cargamos el archivo a leer en memoria principal
         -- Así no lo leemos directamente y conseguimos
         -- acelerar el recorrido de la lectura 10 veces más
         -- Tiempo para desencriptar un archivo de 200kb en una imagen de 1024x768
         -- en un AMD 2100, 1GB RAM: 48 segundos sin buffer
         -- Tiempo para desencriptar un archivo de 200kb en una imagen de 1024x768
         -- en un AMD 2100, 1GB RAM: 5 segundos con buffer
         type Vbuffer is array (1 .. Tam_Origen) of Byte; 
         type Tbuffer is access Vbuffer; 
         procedure Lib_Buffer is           -- Obligamos a que esté en el heap para que no salte Storage_Error
         new Unchecked_Deallocation(Vbuffer,Tbuffer);


         package Directo is new Ada.Direct_Io (Vbuffer);
         use Directo;

         F_Orig : Directo.File_Type;  

         Tamaño_Archivo,  
         Longitud_Ruta  : Integer           := 0;  
         Ruta_Destino   : String (1 .. 256);  
         Sec            : T_Secuencia;  

         Byte_Aux : Byte;  
         Clave16,  
         Vector16 : Passwords.String16 := (others => ' ');  
         Vector32 : Passwords.String32 := (others => ' ');  

         Buffer : Tbuffer :=
         new Vbuffer;
         Offset_Data : Integer  := 0;  
         Estadistica : Positive := 1;  

         Var16,  
         Ind_Ruta,  
         Ind_Tamaño,  
         Ind_Datos  : Positive := 1;  

         Aux : Natural := 0;  

         procedure Leer is 
            Temp,  
            Leer : Byte     := Init_Byte;  
            Pos  : Positive;  
         begin
            for I in 1..32 loop
               Estadistica:=Estadistica+1;
               for J in 1..4 loop
                  Siguiente_Posicion(Sec,Positive(Pos));
                  Leer:=Buffer(Pos+Positive(Offset_Data));
                  Change_Bit(Temp,Look_Bit(Leer,7),Position((2*J)-1));
                  Change_Bit(Temp,Look_Bit(Leer,8),Position(2*J));
               end loop;
               Vector32(I):=To_Character(Temp);
            end loop;
         end Leer;

         Checksum_Realizado,  
         Interruptor1,  
         Interruptor2       : Boolean := False;  
         Inicio,  
         Final              : Time;  

      begin
         Put_Line("Generando secuencia de posiciones");
         Inicio:=Clock;
         Sec:=Generador (Semilla (Clave));
         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Secuencia de posiciones generada");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;



         Open(F_Orig,In_File, Ruta_Origen);
         Read(F_Orig,Buffer.All);
         Close(F_Orig);

         -- Miramos el offset donde empiezan los datos
         for I in 11..13 loop
            Byte_Aux:=Buffer(I);
            Offset_Data:=Offset_Data+To_Integer(Byte_Aux)*(256**(I-11));
         end loop;
         Offset_Data:=Offset_Data;

         -- Ponemos la clave en Clave16
         Clave16(1..Long):=Clave(1..Long);


         Put_Line("Iniciando descodificacion");
         Inicio:=Clock;
         Leer;
         Vector16:=Passwords.Password_Decrypt(Clave16,Vector32);
         loop

            if Var16=1 and Ind_Datos=1 and Ind_Ruta=1 and Ind_Tamaño=1 then
               Longitud_Ruta:=To_Integer(To_Byte(Vector16(1)));
               -- Tamaño de ruta
               Put_Line("Longitud de la ruta leida correctamente: " &
                  Longitud_Ruta'Img);
            elsif Ind_Ruta<=Longitud_Ruta then
               Ruta_Destino(Ind_Ruta):=Vector16(Var16); -- Ruta
               Ind_Ruta:=Ind_Ruta+1;
            elsif (not Checksum_Realizado) then -- Checksum
               if (Semilla (Ruta_Destino(1..Longitud_Ruta)) mod 256) /=Character'Pos(Vector16(Var16))   then
                  Put_Line("Ha fallado el checksum");
                  raise Checksum_Fail;
               else
                  Put_Line("Checksum correcto");
               end if;
               Checksum_Realizado:=True;
            elsif Ind_Tamaño<=4 and (Interruptor2) then -- Tamaño
               Tamaño_Archivo:=Tamaño_Archivo+To_Integer(To_Byte(Vector16(Var16)))*(256**(Ind_Tamaño-1));
               if Ind_Tamaño=4 then
                  Put_Line("Tamano de archivo leido correctamente: " &
                     Tamaño_Archivo'Img);
                  Interruptor1:=True;
               end if;
               Ind_Tamaño:=Ind_Tamaño+1;
            else -- Datos
               Write(F,To_Byte(Vector16(Var16)));
               Ind_Datos:=Ind_Datos+1;
            end if;


            if (not Interruptor2) and Checksum_Realizado then
               Put_Line("Ruta leida correctamente: " & Ruta_Destino(1..
                     Longitud_Ruta));
               case Usar_Ruta_Alternativa is
                  when 0=> -- Creamos el archivo y sobreescribimos 
                     Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(
                           Ruta_Destino(1..Longitud_Ruta)));
                  when 1=>
                     -- Creamos el archivo. Si ya existe, lo creamos con una extensión entre 0 y 255
                     -- Si aún así existe, lo creamos con extensión 256 y sobreescribimos
                     if Comprobar_Ruta (Ruta_Archivo(Ruta_Origen) & Archivo(Ruta_Destino(1..Longitud_Ruta))) then
                        Interruptor2:=True;
                        while (Interruptor2) and Aux<=255 loop
                           Interruptor2:=Comprobar_Ruta(Ruta_Destino(1..Longitud_Ruta)& Aux'Img);
                           Aux:=Aux+1;
                        end loop;
                        if not Interruptor2 then
                           Aux:=Aux-1;
                           Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(
                                 Ruta_Destino(1..Longitud_Ruta)& Aux'Img));
                        else
                           Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(
                                 Ruta_Destino(1..Longitud_Ruta)& Aux'Img));
                        end if;
                     else
                        Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(
                              Ruta_Destino(1..Longitud_Ruta)));
                     end if;
                  when 2=>
                     -- Creamos el fichero con la ruta proporcionada 
                     if Ruta_Archivo(Ruta_Alternativa)="" then
                        Create(F,Out_File,Ruta_Archivo(Ruta_Origen) & Archivo(Ruta_Alternativa));
                     else
                        Create(F,Out_File,Ruta_Alternativa);
                     end if;
               end case;
               Tamaño_Archivo:=0;
               Interruptor2:=True;
            end if;

            exit when Ind_Datos>Tamaño_Archivo and Interruptor1;
            
            if Var16=16 then
               Var16:=1;
               Leer;              
               Vector16:=Passwords.Password_Decrypt(Clave16,Vector32);
            else
               Var16:=Var16+1;
            end if;

         end loop;

         Final:=Clock;
         Tiempo:=Tiempo+To_Duration(Final-Inicio);
         Put_Line("Descodificacion terminada");
         Put_Line("Operacion realizada en " & To_Duration(Final-Inicio)'
            Img);
         New_Line;


         Put_Line("Se han descifrado un total de " & Estadistica'Img &
            " bytes");
         New_Line;
         Close(F);
         Borrar(Sec);
         Lib_Buffer(Buffer);

      end Descodificar;

   begin
      Open (F,In_File,Ruta_Origen);
      Tamaño_Origen:=Size(F);
      Close(F);
      Descodificar(Tamaño_Origen,Espacio_Disponible_Bmp24(Ruta_Origen),
         Longitud_String(
            Clave));
      Put_Line("Tiempo total requerido: " & Tiempo'Img);
      New_Line;
   end Desencriptar_Serpent;


end D_Imagen_Bmp24;