with Ada.Text_Io;
use Ada.Text_Io;

with Adastegano_Menu,Pantalla,d_xtras;
use Adastegano_Menu,Pantalla,d_xtras;

separate(Adastegano.Preguntar)

procedure Cifrar (
      Metodo : in     T_Metodo ) is 


begin

   -- Ruta origen

   Limpiar_Pantalla;
   Adastegano_Menu.Menu_Cifrado_Ruta_Origen;
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
         Adastegano_Menu.Menu_Cifrado_Metodo;
      elsif not Comprobar_ruta (Origen(1..Ind_Orig)) then
         Limpiar_Pantalla;
         Adastegano_Menu.Error_Ruta_Invalida;
         Limpiar_Pantalla;
         Adastegano_Menu.Menu_Cifrado_Ruta_Origen;
      elsif C=Intro and Ind_Orig>0 then
         -- Cifrar/Ruta_destino

         Limpiar_Pantalla;
         Adastegano_Menu.Menu_Cifrado_Ruta_Destino;
         while not Continuar loop
            Ind_Dest:=0;
            Coger_Caracter(C);
            while C/=Esc and C/=Intro  loop
               if Ind_Dest<Longitud_Maxima_Ruta and C/=Back then
                  Put(C);
                  Ind_Dest:=Ind_Dest+1;
                  Destino(Ind_Dest):=C;
               end if;
               Coger_Caracter(C);
               if C=Back and Ind_Dest>=1 then
                  Borrar_Caracter;
                  Ind_Dest:=Ind_Dest-1;
               end if;
            end loop;
            if C=Esc then
               Continuar:=True;
               Limpiar_Pantalla;
               Adastegano_Menu.Menu_Cifrado_Ruta_Origen;
            elsif C=Intro and Ind_Dest>0 and Origen(1..
                  Ind_Orig)=Destino(1..Ind_Dest) then
               Limpiar_Pantalla;
               Adastegano_Menu.Error_Rutas_Iguales;
               Limpiar_Pantalla;
               Adastegano_Menu.Menu_Cifrado_Ruta_Destino;
            elsif not Comprobar_ruta (Destino(1..Ind_Dest)) then
               Limpiar_Pantalla;
               Adastegano_Menu.Error_Ruta_Invalida;
               Limpiar_Pantalla;
               Adastegano_Menu.Menu_Cifrado_Ruta_Destino;
            elsif C=Intro and Ind_Dest>0 then
               -- Cifrar/Ruta_copia


               Limpiar_Pantalla;
               Adastegano_Menu.Menu_Cifrado_Ruta_Copia;
               while not Continuar loop
                  Ind_Cop:=0;
                  Coger_Caracter(C);
                  while C/=Esc and C/=Intro  loop
                     if Ind_Cop<Longitud_Maxima_Ruta and C/=Back then
                        Put(C);
                        Ind_Cop:=Ind_Cop+1;
                        Copia(Ind_Cop):=C;
                     end if;
                     Coger_Caracter(C);
                     if C=Back and Ind_Cop>=1  then
                        Borrar_Caracter;
                        Ind_Cop:=Ind_Cop-1;
                     end if;
                  end loop;
                  if C=Esc then
                     Continuar:=True;
                     Limpiar_Pantalla;
                     Adastegano_Menu.Menu_Cifrado_Ruta_Destino;
                  elsif C=Intro then  -- Cifrar/Clave

                     Limpiar_Pantalla;
                     Adastegano_Menu.Menu_Cifrado_Clave;
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
                           Adastegano_Menu.Menu_Cifrado_Ruta_Copia;
                        elsif C=Intro and Ind_Clave<
                              Longitud_Minima_Clave then
                           Limpiar_Pantalla;
                           Adastegano_Menu.Error_Clave_Pequeña;
                           Limpiar_Pantalla;
                           Adastegano_Menu.Menu_Cifrado_Clave;
                        elsif C=Intro and Ind_Clave>=
                              Longitud_Minima_Clave then
                           -- Cifrar/confirmar Clave

                           Limpiar_Pantalla;
                           Adastegano_Menu.Menu_Cifrado_Confirmar_Clave;
                           while not Continuar loop
                              Ind_Clave2:=0;
                              Coger_Caracter(C);
                              while C/=Esc and C/=Intro  loop
                                 if Ind_Clave2<
                                       Longitud_Maxima_Clave and
                                       C/=Back then
                                    Put("***");
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
                                 Adastegano_Menu.Menu_Cifrado_Clave;
                              elsif C=Intro then

                                 -- Fin por fin!
                                 if Clave(1..Ind_Clave)=
                                       Clave2(1..Ind_Clave2) then
                                    Limpiar_Pantalla;
                                    Menu_Cifrado_Confirmacion_Datos;
                                    Put_Line("Metodo:       " &
                                       Metodo'Img);
                                    Put_Line("Ruta origen:  " &
                                       Origen(1..Ind_Orig));
                                    Put_Line("Ruta destino: " &
                                       Destino(1..Ind_Dest));
                                    if Ind_Cop>0 then
                                       Put_Line(
                                          "Ruta copia:   " &
                                          Copia(1..Ind_Cop));
                                    else
                                       Put_Line(
                                          "Ruta copia:   " &
                                          Destino(1..Ind_Dest));
                                    end if;
                                    Put_Line(
                                       "Clave:        Confirmada" );
                                    New_Line(5);
                                    Coger_Caracter(C);
                                    while C/='s' and C/='S' and
                                          C/=Esc loop
                                       Coger_Caracter(C);
                                    end loop;
                                    if C=Esc then
                                       Continuar:=True;
                                       Limpiar_Pantalla;
                                       Adastegano_Menu.Menu_Cifrado_Clave;
                                    elsif Ind_Cop>0 then
                                       P_Cifrar (
                                          Origen  (1..Ind_Orig),
                                          Destino (1..Ind_Dest),
                                          Copia (1..Ind_Cop),
                                          Metodo,
                                          Clave (1..Ind_Clave)        );
                                       P_Continuar;
                                       raise Salir;
                                    else
                                       P_Cifrar (
                                          Origen  (1..Ind_Orig),
                                          Destino (1..Ind_Dest),
                                          Destino (1..Ind_Dest),
                                          Metodo,
                                          Clave (1..Ind_Clave)        );
                                       P_Continuar;
                                       raise Salir;
                                    end if;
                                 else
                                    Limpiar_Pantalla;
                                    Adastegano_Menu.Error_Clave_Repetida_Diferente;
                                    Limpiar_Pantalla;
                                    Adastegano_Menu.Menu_Cifrado_Confirmar_Clave;
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


            end if;
         end loop;
         Continuar:=False;

      end if;
   end loop;
   Continuar:=False;


end Cifrar;