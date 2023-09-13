with D_Xtras;
use D_Xtras;

separate(Adastegano)

procedure P_Descifrar (
      Ruta_Origen           : String;                          
      Metodo                : T_Metodo;                        
      Clave                 : String;                          
      Usar_Ruta_Alternativa : D_Xtras.Opcion_Alternativa := 0; 
      Ruta_Alternativa      : String                     := "" ) is 


begin
   Esteganografia.Desencriptar (Ruta_Origen,
      Metodo,
      Clave,
      Usar_Ruta_Alternativa,
      Ruta_Alternativa     );

end P_Descifrar;