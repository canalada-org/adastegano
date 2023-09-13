package Adastegano_Menu is


   Version               : String   := "v0.1";  



   procedure Ayuda; 

   procedure Menu_Principal; 

   --Cifrar

   procedure Menu_Cifrado_Metodo; 

   procedure Menu_Cifrado_Ruta_Origen; 

   procedure Menu_Cifrado_Ruta_Destino; 

   procedure Menu_Cifrado_Ruta_Copia; 

   procedure Menu_Cifrado_Clave; 

   procedure Menu_Cifrado_Confirmar_Clave; 

   procedure Menu_Cifrado_Confirmacion_Datos; 

   -- Descifrar

   procedure Menu_Descifrado_Metodo; 

   procedure Menu_Descifrado_Ruta_Origen; 

   procedure Menu_Descifrado_Clave; 

   procedure Menu_Descifrado_Confirmar_Clave; 

   procedure Menu_Descifrado_Confirmacion_Datos; 

   -----

   procedure Error_Ruta_Invalida; 

   procedure Error_Rutas_Iguales; 

   procedure Error_Clave_Pequeña; 

   procedure Error_Clave_Repetida_Diferente; 

   ------ 

   -- Si A = 0, pide presionar una tecla para continuar
   -- Si A/= 0, no pide presionar una tecla para continuar
   procedure Error_Fatal_Ruta_Invalida (
         A : in     Natural ); 

   procedure Error_Fatal_Info_Corrupta (
         A : in     Natural ); 

   procedure Error_Fatal_Longitud_Incorrecta (
         A : in     Natural ); 

   procedure Error_Fatal_Archivo_Invalido_Ocult (
         A : in     Natural ); 

   procedure Error_Fatal_Imposible_Desencriptar (
         A : in     Natural ); 

   procedure Error_Fatal_Espacio_Insuficiente (
         A : in     Natural ); 

   procedure Error_Fatal_Origen_Vacio (
         A : in     Natural ); 

   procedure Error_Fatal_Uso_No_Valido (
         A : in     Natural ); 



   procedure Error_Argumentos; 

   -----
   procedure P_Continuar; 


end Adastegano_Menu;