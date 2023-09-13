with D_Xtras;

separate (Adasteganogui)

procedure Informacion_Adicional is 
   Panel_Informacion : Panel_Type       := Panel (Principal, (15, 392), 585, 25, "");  
   Temp              : Natural          := Campo_Informacion + 1;  
   Etiqueta_Info     : Label_Type       := Label (Panel_Informacion, (10, 5), 570, 15, "");  
   Mensaje           : Unbounded_String;  

begin
   loop
      if Temp/=Campo_Informacion or (Campo_Informacion=52 or Campo_Informacion=51) then
         Temp:=Campo_Informacion;
         case Temp is
            -- 0 => Informacion general
            --1..2 => Mensajes de contraseñas
            --3..50 => Reservado
            --51 => Informacion cifrado
            --52=> Informacion descifrado
            when 0 =>
               Set_Text(Etiqueta_Info,"Cumplimente los datos correctamente y elija la opción 'Cifrar' o 'Descifrar'");

            when 1 =>
               Set_Text(Etiqueta_Info,"Longitud de contraseña incorrecta. La longitud debe estar entre " & Esteganografia.Longitud_Minima_Clave'Img & " y " & Esteganografia.Longitud_Maxima_Clave'Img & " carácteres");

            when 2 =>
               Set_Text(Etiqueta_Info,"Confirmación de contraseña incorrecta. Recuerde repetirla en el cuadro correspondiente");

            when 51=>

               Mensaje:=To_Unbounded_String("Cifrado : ");
               declare
                  Ruta_Origen  : Unbounded_String := To_Unbounded_String (Get_Text (E_C_Origen));  
                  Ruta_Destino : Unbounded_String := To_Unbounded_String (Get_Text (E_C_Destino));  
               begin
                  -- Sustituimos la ruta por un guion si el usuario
                  -- todavía no ha introducido una ruta manualmente
                  if Mensaje_C_Origen=To_String(Ruta_Origen) then
                     Ruta_Origen:=To_Unbounded_String("-");
                  end if;
                  if Mensaje_Contenedor=To_String(Ruta_Destino) then
                     Ruta_Destino:=To_Unbounded_String("-");
                  end if;

                  -- Escribimos los nombres de los archivos
                  Mensaje:=Mensaje & To_Unbounded_String(D_Xtras.Archivo(To_String(Ruta_Origen)))
                     & To_Unbounded_String(" / ") & To_Unbounded_String(D_Xtras.Archivo(To_String(Ruta_Destino)) )
                     ;

                  -- Escribimos el espacio necesario en Kb del archivo de origen
                  if D_Xtras.Comprobar_Ruta(To_String(Ruta_Origen)) then
                     Mensaje:=Mensaje & To_Unbounded_String("    Esp. nec: ")
                        & Positive'Image(D_Xtras.Tamaño_Archivo(To_String(Ruta_Origen))/1024) & To_Unbounded_String("Kb / ");
                  else
                     Mensaje:=Mensaje & To_Unbounded_String("   Esp. nec: - / ");
                  end if;

                  -- Escribimos el espacio en Kb que ofrece el archivo "contenedor"
                  if D_Xtras.Comprobar_Ruta(To_String(Ruta_Destino)) then
                     if Esteganografia.Archivo_Valido_Ocultacion(Esteganografia.Tipo_Archivo(To_String(Ruta_Destino))) then
                        Mensaje:=Mensaje & To_Unbounded_String("Esp. disp: ")& Positive'Image(Esteganografia.Espacio_Disponible(To_String(Ruta_Destino))/8192)
                           & To_Unbounded_String("Kb") ;
                     else
                        Mensaje:=Mensaje & To_Unbounded_String(" No soportado");
                     end if;
                  else
                     Mensaje:=Mensaje & To_Unbounded_String("-");
                  end if;
               end;

               Set_Text(Etiqueta_Info,To_String(Mensaje));
               Campo_Informacion:=1000; -- Si no hay cambios, no se hace nada

            when 52=>

               Mensaje:=To_Unbounded_String("Descifrado : ");
               declare
                  Ruta_Origen : Unbounded_String := To_Unbounded_String (Get_Text (E_D_Origen));  

               begin
                  -- Sustituimos la ruta por un guion si el usuario
                  -- todavía no ha introducido una ruta manualmente
                  if Mensaje_Contenedor=To_String(Ruta_Origen) then
                     Ruta_Origen:=To_Unbounded_String("-");
                  end if;


                  -- Escribimos el nombre del archivo
                  Mensaje:=Mensaje & To_Unbounded_String(D_Xtras.Archivo(To_String(Ruta_Origen))) & To_Unbounded_String(" / ");



                  -- Escribimos el tipo de fichero de Contenedor
                  if D_Xtras.Comprobar_Ruta(To_String(Ruta_Origen)) then
                     if Esteganografia.Archivo_Valido_Ocultacion(Esteganografia.Tipo_Archivo(To_String(Ruta_Origen))) then
                        Mensaje:=Mensaje &  To_Unbounded_String(Esteganografia.Descripcion(Esteganografia.Tipo_Archivo(To_String(Ruta_Origen))));
                     else
                        Mensaje:=Mensaje & To_Unbounded_String(" No soportado");
                     end if;
                  else
                     Mensaje:=Mensaje & To_Unbounded_String("-");
                  end if;
               end;

               Set_Text(Etiqueta_Info,To_String(Mensaje));
               Campo_Informacion:=1000; -- Si no hay cambios, no se hace nada

            when others=>
               null;

         end case;
      end if;
      delay (0.15);
   end loop;
end Informacion_Adicional;