with Ada.Text_Io;
use Ada.Text_Io;

with Adastegano_Menu,Pantalla,D_Xtras;
use Adastegano_Menu,Pantalla,D_Xtras;

separate(Adastegano.Preguntar)

procedure Descifrar (
      Metodo : in     T_Metodo ) is 


begin

   -- Ruta origen

   Limpiar_Pantalla;
   Adastegano_Menu.Menu_Descifrado_Ruta_Origen;
   while not Continuar loop
      Ind_Orig:=0;
      Coger_Caracter(C);
      while C/=Esc and C/=Intro loop
         if Ind_Orig<Longitud_Maxima_Ruta and C/=Back then
            Put(C);
            Ind_Orig:=Ind_Orig+1;
            Origen(Ind_Orig):=C;
         end if;
         Coger_Caracter(C);
         if C=Back and Ind_Orig>=1 then
            Borrar_Caracter;
            Ind_Orig:=Ind_Orig-1;
         end if;
      end loop;
      if C=Esc then
         Continuar:=True;
         Limpiar_Pantalla;
         Adastegano_Menu.Menu_Descifrado_Metodo;
      elsif not Comprobar_Ruta (Origen(1..Ind_Orig)) then
         Limpiar_Pantalla;
         Adastegano_Menu.Error_Ruta_Invalida;
         Limpiar_Pantalla;
         Adastegano_Menu.Menu_Descifrado_Ruta_Origen;
      elsif C=Intro and Ind_Orig>0 then
         -- Descifrar/Clave


         Limpiar_Pantalla;
         Adastegano_Menu.Menu_Descifrado_Clave;
         while not Continuar loop
            Ind_Clave:=0;
            Coger_Caracter(C);
            while C/=Esc and C/=Intro loop
               if Ind_Clave<Longitud_Maxima_Clave and C/=
                     Back then
                  Put("***");
                  Ind_Clave:=Ind_Clave+1;
                  Clave(Ind_Clave):=C;
               end if;
               Coger_Caracter(C);
               if C=Back and Ind_Clave>=1  then
                  Borrar_Caracter;
                  Borrar_Caracter;
                  Borrar_Caracter;
                  Ind_Clave:=Ind_Clave-1;
               end if;
            end loop;
            if C=Esc then
               Continuar:=True;
               Limpiar_Pantalla;
               Adastegano_Menu.Menu_Descifrado_Ruta_Origen;
            elsif C=Intro and Ind_Clave<
                  Longitud_Minima_Clave then
               Limpiar_Pantalla;
               Adastegano_Menu.Error_Clave_Pequeña;
               Limpiar_Pantalla;
               Adastegano_Menu.Menu_Descifrado_Clave;
            elsif C=Intro and Ind_Clave>=
                  Longitud_Minima_Clave then
               -- Descifrar/confirmar Clave

               Limpiar_Pantalla;
               Adastegano_Menu.Menu_Descifrado_Confirmar_Clave;
               while not Continuar loop
                  Ind_Clave2:=0;
                  Coger_Caracter(C);
                  while C/=Esc and C/=Intro  loop
                     if Ind_Clave2<
                           Longitud_Maxima_Clave and
                           C/=Back then
                        Put(String_Contraseña);
                        Ind_Clave2:=Ind_Clave2+1;
                        Clave2(Ind_Clave2):=C;
                     end if;
                     Coger_Caracter(C);
                     if C=Back and Ind_Clave2>=1  then
                        Borrar_Caracter;
                        Borrar_Caracter;
                        Borrar_Caracter;
                        Ind_Clave2:=Ind_Clave2-1;
                     end if;

                  end loop;
                  if C=Esc then
                     Continuar:=True;
                     Limpiar_Pantalla;
                     Adastegano_Menu.Menu_Descifrado_Clave;
                  elsif C=Intro then

                     -- Muestra un resumen
                     if Clave(1..Ind_Clave)=
                           Clave2(1..Ind_Clave2) then
                        Limpiar_Pantalla;
                        Menu_Descifrado_Confirmacion_Datos;
                        Confirmacion_Datos_Metodo(T_Metodo'Image(Metodo));
                        Confirmacion_Datos_Origen(Origen(1..Ind_Orig));
                        Confirmacion_Datos_Clave(Mensaje_Confirmacion_Contraseña);
                        New_Line(7);
                        Coger_Caracter(C);
                        while C/=Caracter_Confirmacion_Min and
                              C/=Caracter_Confirmacion_May and
                              C/=Esc loop
                           Coger_Caracter(C);
                        end loop;
                        if C=Esc then
                           Continuar:=True;
                           Limpiar_Pantalla;
                           Adastegano_Menu.Menu_Descifrado_Clave;
                        else
                           P_Descifrar (Origen(1..Ind_Orig),Metodo, Clave(1..Ind_Clave),1);
                           P_Continuar;
                           raise Salir;
                        end if;
                     else
                        Limpiar_Pantalla;
                        Adastegano_Menu.Error_Clave_Repetida_Diferente;
                        Limpiar_Pantalla;
                        Adastegano_Menu.Menu_Descifrado_Confirmar_Clave;
                     end if;


                  end if;
               end loop;
               Continuar:=False;



            end if;
         end loop;
         Continuar:=False;



      end if;
   end loop;
   Continuar:=False;


end Descifrar;