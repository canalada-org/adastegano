separate(Adastegano)

procedure Descifrarxcomando is 

   function Convertir (
         S : in     String ) 
     return D_Xtras.Opcion_Alternativa is 
   begin
      if S="-b" then
         return 0;
      elsif S="-r" then
         return 1;
      else
         return 2;
      end if;
   end Convertir;

begin
   if Smart_Arguments.Argument_Present(Metodo_Cesar) then
      P_Descifrar(
         Clave=> Get_Subargument(Descifrar,1),
         Metodo       => Cesar,
         Ruta_Origen  =>Get_Subargument(Descifrar,2),
         Usar_Ruta_Alternativa=> Convertir(Get_Subargument(Descifrar,3)),
         Ruta_Alternativa=> Get_Subargument(Descifrar,3) );
   elsif Smart_Arguments.Argument_Present(Metodo_Serpent) then
      P_Descifrar(
         Clave=> Get_Subargument(Descifrar,1),
         Metodo       => Serpent,
         Ruta_Origen  =>Get_Subargument(Descifrar,2),
         Usar_Ruta_Alternativa=> Convertir(Get_Subargument(Descifrar,3)),
         Ruta_Alternativa=> Get_Subargument(Descifrar,3) );
   end if;

end Descifrarxcomando;
