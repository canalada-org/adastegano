separate (Adasteganogui)

procedure Instrucciones is 

   Ven_Instrucciones :          Frame_Type := Frame (560, 450, "AdaSteganoGUI - Esteganografia en Ada", 'Z');  
   Titulo_txt: constant String:="Instrucciones";
   Instrucciones_Txt : constant String     :=
        
        "AdaSteganoGUI permite ocultar un archivo dentro de otro, adem�s de cifrarlo                         "
      & " mediante contrase�a de forma que resulte invisible e ilegible para un tercero                      "
      & "                                                                                                    "
      & "                                                                                             "
      & "� Si desea cifrar y ocultar un archivo, cumplimente los datos necesarios del panel 'Cifrar'         "
      & "       "
      & " * Ruta de Origen: Ruta del archivo a ocultar                                                       " & "                                           "
      & " * Ruta de Destino: Ruta del archivo contenedor que ocultar� el anterior                            " & "                    "
      & " * Guardar Como: Ruta de la copia del archivo contenedor                                            " & "                    "
      & "                 Si desea sobreescribir el archivo de destino, no modifique este campo"
      & "                                                                                                            "
      & "                                                                                                            "
      & "� Si desea revelar y descifrar un archivo, cumplimente los datos necesarios del panel 'Descifrar'  "
      & " * Ruta de Origen: Ruta del archivo contenedor donde est� el fichero oculto                                          "
      & " * Opciones de ruta:                                                                                     "
      & "                                                                        "
      & "'Sobreescribir'- Revela el archivo oculto y lo escribe con su ruta original,                                       "
      & "                                    sobreescribiendo si el archivo ya existe                                       " & "                                       "
      & "'Renombrar'- Revela el archivo oculto y lo escribe con su ruta original,                                           "      
      & "                                      renombrando el archivo si ya existe                                          " & "                                        "
      & "'Guardar como'- Revela el archivo oculto y lo escribe con la ruta introducida                                           "      
      & "                                                                                                         "
      & "                                         "
      & "Independientemente de la opci�n escogida, debe de suministrar una contrase�a y un m�todo de cifrado / descifrado. " 
      & "Si la contrase�a o el m�todo escogido para descifrar no coincide con el que se us� para cifrar, no ser� posible revelar " 
      & "ni guardar el archivo"          ;  

   B_Volver :Button_Type := Button (Ven_Instrucciones, (250, 370), 65, 25, "Volver", 'v'); 
   Titulo   :Label_Type  := Label (Ven_Instrucciones, (200, 10), 380, 25, Titulo_Txt, Left);  
   Texto    :Label_Type  := Label (Ven_Instrucciones, (10, 35), 530, 330, Instrucciones_Txt, Left);  

begin
   Hide(Principal);
   Show(Ven_Instrucciones);
   loop
     case Next_Command is
         when 'Z'=> exit;
         when 'v'=> exit;
         when others=> null;
     end case;
   end loop;     
   Hide(Ven_Instrucciones);
   Show(Principal);

end Instrucciones;