

separate(Adastegano)

procedure Cifrarxcomando is 


begin
   if Get_Subargument(Cifrar,4) = "-m" then
      if Smart_Arguments.Argument_Present(Metodo_Cesar) then

         P_Cifrar(
            Clave=> Get_Subargument(Cifrar,1),
            Metodo       => Cesar,
            Ruta_Origen  =>Get_Subargument(Cifrar,2),
            Ruta_Destino =>Get_Subargument(Cifrar,3),
            Ruta_Copia => Get_Subargument(Cifrar,3));
      elsif Smart_Arguments.Argument_Present(Metodo_Serpent) then

         P_Cifrar(
            Clave=> Get_Subargument(Cifrar,1),
            Metodo       => Serpent,
            Ruta_Origen  =>Get_Subargument(Cifrar,2),
            Ruta_Destino =>Get_Subargument(Cifrar,3),
            Ruta_Copia => Get_Subargument(Cifrar,3));
      end if;
      
   else

if Smart_Arguments.Argument_Present(Metodo_Cesar) then

         P_Cifrar(
            Clave=> Get_Subargument(Cifrar,1),
            Metodo       => Cesar,
            Ruta_Origen  =>Get_Subargument(Cifrar,2),
            Ruta_Destino =>Get_Subargument(Cifrar,3),
            Ruta_Copia => Get_Subargument(Cifrar,4));
      elsif Smart_Arguments.Argument_Present(Metodo_Serpent) then

         P_Cifrar(
            Clave=> Get_Subargument(Cifrar,1),
            Metodo       => Serpent,
            Ruta_Origen  =>Get_Subargument(Cifrar,2),
            Ruta_Destino =>Get_Subargument(Cifrar,3),
            Ruta_Copia => Get_Subargument(Cifrar,4));
      end if;


   end if;
end Cifrarxcomando;