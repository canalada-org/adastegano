with Ada.Numerics.Discrete_Random,Unchecked_Deallocation;

package body D_Orden_Secuencia is

   procedure Libera is 
   new Unchecked_Deallocation(T_Sec,P_Sec);

   package Pseudoaleatorio is new Ada.Numerics.Discrete_Random(Tam);
   use Pseudoaleatorio;

   -- Prec: I es un entero estandard de 32 bits 
   -- Post: La función devuelve una estructura que contiene el orden de las
   --       posiciones generadas aleatoriamente tomando a I como semilla, y 
   --       y su indicador interno apuntando a la primera posición
   function Generador (
         I : Integer ) 
     return T_Secuencia is 
      G        : Generator;  
      Contador : Positive    := 1;  
      Sec      : T_Secuencia;  
      Valor    : Tam;  
   begin
      Sec.P:=Tam'First;
      Sec.S:=new T_Sec;
      for X in 1..Tamaño loop
         Sec.S(X):=0;
      end loop;

      Reset(G,I);

      if Tamaño>1 then
         -- evitamos que tamaño/2 sea 0 y salga del rango de positive

         -- Prec: contador y tamaño/2 son positive; tamaño>1; sec(i)=0 para cualquier 1<=i<=tamaño;
         --       G es un generator de positive entre 1 y tamaño ya inicializado.
         -- Post: contador=tamaño/2; sec(i)=0 para la mitad de los i entre 1<=i<=tamaño;
         --       sec(i)=x para la otra mitad de los i entre 1<=i<=tamaño siendo 1<=x<contador
         while Contador<=Tamaño/2 loop
            Valor:= Random(G);
            if Sec.S(Valor)=0 then
               Sec.S(Valor):=Contador;
               Contador:=Contador+1;
            end if;
         end loop;

      end if;

      -- Completamos lo que falta del array
      for X in 1..Tamaño loop
         if Sec.S(X)=0 then
            Sec.S(X):=Contador;
            Contador:=Contador+1;
         end if;
      end loop;
      return Sec;
   end Generador;


   -- Prec: Sec es una T_Secuencia válida
   -- Post: La información contenida en Sec ha sido totalmente borrada
   procedure Borrar (
         Sec : in out T_Secuencia ) is 
      -- Nota: usar este procedimiento para asegurarse de no dejar rastros 
      -- del orden de posiciones en la memoria
   begin
      Sec.P:=Tam'First;
      for X in 1..Tamaño loop
         Sec.S(X):=0;
      end loop;
      Libera(Sec.S);

   end Borrar;



   -- Prec: A es una T_Secuencia válida. Quedan posiciones por leer en A
   -- Post: Devuelve la posición referida por el indicador interno de A, y 
   --       aumenta éste hacia la siguiente posición   
   -- Prec: A es una T_Secuencia válida. Quedan posiciones por leer en A
   -- Post: Valor es la posición referida por el indicador interno de A, y 
   --       aumenta éste hacia la siguiente posición   
   procedure Siguiente_Posicion (
         A     : in out T_Secuencia; 
         Valor :    out Natural      ) is 
   begin
      Valor:=A.S(A.P);
      -- si salta constraint_error, es que no hay posiciones por leer en A
      A.P:=A.P+1;
   end Siguiente_Posicion;

   -- Prec: A es una T_Secuencia válida
   -- Post: Devuelve 'true' si se pueden seguir leyendo posiciones,
   --       devuelve 'false' si ya no quedan posiciones por leer
   function Fin_Secuencia (
         A : T_Secuencia ) 
     return Boolean is 
   begin
      return A.P=Tamaño+1;
   end Fin_Secuencia;



end D_Orden_Secuencia;