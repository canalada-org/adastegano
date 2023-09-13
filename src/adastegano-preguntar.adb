with Ada.Text_Io;
use Ada.Text_Io;

with Pantalla;
use Pantalla;

separate(Adastegano)

procedure Preguntar is 



   Origen,  
   Destino,  
   Copia    : String (1 .. Longitud_Maxima_Ruta);  
   Ind_Orig,  
   Ind_Dest,  
   Ind_Cop  : Natural                            := 0;  

   Clave,  
   Clave2     : String (1 .. Longitud_Maxima_Clave);  
   Ind_Clave,  
   Ind_Clave2 : Natural                             := 0;  

   C         : Character;  
   Continuar : Boolean   := False;  
   Salir     : exception;  

   procedure Cifrar (
         Metodo : in     T_Metodo ) is 
   separate;

   procedure Descifrar (
         Metodo : in     T_Metodo ) is 
   separate;

begin
   Limpiar_Pantalla;
   Adastegano_Menu.Menu_Principal;
   while not Continuar loop

      Coger_Caracter(C);
      if C=Esc or C='0' then
         raise Salir;
      elsif C=Caracter_Cifrado_Num or
            C=Caracter_Cifrado_Min or
            C=Caracter_Cifrado_May then -- Cifrar/Metodo
         Limpiar_Pantalla;
         Adastegano_Menu.Menu_Cifrado_Metodo;
         while not Continuar loop
            Coger_Caracter(C);
            if C=Esc or C='0' then
               Continuar:=True;
               Limpiar_Pantalla;
               Adastegano_Menu.Menu_Principal;
            elsif C=Caracter_Cesar_Num or
                  C=Caracter_Cesar_Min or
                  C=Caracter_Cesar_May then
               -- Cifrar/Cesar/
               Cifrar(Cesar);
            elsif C=Caracter_Serpent_Num or
                  C=Caracter_Serpent_Min or
                  C=Caracter_Serpent_May then
               -- Cifrar/Serpent/
               Cifrar(Serpent);
            end if;
         end loop;
         Continuar:=False;

      elsif C=Caracter_Descifrado_Num or
            C=Caracter_Descifrado_May or
            C=Caracter_Descifrado_min then -- Descifrar/Metodo
         Limpiar_Pantalla;
         Adastegano_Menu.Menu_Descifrado_Metodo;
         while not Continuar loop
            Coger_Caracter(C);
            if C=Esc or C='0' then
               Continuar:=True;
               Limpiar_Pantalla;
               Adastegano_Menu.Menu_Principal;
            elsif C=Caracter_Cesar_Num or
                  C=Caracter_Cesar_Min or
                  C=Caracter_Cesar_May then
               -- Cifrar/Cesar/
               Descifrar(Cesar);
            elsif C=Caracter_Serpent_Num or
                  C=Caracter_Serpent_Min or
                  C=Caracter_Serpent_May then
               -- Cifrar/Serpent/
               Descifrar(Serpent);
            end if;
         end loop;
         Continuar:=False;
      end if;
   end loop;

exception
   when Salir=>
      null;
end Preguntar;