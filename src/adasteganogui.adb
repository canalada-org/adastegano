----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   AdaSteganoGUI  is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------


with Jewl.Simple_Windows;
use Jewl.Simple_Windows;

with Ada.Text_Io,Ada.Characters.Handling,Ada.Strings.Unbounded;
use Ada.Text_Io,Ada.Characters.Handling,Ada.Strings.Unbounded;

with D_Imagen,Esteganografia;
use D_Imagen,Esteganografia;

procedure Adasteganogui is 
   Principal : Frame_Type := Frame (640, 480, "AdaStegano", 'X');  

   -- Previsualizacion
   Panel_Previsualizacion : Panel_Type  := Panel (Principal, (380, 10), 220, 180, "Previsualizacion");  
   H_Prev                 : Natural     := 135;  
   W_Prev                 : Natural     := 180;  
   Recuadro_Dibujo        : Canvas_Type := Canvas (Panel_Previsualizacion, (20, 25), W_Prev, H_Prev);  


   -- Menu
   Menuarchivo     : Menu_Type     := Menu (Principal, "&Archivo");  
   Menuayuda       : Menu_Type     := Menu (Principal, "A&yuda");  
   Salir           : Menuitem_Type := Menuitem (Menuarchivo, "&Salir", 'S');  
   M_Instrucciones : Menuitem_Type := Menuitem (Menuayuda, "&Instrucciones de uso", 'I');  
   Acercade        : Menuitem_Type := Menuitem (Menuayuda, "&Acerca de", 'A');  

   Explorador_Leer,  
   Explorador_Leer_Soportados : Open_Dialog_Type := Open_Dialog ("Seleccione un archivo");  
   Explorador_Escribir        : Save_Dialog_Type := Save_Dialog ("Guardar como");  

   -- Cifrar
   Panel_Cifrar : Panel_Type := Panel (Principal, (15, 10), 335, 180, "Cifrar");  

   L_C_Origen       : Label_Type   := Label (Panel_Cifrar, (13, 32), 40, 50, "Origen");  
   Mensaje_C_Origen : String       := "Ruta del archivo a cifrar";  
   E_C_Origen       : Editbox_Type := Editbox (Panel_Cifrar, (67, 30), 210, 20, Mensaje_C_Origen);  
   B_C_Origen       : Button_Type  := Button (Panel_Cifrar, (295, 30), 20, 20, "...", 'N');  

   L_C_Destino        : Label_Type   := Label (Panel_Cifrar, (13, 82), 45, 50, "Destino");  
   Mensaje_Contenedor : String       := "Ruta del archivo contenedor";  
   E_C_Destino        : Editbox_Type := Editbox (Panel_Cifrar, (67, 80), 210, 20, Mensaje_Contenedor);  
   B_C_Destino        : Button_Type  := Button (Panel_Cifrar, (295, 80), 20, 20, "...", 'O');  

   L_C_Copia     : Label_Type   := Label (Panel_Cifrar, (13, 123), 45, 50, "Guardar como");  
   Mensaje_Copia : String       := "Ruta del nuevo archivo";  
   E_C_Copia     : Editbox_Type := Editbox (Panel_Cifrar, (67, 130), 210, 20, Mensaje_Copia);  
   B_C_Copia     : Button_Type  := Button (Panel_Cifrar, (295, 130), 20, 20, "...", 'P');  


   -- Descifrar
   Panel_Descifrar : Panel_Type := Panel (Principal, (15, 210), 335, 165, "Descifrar");  

   L_D_Origen : Label_Type   := Label (Panel_Descifrar, (13, 32), 40, 50, "Origen");  
   E_D_Origen : Editbox_Type := Editbox (Panel_Descifrar, (67, 30), 210, 20, Mensaje_Contenedor);  
   B_D_Origen : Button_Type  := Button (Panel_Descifrar, (295, 30), 20, 20, "...", 'Q');  

   R_Sobreescribir : Radiobutton_Type := Radiobutton (Panel_Descifrar, (15, 93), 100, 25, "Sobreescribir");  

   R_Renombrar : Radiobutton_Type := Radiobutton (Panel_Descifrar, (15, 60), 90, 25, "Renombrar", True);  

   R_Guardar_Como : Radiobutton_Type := Radiobutton (Panel_Descifrar, (15, 115), 105, 45, "Guardar como");  

   E_D_Copia : Editbox_Type := Editbox (Panel_Descifrar, (130, 127), 145, 20, Mensaje_Copia);  
   B_D_Copia : Button_Type  := Button (Panel_Descifrar, (295, 127), 20, 20, "...", 'R');  

   -- Botones
   B_Cifrar    : Button_Type := Button (Principal, (395, 215), 85, 25, "Cifrar", 'C');  
   B_Descifrar : Button_Type := Button (Principal, (505, 215), 85, 25, "Descifrar", 'D');  

   Panel_Otros : Panel_Type    := Panel (Principal, (380, 250), 220, 125);  
   L_Password  : Label_Type    := Label (Panel_Otros, (7, 15), 73, 50, "Contraseña");  
   E_Password  : Editbox_Type  := Editbox (Panel_Otros, (80, 13), 125, 20, "", True);  
   L_Rpassword : Label_Type    := Label (Panel_Otros, (7, 43), 73, 50, "Confirmar contraseña");  
   E_Rpassword : Editbox_Type  := Editbox (Panel_Otros, (80, 50), 125, 20, "", True);  
   L_Mcifrado  : Label_Type    := Label (Panel_Otros, (7, 85), 73, 30, "Metodo de cifrado");  
   C_Metodo    : Combobox_Type := Combobox (Panel_Otros, (80, 88), 125, False);  


   -- Da formato a un string, poniendolo en minusculas con la primera letra en mayúsculas
   function Formato (
         X : in     String ) 
     return String is 
      Y : Unbounded_String;  
   begin
      Y:=To_Unbounded_String(To_Lower(X));
      Replace_Element(Y,1,To_Upper(Element(Y,1)));
      return To_String(Y);
   end Formato;

   Campo_Informacion : Natural := 0;  


   -- Concurrencia --
   procedure Cargar_Imagen is 
   separate;

   procedure Comprobar_Datos is 
   separate;

   procedure Informacion_Adicional is 
   separate;

   task C_Cargar_Imagen;  -- Previsualizamos la imagen
   task body C_Cargar_Imagen is
   begin
      Cargar_Imagen;
   end C_Cargar_Imagen;

   task C_Comprobar_Datos;
   task body C_Comprobar_Datos is
   begin
      Comprobar_Datos;
   end C_Comprobar_Datos;

   task C_Informacion_Adicional;
   task body C_Informacion_Adicional is
   begin
      Informacion_Adicional;
   end C_Informacion_Adicional;


   -- Procedimientos principales :p

   procedure Cifrar is 
   separate;
   procedure Descifrar is 
   separate;

   procedure Instrucciones is 
   separate;

