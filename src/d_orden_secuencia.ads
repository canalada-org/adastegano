-- Licencia de uso: GNU GPL. Detalles en la parte inferior del archivo


generic
   Tamaño : Positive;  
package D_Orden_Secuencia is


   -- T_Secuencia es una estructura que guarda el orden de las posiciones, de
   -- 1 hasta tamaño
   -- Tiene un indicador interno con las posiciones ya leidas y las que quedan por leer
   type T_Secuencia is private; 



   -- Prec: I es un entero estandard de 32 bits 
   -- Post: La función devuelve una estructura que contiene el orden de las
   --       posiciones generadas aleatoriamente tomando a I como semilla, y 
   --       y su indicador interno apuntando a la primera posición
   function Generador (
         I : Integer ) 
     return T_Secuencia; 


   -- Prec: Sec es una T_Secuencia válida
   -- Post: La información contenida en Sec ha sido totalmente borrada
   procedure Borrar (
         Sec : in out T_Secuencia ); 
   -- Nota: usar este procedimiento para asegurarse de no dejar rastros 
   -- del orden de posiciones en la memoria



   -- Prec: A es una T_Secuencia válida. Quedan posiciones por leer en A
   -- Post: Valor es la posición referida por el indicador interno de A, y 
   --       aumenta éste hacia la siguiente posición   
   procedure Siguiente_Posicion (
         A     : in out T_Secuencia; 
         Valor :    out Natural      ); 

   -- Prec: A es una T_Secuencia válida
   -- Post: Devuelve 'true' si se pueden seguir leyendo posiciones,
   --       devuelve 'false' si ya no quedan posiciones por leer
   function Fin_Secuencia (
         A : T_Secuencia ) 
     return Boolean; 


private


   subtype Tam is Positive range 1..Tamaño;

   type T_Sec is array (Tam'First .. Tam'Last) of Natural; 

   type P_Sec is access T_Sec; 
   -- Usamos un puntero para obligar al array a estar
   -- en el heap, en vez del stack (lo que limitaría su tamaño a 50Mb más o menos)

   type T_Secuencia is 
      record 
         S : P_Sec;    -- S es el puntero al array de numeros      
         P : Positive; -- P es el apuntador      
      end record; 

end D_Orden_Secuencia;


--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   It is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html   