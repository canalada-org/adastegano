package Pantalla is



   -- Funciona como get_immediate pero sin eco, es decir no muestra el caracter 
   procedure Coger_Caracter (
         C :    out Character ); 


   function Intro return Character; 

   function Back return Character; 

   function Esc return Character; 

   procedure Limpiar_Pantalla; 

   procedure Borrar_Caracter; 

   -- Borra la linea 24 de la pantalla
   procedure Borra_Linea; 

   Error_Limpiando_Pantalla : exception;  

end Pantalla;
