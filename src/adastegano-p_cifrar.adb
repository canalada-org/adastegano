

separate(Adastegano)

procedure P_Cifrar (
      Ruta_Origen  : String;   
      Ruta_Destino : String;   
      Ruta_Copia   : String;   
      Metodo       : T_Metodo; 
      Clave        : String    ) is 


begin
   Esteganografia.Encriptar (
      Ruta_Origen,
      Ruta_Destino,
      Ruta_Copia,
      Metodo ,
      Clave );

end P_Cifrar;