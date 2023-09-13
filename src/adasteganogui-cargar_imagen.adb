separate (Adasteganogui)

procedure Cargar_Imagen is 
   Ruta_1,  
   Temp1,  
   Ruta_2,  
   Temp2        : Unbounded_String;  
   Imagen       : Image_Type;  
   W,  
   H            : Natural;  
   Ratio_Canvas,  
   Ratio_Img    : Float            := Float (H_Prev) / Float (W_Prev);  
begin
   Ruta_1:=To_Unbounded_String(Get_Text(E_C_Destino));
   Ruta_2:=To_Unbounded_String(Get_Text(E_D_Origen));

   loop


      Temp1:=To_Unbounded_String(Get_Text(E_C_Destino));
      Temp2:=To_Unbounded_String(Get_Text(E_D_Origen));

      if Temp1/=Ruta_1 then
         Ruta_1:=(Temp1);
         Imagen:=Image(To_String(Ruta_1));
         if Valid(Imagen) then
            W:=Width(Imagen);
            H:=Height(Imagen);
            Ratio_Img:=Float(H)/Float(W);
            Erase(Recuadro_Dibujo);
            -- Dibujamos la previsualizacion y adaptamos el tamaño y el ratio
            if Ratio_Img=Ratio_Canvas then
               Draw_Image(Recuadro_Dibujo,(0,0),(W_Prev,H_Prev),Imagen);
            elsif Ratio_Img<Ratio_Canvas then
               Draw_Image(Recuadro_Dibujo,(0,Natural(Float(H_Prev)-(Ratio_Img*Float(W_Prev)))/2),W_Prev,Natural(Ratio_Img*Float(W_Prev)),Imagen);
            else
               Draw_Image(Recuadro_Dibujo,(Natural(Float(W_Prev)-(Float(H_Prev)/Ratio_Img))/2,0),Natural(Float(H_Prev)/Ratio_Img),H_Prev,Imagen);
            end if;
         else
            Erase(Recuadro_Dibujo);
         end if;
      elsif Temp2/=Ruta_2 then
         Ruta_2:=Temp2;
         Imagen:=Image(To_String(Ruta_2));
         if Valid(Imagen) then
            W:=Width(Imagen);
            H:=Height(Imagen);
            Ratio_Img:=Float(H)/Float(W);
            Erase(Recuadro_Dibujo);
            -- Dibujamos la previsualizacion y adaptamos el tamaño y el ratio
            if Ratio_Img=Ratio_Canvas then
               Draw_Image(Recuadro_Dibujo,(0,0),(W_Prev,H_Prev),Imagen);
            elsif Ratio_Img<Ratio_Canvas then
               Draw_Image(Recuadro_Dibujo,(0,Natural(Float(H_Prev)-(Ratio_Img*Float(W_Prev)))/2),W_Prev,Natural(Ratio_Img*Float(W_Prev)),Imagen);
            else
               Draw_Image(Recuadro_Dibujo,(Natural(Float(W_Prev)-(Float(H_Prev)/Ratio_Img))/2,0),Natural(Float(H_Prev)/Ratio_Img),H_Prev,Imagen);
            end if;
         else
            Erase(Recuadro_Dibujo);
         end if;

      end if;

      delay(0.5);
   end loop;
end Cargar_Imagen;