begin
   -- Licencia
   Put_Line("   AdaSteganoGUI v0.1, Copyright (C) 2005 - Andres Soliño Klega");
   New_Line;
   Put_Line("AdaSteganoGUI is a version of AdaStegano with an User Interface developed");
   Put_Line(" 100% in Ada with JEWL libraries.");
   Put_Line("AdaSteganoGUI comes with ABSOLUTELY NO WARRANTY");
   Put_Line("AdaSteganoGUI is free  software, under GNU General Public License v2");
   New_Line(3);


   Show (Principal);

   -- Tipo de archivos aceptados

   --for X in D_Imagen.T_Imagen'First .. D_Imagen.T_Imagen'Last loop
   -- if X/=D_Imagen.Desconocido then
   --    Add_Filter(Explorador_Leer_Soportados,X'Img,"*."&X'Img);
   -- end if;
   --end loop;

   -- Actualmente SOLO soporta BMP
   Add_Filter(Explorador_Leer_Soportados,"Imagenes Bitmap","*.bmp");

   -- Metodos
   for X in Esteganografia.T_Metodo'First .. Esteganografia.T_Metodo'Last loop
      Insert_Line(C_Metodo,Formato(X'Img));
   end loop;


   loop

      case Next_Command is
         when 'N'=>
            if Execute(Explorador_Leer) then
               Set_Text(E_C_Origen ,Get_Name(Explorador_Leer));
            end if;
         when 'O'=>
            if Execute(Explorador_Leer_Soportados) then
               Set_Text(E_C_Destino,Get_Name(Explorador_Leer_Soportados));
            end if;

         when 'P'=>
            if Execute(Explorador_Escribir) then
               Set_Text(E_C_Copia,Get_Name(Explorador_Escribir));
            end if;

         when 'Q'=>
            if Execute(Explorador_Leer_Soportados) then
               Set_Text(E_D_Origen,Get_Name(Explorador_Leer_Soportados));
            end if;

         when 'R'=>
            if Execute(Explorador_Escribir) then
               Set_Text(E_D_Copia,Get_Name(Explorador_Escribir));
               Set_State(R_Guardar_Como,True);
               Set_State(R_Sobreescribir,False);
               Set_State(R_Renombrar,False);
            end if;

         when 'X' =>
            exit;

         when 'S' =>
            exit;

         when 'A' =>
            Show_Message(
               "AdaSteganoGUI, Copyright (C) 2005 - Andres Soliño Klega - Realizado bajo licencia GPL",
               "Acerca de");

         when 'I' =>
            Instrucciones;

         when 'C' => -- Ciframos
            Cifrar;

         when 'D' => -- Desciframos
            Descifrar;

         when others=>
            null;
      end case;
   end loop;

   abort C_Cargar_Imagen;
   abort C_Comprobar_Datos;
   abort C_Informacion_Adicional;

end Adasteganogui;