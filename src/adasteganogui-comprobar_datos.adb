separate (Adasteganogui)

procedure Comprobar_Datos is 
   Temp      : String (1 .. Esteganografia.Longitud_Maxima_Clave);  
   Ruta_1,  
   Ruta_2,  
   Ruta_3,  
   Temp1,  
   Temp2,  
   Temp3     : Unbounded_String;  
   Info_Temp,  
   N         : Natural                                            := Campo_Informacion;  
begin

   Ruta_1:=To_Unbounded_String(Get_Text(E_C_Origen));
   Ruta_2:=To_Unbounded_String(Get_Text(E_C_Destino));
   Ruta_3:=To_Unbounded_String(Get_Text(E_D_Origen));

   loop
      Temp1:=To_Unbounded_String(Get_Text(E_C_Origen));
      Temp2:=To_Unbounded_String(Get_Text(E_C_Destino));
      Temp3:=To_Unbounded_String(Get_Text(E_D_Origen));


      if Get_Length(E_Password)>Esteganografia.Longitud_Maxima_Clave then
         Info_Temp:=Campo_Informacion;
         Campo_Informacion:=1; -- La contraseña es demasiado larga
         Show_Error("La contraseña no debe superar los " &
            Esteganografia.Longitud_Maxima_Clave'Img &" caracteres");
         Get_Text(E_Password,Temp,N);
         Set_Text(E_Password,Temp);
         Campo_Informacion:=Info_Temp;

      elsif (Get_Length(E_Password)>0 and Get_Length(E_Rpassword)=0) or Get_Text(E_Password)/=Get_Text(E_Rpassword) then
         Campo_Informacion:=2; -- Confirmar contraseña

      elsif Get_Length(E_Password)<Esteganografia.Longitud_Minima_Clave and Get_Length(E_Password)>0  then
         Campo_Informacion:=1; -- Longitud muy pequeña

      elsif Temp1/=Ruta_1 or Temp2/=Ruta_2 then
         Ruta_1:=Temp1;
         Ruta_2:=Temp2;
         Campo_Informacion:=51; -- Cifrar

      elsif Temp3/=Ruta_3 then
         Ruta_3:=Temp3;
         Campo_Informacion:=52; -- Descifrar

      elsif Campo_Informacion<=50 then
         Campo_Informacion:=0;
      end if;
      delay(0.15); 
   end loop;
end Comprobar_Datos;