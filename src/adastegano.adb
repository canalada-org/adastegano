----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   AdaStegano  is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------

with Smart_Arguments,Esteganografia,Adastegano_Menu,D_Xtras;
use Smart_Arguments,Esteganografia,Adastegano_Menu;

with Ada.Command_Line;


procedure Adastegano is 

   Ayuda,  
   Metodo_Serpent,  
   Metodo_Cesar,  
   Cifrar,  
   Descifrar      : Smart_Arguments.Argument_Type;  

   procedure P_Ayuda is 
   separate;

   procedure P_Cifrar (
         Ruta_Origen  : String;   
         Ruta_Destino : String;   
         Ruta_Copia   : String;   
         Metodo       : T_Metodo; 
         Clave        : String    ) is 
   separate;

   procedure Cifrarxcomando is 
   separate;

   procedure P_Descifrar (
         Ruta_Origen           : String;                          
         Metodo                : T_Metodo;                        
         Clave                 : String;                          
         Usar_Ruta_Alternativa : D_Xtras.Opcion_Alternativa := 0; 
         Ruta_Alternativa      : String                     := "" ) is 
   separate;

   procedure Descifrarxcomando is 
   separate;

   procedure Preguntar is 
   separate;


begin
   Create_Argument(
      Argument    => Ayuda,                         
      Short_Form  => "-h",                          
      Long_Form   => "help",                        
      Required    => False,                         
      Description => "Muestra la ayuda en pantalla");

   Create_Argument(
      Argument                => Metodo_Serpent,                              
      Short_Form              => "-s",                                        
      Long_Form               => "serpent",                                   
      Required                => False,                                       
      Number_Required_Subargs => 0,                                           
      Description             => "Encripta/desencripta con el metodo Serpent");

   Create_Argument(
      Argument                => Metodo_Cesar,                              
      Short_Form              => "-c",                                      
      Long_Form               => "cesar",                                   
      Required                => False,                                     
      Number_Required_Subargs => 0,                                         
      Description             => "Encripta/desencripta con el metodo Cesar");

   Create_Argument(
      Argument                => Cifrar,                            
      Short_Form              => "-C",                              
      Long_Form               => "cifrar",                          
      Required                => False,                             
      Number_Required_Subargs => 4,                                 
      Description             => "Cifrar un archivo dentro de otro");

   Create_Argument(
      Argument                => Descifrar,                                     
      Short_Form              => "-D",                                          
      Long_Form               => "descifrar",                                   
      Required                => False,                                         
      Number_Required_Subargs => 3,                                             
      Description             => "Descifra un archivo contenido dentro de otro");


   if Smart_Arguments.Argument_Present(Ayuda) then
      P_Ayuda;
   elsif Ada.Command_Line.Argument_Count=0 then
      Preguntar;
   elsif not ( Smart_Arguments.Argument_Present(Cifrar) xor
         Smart_Arguments.Argument_Present(Descifrar) ) or
         not ( Smart_Arguments.Argument_Present(Metodo_Cesar) xor
         Smart_Arguments.Argument_Present(Metodo_Serpent) ) or
         not ( Smart_Arguments.Arguments_Valid )
         then
      Error_Argumentos;
   elsif Smart_Arguments.Argument_Present(Cifrar) then
      Cifrarxcomando;
   elsif Smart_Arguments.Argument_Present(Descifrar) then
      Descifrarxcomando;
   end if;

exception
   when Esteganografia.Ruta_No_Valida=>
      Error_Fatal_Ruta_Invalida(Ada.Command_Line.Argument_Count);
      Ada.Command_Line.Set_Exit_Status(Ada.Command_Line.Failure);

   when Esteganografia.Informacion_Interna_Corrupta =>
      Error_Fatal_Info_Corrupta(Ada.Command_Line.Argument_Count);
      Ada.Command_Line.Set_Exit_Status(Ada.Command_Line.Failure);

   when Esteganografia.Longitud_Incorrecta =>
      Error_Fatal_Longitud_Incorrecta(Ada.Command_Line.Argument_Count);
      Ada.Command_Line.Set_Exit_Status(Ada.Command_Line.Failure);

   when Esteganografia.Arc_No_Valido_Ocultacion =>
      Error_Fatal_Archivo_Invalido_Ocult(Ada.Command_Line.Argument_Count);
      Ada.Command_Line.Set_Exit_Status(Ada.Command_Line.Failure);

   when Esteganografia.Imposible_Desencriptar =>
      Error_Fatal_Imposible_Desencriptar(Ada.Command_Line.Argument_Count);
      Ada.Command_Line.Set_Exit_Status(Ada.Command_Line.Failure);

   when Esteganografia.Espacio_Insuficiente =>
      Error_Fatal_Espacio_Insuficiente(Ada.Command_Line.Argument_Count);
      Ada.Command_Line.Set_Exit_Status(Ada.Command_Line.Failure);

   when Esteganografia.Archivo_Origen_Vacio =>
      Error_Fatal_Origen_Vacio(Ada.Command_Line.Argument_Count);
      Ada.Command_Line.Set_Exit_Status(Ada.Command_Line.Failure);

   when Esteganografia.Uso_No_Valido =>
      Error_Fatal_Uso_No_Valido(Ada.Command_Line.Argument_Count);
      Ada.Command_Line.Set_Exit_Status(Ada.Command_Line.Failure);

end Adastegano;