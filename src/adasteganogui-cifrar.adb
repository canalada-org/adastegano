with D_Xtras;
use D_Xtras;

separate (Adasteganogui)

procedure Cifrar is 
   Metodo                : T_Metodo  := T_Metodo'First;  
   Metodo_Incorrecto,  
   Contraseña_Incorrecta,  
   Ruta_Origen_Invalida,  
   Ruta_Destino_Invalida,  
   Ruta_Copia_Invalida   : exception;  
begin
   -- Comprobamos la ruta de origen
   if not D_Xtras.Comprobar_Ruta(Get_Text(E_C_Origen)) then
      raise Ruta_Origen_Invalida;
   end if;
   -- Comprobamos la ruta de destino
   if not D_Xtras.Comprobar_Ruta(Get_Text(E_C_Destino)) then
      raise Ruta_Destino_Invalida;
   end if;

   -- Tomamos el metodo
   if Get_Text(C_Metodo)="" then
      raise Metodo_Incorrecto;
   end if;

   while Formato(T_Metodo'Image(Metodo))/=Get_Text(C_Metodo) and not (Metodo=T_Metodo'Last) loop
      Metodo:=T_Metodo'Succ(Metodo);
   end loop; -- seleccionamos el metodo correcto
   if Formato(T_Metodo'Image(Metodo))/=Get_Text(C_Metodo) then
      raise Metodo_Incorrecto;
   end if;

   -- Miramos la contraseña
   if Get_Text(E_Password)/=Get_Text(E_Rpassword)
         or Get_Length(E_Password)<Esteganografia.Longitud_Minima_Clave
         or Get_Length(E_Password)>Esteganografia.Longitud_Maxima_Clave then
      raise Contraseña_Incorrecta;
   end if;


   if (Get_Text(E_C_Copia)=Mensaje_Copia or Get_Text(E_C_Copia)="") then
      raise Ruta_Copia_Invalida;
   end if;

   -- Si es todo correcto, realizamos la operación
   declare
      Fin : Boolean := False;  
      task Mensaje_Espera;
      task body Mensaje_Espera is
         Loading        : Frame_Type := Frame (175, 100, "", 'l');  
         Mensaje_Espera : Label_Type := Label (Loading, (33, 20), 100, 15, "Espere, por favor");  
         Progreso       : Label_Type := Label (Loading, (34, 40), 130, 15, "");  
         Num_Progreso   : Natural    := 0;  
         function Barra_Progreso (
               N : Natural ) 
           return String is 
            String_Temp : Unbounded_String := Null_Unbounded_String;  
         begin
            for I in 0..N loop
               String_Temp:=String_Temp & To_Unbounded_String(" ");
            end loop;
            return to_string( String_Temp & To_Unbounded_String(".."));
         end Barra_Progreso;
      begin
         Set_Origin(Loading,(Get_Origin(Principal).X-100+(Get_Width(Principal)/2),
               Get_Origin(Principal).Y-50+(Get_Height(Principal)/2)  ));
         Show(Loading);
         while not Fin loop
            Set_Text(Progreso,Barra_Progreso(Num_Progreso));
            if Num_Progreso<25 then
               Num_Progreso:=Num_Progreso+1;
            else
               Num_Progreso:=0;
            end if;
            delay 0.1;
         end loop;
         Hide(Loading);
      end Mensaje_Espera;
   begin
      Encriptar (
         Ruta_Origen  => Get_Text (E_C_Origen),  
         Ruta_Destino => Get_Text (E_C_Destino), 
         Ruta_Copia   => Get_Text (E_C_Copia),   
         Metodo       => Metodo,                 
         Clave        => Get_Text (E_Password));
      Fin:=True;
      Show_Message("Operación realizada con éxito","");

   exception

      when Esteganografia.Archivo_Origen_Vacio =>
         Fin:=True;
         Show_Error("El archivo de origen está vacío");
      when Esteganografia.Ruta_No_Valida =>
         Fin:=True;
         Show_Error("La ruta no es válida"); -- No debería saltar nunca
      when Esteganografia.Uso_No_Valido =>
         Fin:=True;
         Show_Error("El archivo de origen está en uso o no tiene permisos en la carpeta"
            &" para guardar el archivo resultante");
      when Esteganografia.Informacion_Interna_Corrupta =>
         Fin:=True;
         Show_Error("El archivo seleccionado aparentemente es un archivo "
            &"soportado por AdaSteganoGUI pero su información interna"
            &" esta corrupta o es incorrecta");
      when Esteganografia.Longitud_Incorrecta =>
         Fin:=True;
         Show_Error("Introduzca una contraseña entre " & -- No debería saltar nunca!
            Esteganografia.Longitud_Minima_Clave'Img &" y " &
            Esteganografia.Longitud_Maxima_Clave'Img &" caracteres y confírmela");
      when Esteganografia.Arc_No_Valido_Ocultacion =>
         Fin:=True;
         Show_Error("El archivo contenedor no está soportado por AdaSteganoGUI");
      when Esteganografia.Espacio_Insuficiente =>
         Fin:=True;
         Show_Error("El archivo contenedor no tiene espacio suficiente para ocultar el archivo. " &
            "Elija un archivo contenedor con más capacidad o reduzca el tamaño" &
            " del archivo a ocultar");
   end;

exception
   when Ruta_Origen_Invalida =>
      Show_Error("La ruta de origen del archivo a cifrar no es válida");
   when Ruta_Destino_Invalida =>
      Show_Error("La ruta del archivo contenedor no es válida");
   when Ruta_Copia_Invalida =>
      Show_Error("La ruta del archivo a guardar no es válida");
   when Metodo_Incorrecto =>
      Show_Error("Seleccione un método de cifrado correcto");
   when Contraseña_Incorrecta =>
      Show_Error("Introduzca una contraseña entre " &
         Esteganografia.Longitud_Minima_Clave'Img &" y " &
         Esteganografia.Longitud_Maxima_Clave'Img &" caracteres y confírmela");

end Cifrar;