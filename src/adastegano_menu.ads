package Adastegano_Menu is

   -- Este paquete tiene la mayor parte de textos a visualizar por pantalla 
   -- de AdaStegano. Para una traducción de AdaStegano, se debe modificar
   -- este paquete!

   Version : String := "v0.2";  

   -- Caracteres de menu
   Caracter_Cifrado_Num : constant Character := '1';  
   Caracter_Cifrado_Min : constant Character := 'c';  
   Caracter_Cifrado_May : constant Character := 'C';  

   Caracter_Descifrado_Num : constant Character := '2';  
   Caracter_Descifrado_Min : constant Character := 'd';  
   Caracter_Descifrado_May : constant Character := 'D';  

   Caracter_Cesar_Num : constant Character := '1';  
   Caracter_Cesar_Min : constant Character := 'c';  
   Caracter_Cesar_May : constant Character := 'C';  

   Caracter_Serpent_Num : constant Character := '2';  
   Caracter_Serpent_Min : constant Character := 's';  
   Caracter_Serpent_May : constant Character := 'S';  

   Caracter_Confirmacion_Min : constant Character := 's';  
   Caracter_Confirmacion_May : constant Character := 'S';  

   String_Contraseña               : constant String := "***";  
   Mensaje_Confirmacion_Contraseña : constant String := "Confirmada";  

   -- Argumentos
   Ayuda_Short_Form  : constant String := "-h";  
   Ayuda_Long_Form   : constant String := "help";  
   Ayuda_Description : constant String := "Muestra la ayuda en pantalla";  

   Serpent_Short_Form  : constant String := "-s";  
   Serpent_Long_Form   : constant String := "serpent";  
   Serpent_Description : constant String := "Encripta/desencripta con el metodo Serpent";  

   Cesar_Short_Form  : constant String := "-c";  
   Cesar_Long_Form   : constant String := "cesar";  
   Cesar_Description : constant String := "Encripta/desencripta con el metodo Cesar";  

   Cifrar_Short_Form  : constant String := "-C";  
   Cifrar_Long_Form   : constant String := "cifrar";  
   Cifrar_Description : constant String := "Cifrar un archivo dentro de otro";  

   Descifrar_Short_Form  : constant String := "-D";  
   Descifrar_Long_Form   : constant String := "descifrar";  
   Descifrar_Description : constant String := "Descifra un archivo contenido dentro de otro";  


   -- Muestra la ayuda
   procedure Ayuda; 

   -- Muestra la pantalla inicial
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

   -- Confirmacion datos

   procedure Confirmacion_Datos_Metodo (
         S : String ); 
   procedure Confirmacion_Datos_Origen (
         S : String ); 
   procedure Confirmacion_Datos_Destino (
         S : String ); 
   procedure Confirmacion_Datos_Copia (
         S : String ); 
   procedure Confirmacion_Datos_Clave (
         S : String ); 

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