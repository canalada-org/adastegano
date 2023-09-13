with D_Xtras;
use D_Xtras;
separate (Adasteganogui)

procedure Descifrar is 
   Metodo                : T_Metodo                   := T_Metodo'First;  
   Alternativa           : D_Xtras.Opcion_Alternativa;  
   Metodo_Incorrecto,  
   Contrase�a_Incorrecta,  
   Ruta_Origen_Invalida,  
   Ruta_Copia_Invalida   : exception;  
begin
   -- Comprobamos la ruta
   if not D_Xtras.Comprobar_Ruta(Get_Text(E_D_Origen)) then
      raise Ruta_Origen_Invalida;
   end if;

   -- Tomamos el metodo
   if Get_Text(C_Metodo)="" then
      raise Metodo_Incorrecto;
   end if;

   while Formato(T_Metodo'Image(Metodo))/=Get_Text(C_Metodo) and not (
         Metodo=T_Metodo'Last) loop
      Metodo:=T_Metodo'Succ(Metodo);
   end loop; -- seleccionamos el metodo correcto
   if Formato(T_Metodo'Image(Metodo))/=Get_Text(C_Metodo) then
      raise Metodo_Incorrecto;
   end if;

   -- Miramos la contrase�a
   if Get_Text(E_Password)/=Get_Text(E_Rpassword)
         or Get_Length(E_Password)<Esteganografia.Longitud_Minima_Clave
         or Get_Length(E_Password)>Esteganografia.Longitud_Maxima_Clave then
      raise Contrase�a_Incorrecta;
   end if;

   -- Miramos la opcion alternativa
   if Get_State(R_Sobreescribir) then
      Alternativa:=0;
   elsif Get_State(R_Guardar_Como) then
      Alternativa:=2;
   else
      Alternativa:=1;
   end if;

   if Alternativa=2 and (Get_Text(E_D_Copia)=Mensaje_Copia or Get_Text(
            E_D_Copia)="") then
      raise Ruta_Copia_Invalida;
   end if;

   -- Si es todo correcto, realizamos la operaci�n
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
      Desencriptar (
         Ruta_Origen           => Get_Text (E_D_Origen), 
         Metodo                => Metodo,                
         Clave                 => Get_Text (E_Password), 
         Usar_Ruta_Alternativa => Alternativa,           
         Ruta_Alternativa      => Get_Text (E_D_Copia));
      Fin:=True;
      Show_Message("Operaci�n realizada con �xito","");

   exception

      when Esteganografia.Archivo_Origen_Vacio =>
         Fin:=True;
         Show_Error("El archivo de origen est� vac�o");
      when Esteganografia.Ruta_No_Valida =>
         Fin:=True;
         Show_Error("La ruta no es v�lida"); -- No deber�a saltar nunca
      when Esteganografia.Uso_No_Valido =>
         Fin:=True;
         Show_Error(
            "El archivo de origen est� en uso o no tiene permisos en la carpeta"
            &" para guardar el archivo resultante");
      when Esteganografia.Informacion_Interna_Corrupta =>
         Fin:=True;
         Show_Error(
            "El archivo seleccionado aparentemente es un archivo "
            &"soportado por AdaSteganoGUI pero su informaci�n interna"
            &" esta corrupta o es incorrecta");
      when Esteganografia.Longitud_Incorrecta =>
         Fin:=True;
         Show_Error("Introduzca una contrase�a entre " &
            -- No deber�a saltar nunca!
            Esteganografia.Longitud_Minima_Clave'Img &" y " &
            Esteganografia.Longitud_Maxima_Clave'Img &
            " caracteres y conf�rmela");
      when Esteganografia.Arc_No_Valido_Ocultacion =>
         Fin:=True;
         Show_Error(
            "El archivo de origen no est� soportado por AdaSteganoGUI");
      when Esteganografia.Imposible_Desencriptar =>
         Fin:=True;
         Show_Error("Ha sido imposible descifrar. Aseg�rese que"
            & " (1) ha introducido la contrase�a correcta, (2) el archivo"
            & " tiene informaci�n oculta en su informaci�n y (3)"
            & " el m�todo de descifrado es el mismo que us� para cifrarlo");
   end;

exception
   when Ruta_Origen_Invalida =>
      Show_Error("La ruta de origen del archivo a descifrar no es v�lida");
   when Ruta_Copia_Invalida =>
      Show_Error("La ruta del archivo a guardar no es v�lida");
   when Metodo_Incorrecto =>
      Show_Error("Seleccione un m�todo de cifrado correcto");
   when Contrase�a_Incorrecta =>
      Show_Error("Introduzca una contrase�a entre " &
         Esteganografia.Longitud_Minima_Clave'Img &" y " &
         Esteganografia.Longitud_Maxima_Clave'Img &
         " caracteres y conf�rmela");

end Descifrar;