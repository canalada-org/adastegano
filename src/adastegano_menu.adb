with Ada.Text_Io;
use Ada.Text_Io;

with Pantalla;
use Pantalla;

with Esteganografia;


package body Adastegano_Menu is

   procedure Ayuda is 
      C : Character;  
   begin
      New_Line;
      Put_Line(" --------AdaStegano "&Version&" - Ayuda-------- ");
      Put_Line(" ");
      Put_Line(" adastegano - Programa de esteganografia y criptografia");
      Put_Line("              Permite ocultar y cifrar archivos dentro ");
      Put_Line("               de imagenes. Por el momento solo soporta");
      Put_Line("               mapas de bits de 24 bits por pixel");
      Put_Line("              Un BMP 24bpp puede almacenar otro archivo");
      Put_Line("               de hasta su octava parte de tamaño");
      Put_Line(" ");
      Put_Line(" --Uso: ");
      Put_Line(" adastegano ['help'] [opciones]");
      Put_Line(" ");
      Put_Line(" --Opciones: ");
      Put_Line(
         " 'metodo cifrar/descifrar clave origen destino [copia]'");
      Put_Line(" ");
      Put_Line("Metodo - Especifica el metodo de cifrado");
      Put_Line("        '-c',   -- Metodo cesar");
      Put_Line("        '-s',   -- Metodo Serpent");
      Put_Line(" ");
      Put_Line("Cifrar/descifrar - Especifica que operacion realizar");
      Put_Line("        '-C',   -- Ocultar y cifrar un archivo");
      Put_Line("        '-D',   -- Descifrar un archivo");
      New_Line;
      Put(
         "Presione cualquier tecla para continuar             Pagina 1 de 7");
      Get_Immediate(C);
      Borra_Linea;
      Put_Line("Clave - La clave que desea usar. Debe tener un maximo de");
      Put_Line("         " & Esteganografia.Longitud_Maxima_Clave'Img & " caracteres y un minimo de "
         & Esteganografia.Longitud_Minima_Clave'Img& " caracteres");
      Put_Line("        Para descifrar el archivo oculto sera necesario usar");
      Put_Line("         esta misma clave");
      Put_Line(
         "        Mientras mas longitud tenga la clave, mas segura sera");
      Put_Line(
         "        Recuerde usar mayusculas, numeros y caracteres no ");
      Put_Line("         alfanumericos para aumentar la seguridad");
      Put_Line("        ¡IMPORTANTE! ");
      Put_Line(
         "        Evite las claves faciles de adivinar o que contengan");
      Put_Line(
         "         informacion sobre usted (por ejemplo, apellidos, ");
      Put_Line("         telefonos, fechas de nacimiento, etc) ");
      Put_Line(" ");
      Put_Line(
         "Origen - Ruta del sistema a un archivo. Maximo 255 caracteres");
      Put_Line(
         "         Si ha elegido 'Cifrar', 'Origen' es el archivo a cifrar");
      Put_Line(
         "         Si ha elegido 'Descifrar', 'Origen' es el archivo a ");
      Put_Line(
         "          descifrar. La carpeta de 'Origen' es la ruta donde se");
      Put_Line("          escribira el archivo descifrado");
      New_Line;
      Put_Line("Destino- Si ha elegido 'Cifrar':");
      Put_Line("           Ruta del sistema a un archivo. Maximo 255 caracteres");
      Put_Line("           Es la ruta del archivo donde se ocultara y cifrara");
      Put_Line("            el archivo 'Origen'. Debe ser un archivo soportado");
      Put_Line("            por AdaStegano");
      New_Line;
      Put(
         "Presione cualquier tecla para continuar             Pagina 2 de 7");
      Get_Immediate(C);
      Borra_Linea;
      Put_Line("         Si ha elegido 'Descifrar':");
      Put_Line("           '-b': El archivo descifrado se guarda con la ruta ");
      Put_Line("                 y nombre que se uso para cifrarlo y ocultarlo");
      Put_Line("                 Si el archivo ya existe, se sobreescribira");
      Put_Line("           '-r': El archivo descifrado se guarda con la ruta ");
      Put_Line("                 y nombre que se uso para cifrarlo y ocultarlo");
      Put_Line("                 Si el archivo ya existe, se crea con un ");
      Put_Line("                 numero de hasta 255 al final de su ruta.");
      Put_Line("                 Ejemplo: 'datos.dat' ya existe. El archivo se");
      Put_Line("                   crea como 'datos.dat0'. Si 'datos.dat0'");
      Put_Line("                   tambien existe, se crea como 'datos.dat1'");
      Put_Line("                   y asi sucesivamente hasta 'datos.dat255'");
      Put_Line("                   Si 'datos.dat255' ya existe, se guarda");
      Put_Line("                   definitivamente como 'datos.dat256'");
      Put_Line("                   sobreescribiendolo si ya existe");
      Put_Line("        'ruta': Ruta del sistema a un archivo. Maximo 255 caracteres");
      Put_Line("                El archivo descifrado se guarda con la ruta, ");
      Put_Line("                 nombre y extension definido por el usuario ");
      Put_Line("                 sobreescribiendo el archivo si ya existe ");
      Put_Line(" ");
      New_Line(3);
      Put("Presione cualquier tecla para continuar             Pagina 3 de 7");
      Get_Immediate(C);
      Borra_Linea;
      Put_Line(
         "Copia- Ruta del sistema a un archivo. Maximo 255 caracteres");
      Put_Line("         Solo se usa si ha elegido 'Cifrar'");
      Put_Line(
         "         Es la ruta del archivo donde se guardara la copia de");
      Put_Line(
         "          la imagen 'Destino' con el archivo 'Origen' ocultado");
      Put_Line(
         "         Este sera el archivo a descifrar para obtener de nuevo ");
      Put_Line("          el archivo 'Origen'");
      Put_Line(
         "         Si la ruta 'Copia' no existe, se creara. Sino se sobreescribira ");
      Put_Line(
         "         Si 'Copia'='Destino' o 'Copia' = '-m', no se guardara una ");
      Put_Line(
         "          copia, sino que se guardara directamente en el archivo 'Destino'");
      New_Line(4);
      Put("Presione cualquier tecla para continuar             Pagina 4 de 7");
      Get_Immediate(C);
      Borra_Linea;
      Put_Line("--Ejemplos:");
      Put_Line(" ");
      Put_Line("   adastegano help");
      Put_Line("          Muestra el texto de ayuda");
      Put_Line(" ");
      Put_Line("   adastegano -c -C +d2d2dfrent informe.pdf C:\playa.bmp");
      Put_Line(
         "          Se ocultara el archivo 'informe.pdf' en la imagen 'playa.bmp'");
      Put_Line(
         "           usando un cifrado Cesar, con clave '+d2d2dfrent'");
      Put_Line(
         "          Como el argumento 'Copia' es vacio, no se hara una copia de ");
      Put_Line(
         "           'playa.bmp' con el archivo oculto, sino que se sobreescribira");
      Put_Line(" ");
      Put_Line("   adastegano -s -D contraseña C:\oculto.bmp -b");
      Put_Line(
         "          Se descifrara el archivo oculto.bmp'. Si contiene algun archivo ");
      Put_Line(
         "           oculto cifrado con Serpent y clave 'contraseña', este se creara ");
      Put_Line("           en 'C:\' sobreescribiendo al anterior si existe");
      Put_Line(" ");
      Put_Line("--Nota:");
      Put_Line(
         " Recuerde que las rutas pueden ser tanto absolutas como relativas");
      Put_Line(
         " Asegurese al descifrar un archivo que tiene permisos de escritura");
      Put_Line("  en esa carpeta");
      New_Line(3);
      Put(
         "Presione cualquier tecla para continuar             Pagina 5 de 7");
      Get_Immediate(C);
      Borra_Linea;
      Put_Line("   adastegano -s -D bkz8Ma1D-3.Ha C:\oculto.bmp -r");
      Put_Line(
         "          Se descifrara el archivo oculto.bmp'. Si contiene algun archivo ");
      Put_Line(
         "           oculto cifrado con Serpent y clave 'bkz8Ma1D-3.Ha', este se creara ");
      Put_Line("           en 'C:\'. Si existe un archivo del mismo nombre, por ejemplo");
      Put_Line("           'datos.pdf', se creara como 'datos.pdf0'");
      New_Line(2);
      Put_Line("   adastegano -c -D password C:\oculto.bmp D:\Documentos\Informe.pdf");
      Put_Line(
         "          Se descifrara el archivo oculto.bmp'. Si contiene algun archivo ");
      Put_Line("           oculto cifrado con Cesar y clave 'password', este se creara ");
      Put_Line("           en 'D:\Documentos\Informe.pdf', independientemente de que tipo");
      Put_Line("           de archivo sea en realidad");
      New_Line(2);
      Put_Line("   adastegano -c -D password C:\oculto.bmp Informe.pdf");
      Put_Line(
         "          Se descifrara el archivo oculto.bmp'. Si contiene algun archivo ");
      Put_Line("           oculto cifrado con Cesar y clave 'password', este se creara ");
      Put_Line("           en 'C:\Informe.pdf', independientemente de que tipo");
      Put_Line("           de archivo sea en realidad");
      New_Line(3);
      Put(
         "Presione cualquier tecla para continuar             Pagina 6 de 7");
      Get_Immediate(C);
      Borra_Linea;
      Put_Line("   --------AdaStegano "&Version&" - Licencia-------- ");
      New_Line;
      Put_Line("Este programa es software libre. Puede redistribuirlo y/o modificarlo");
      Put_Line(" bajo los terminos de la Licencia Publica General de GNU (GPL) publicada por");
      Put_Line(" la Free Software Foundation, version 2 de dicha Licencia o posterior");
      New_Line;
      Put_Line("Este programa se distribuye con la esperanza de que sea util, pero ");
      Put_Line(" SIN NINGUNA GARANTIA, incluso sin la garantia MERCANTIL implicita o");
      Put_Line(" sin garantizar la CONVENIENCIA PARA UN PROPOSITO PARTICULAR. ");
      Put_Line(" Vease la Licencia Publica General (GPL) de GNU para mas detalles.");
      New_Line(4);
      Put_Line("AdaStegano " & Version & ", Copyright (C) 2005, Andres Soliño Klega");
      Put_Line("AdaStegano no ofrece ABSOLUTAMENTE NINGUNA GARANTiA");
      New_Line(7);
      Put("Presione cualquier tecla para continuar             Pagina 7 de 7");
      Get_Immediate(C);
      Borra_Linea;


      --Limpiar_Pantalla;
   end Ayuda;



   procedure Menu_Principal is 
   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&" - Menu Principal----- ");
      Put_Line(" ");
      Put_Line("Elija la opcion que desea realizar; ");
      Put_Line(
         "P.e. para realizar la accion numero 1, presione la tecla '1'");
      Put_Line(
         "Si hay una letra entre parentesis, tambien puede seleccionar");
      Put_Line(" esa opcion presionando la tecla correspondiente");
      Put_Line(" ");
      Put_Line("  1 (c) - Cifrar un archivo y ocultarlo en otro");
      Put_Line("  2 (d) - Descifrar un archivo oculto en otro");
      Put_Line("");
      Put_Line("  0 (ESC) - Salir");
      New_Line(11);
   end Menu_Principal;


   procedure Menu_Cifrado_Metodo is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Cifrar y ocultar archivo (1/7)---- ");
      Put_Line(" ");
      Put_Line("Ha seleccionado la opcion: ");
      Put_Line(" - Cifrar un archivo y ocultarlo en otro");
      Put_Line(" ");
      Put_Line("Elija el metodo de cifrado:");
      Put_Line(
         "P.e. para realizar la accion numero 1, presione la tecla '1'");
      Put_Line(
         "Si hay una letra entre parentesis, tambien puede seleccionar");
      Put_Line(" esa opcion presionando la tecla correspondiente");
      Put_Line(" ");
      Put_Line("  1 (c) - Metodo Cesar");
      Put_Line("  2 (s) - Metodo Serpent");
      Put_Line("");
      Put_Line("  0 (ESC) - Volver atras");
      New_Line(8);
   end Menu_Cifrado_Metodo;


   procedure Menu_Cifrado_Ruta_Origen is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Cifrar y ocultar archivo (2/7)---- ");
      Put_Line(" ");
      Put_Line("Elija el fichero a ocultar:");
      New_Line;
      Put_Line("Para ello, escriba la ruta del archivo (maximo" &
         Esteganografia.Longitud_Maxima_Ruta'Img &")");
      Put_Line("Puede usar tanto rutas absolutas como relativas");
      Put_Line("Las rutas relativas se toman como si el archivo");
      Put_Line(" se encontrase en la misma carpeta de Adastegano");
      Put_Line("Si no es asi, use una ruta absoluta");
      Put_Line("P.e: '/home/usuario/archivo.txt' o ");
      Put_Line("     'C:\Documentos\archivo.txt");
      Put_Line("      son rutas absolutas; ");
      Put_Line("   'archivo.txt' es una ruta relativa");
      New_Line(9);
   end Menu_Cifrado_Ruta_Origen;


   procedure Menu_Cifrado_Ruta_Destino is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Cifrar y ocultar archivo (3/7)---- ");
      Put_Line(" ");
      Put_Line("Elija el fichero donde ocultar los datos:");
      New_Line;
      Put_Line("Para ello, escriba la ruta del archivo (maximo" &
         Esteganografia.Longitud_Maxima_Ruta'Img &")");
      Put_Line("Puede usar tanto rutas absolutas como relativas");
      Put_Line("Las rutas relativas se toman como si el archivo");
      Put_Line(" se encontrase en la misma carpeta de Adastegano");
      Put_Line("Si no es asi, use una ruta absoluta");
      Put_Line("P.e: '/home/usuario/imagen.bmp' o ");
      Put_Line("     'C:\Documentos\imagen.bmp");
      Put_Line("      son rutas absolutas; ");
      Put_Line("   'imagen.bmp' es una ruta relativa");
      New_Line;
      Put_Line("Recuerde que de momento AdaStegano solo soporta");
      Put_Line("mapas de bits de 24 bits por pixel sin compresion");
      New_Line(6);
   end Menu_Cifrado_Ruta_Destino;


   procedure Menu_Cifrado_Ruta_Copia is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Cifrar y ocultar archivo (4/7)---- ");
      Put_Line(" ");
      Put_Line("Elija el nombre del fichero resultante");
      New_Line;
      Put_Line("Para ello, escriba la ruta del archivo (maximo" &
         Esteganografia.Longitud_Maxima_Ruta'Img &")");
      Put_Line("Puede usar tanto rutas absolutas como relativas");
      Put_Line("Las rutas relativas se toman como si el archivo");
      Put_Line(" se encontrase en la misma carpeta de Adastegano");
      Put_Line("Si no es asi, use una ruta absoluta");
      Put_Line("P.e: '/home/usuario/copia.bmp' o ");
      Put_Line("     'C:\Documentos\copia.bmp");
      Put_Line("      son rutas absolutas; ");
      Put_Line("   copia.bmp' es una ruta relativa");
      New_Line;
      Put_Line("Si el fichero existe, sera sobreescrito");
      Put_Line("Si la ruta se deja vacia o tiene el mismo nombre que");
      Put_Line(" el fichero donde se ocultara la informacion, no se hara");
      Put_Line(" ninguna copia y se sobreescribira la imagen");
      New_Line(4);
   end Menu_Cifrado_Ruta_Copia;


   procedure Menu_Cifrado_Clave is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Cifrar y ocultar archivo (5/7)---- ");
      Put_Line(" ");
      Put_Line("Elija la clave de seguridad");
      New_Line;
      Put_Line("Escriba una contraseña de entre" & Esteganografia.Longitud_Minima_Clave'
         Img & " y" & Esteganografia.Longitud_Maxima_Clave'Img&" caracteres");
      Put_Line(
         "Necesitara esta contraseña para descifrar y obtener de nuevo");
      Put_Line(
         " el archivo original. Por lo tanto ¡No pierda esta clave!");
      New_Line;
      Put_Line("Consejos:");
      Put_Line(
         "- Use mayusculas, numeros, guiones, puntos, etc. No se limite ");
      Put_Line("  a letras del alfabeto en minusculas ");
      Put_Line(
         "- Ponga una clave dificil de adivinar y sin informacion sobre ");
      Put_Line("  usted. Evite fechas, telefonos, apellidos, etc. ");
      Put_Line("- Mientras mas larga sea la clave, mejor");
      New_Line(8);
   end Menu_Cifrado_Clave ;

   procedure Menu_Cifrado_Confirmar_Clave is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Cifrar y ocultar archivo (6/7)---- ");
      Put_Line(" ");
      Put_Line("Confirmacion de clave");
      New_Line;
      Put_Line("Por favor, repita la contraseña para asegurar que no");
      Put_Line(" se ha equivocado");
      New_Line(16);
   end Menu_Cifrado_Confirmar_Clave ;





   procedure Menu_Cifrado_Confirmacion_Datos is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Confirmar datos (7/7)---- ");
      Put_Line(" ");
      Put_Line("A continuacion se resumen los datos introducidos");
      New_Line;
      Put_Line("Si ve algun error, presione ESC para volver a los");
      Put_Line(" menus anteriores y corregir los datos");
      Put_Line("Si todo es correcto y quiere comenzar el proceso");
      Put_Line(" presione 's'");
      New_Line(4);
   end Menu_Cifrado_Confirmacion_Datos ;

   -------------------------

   procedure Menu_Descifrado_Metodo is 
   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Descifrar y restaurar archivo (1/5)---- ");
      Put_Line(" ");
      Put_Line("Ha seleccionado la opcion: ");
      Put_Line(" - Descifrar un archivo y restaurarlo");
      Put_Line(" ");
      Put_Line("Elija el metodo de descifrado:");
      Put_Line(
         "P.e. para realizar la accion numero 1, presione la tecla '1'");
      Put_Line(
         "Si hay una letra entre parentesis, tambien puede seleccionar");
      Put_Line(" esa opcion presionando la tecla correspondiente");
      Put_Line(" ");
      Put_Line("  1 (c) - Metodo Cesar");
      Put_Line("  2 (s) - Metodo Serpent");
      Put_Line("");
      Put_Line("  0 (ESC) - Volver atras");
      New_Line(8);
   end Menu_Descifrado_Metodo;


   procedure Menu_Descifrado_Ruta_Origen is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Descifrar y restaurar archivo (2/5)---- ");
      Put_Line(" ");
      Put_Line("Elija el fichero que contenga el archivo oculto:");
      New_Line;
      Put_Line("Para ello, escriba la ruta del fichero (maximo" &
         Esteganografia.Longitud_Maxima_Ruta'Img &")");
      Put_Line("Puede usar tanto rutas absolutas como relativas");
      Put_Line("Las rutas relativas se toman como si el archivo");
      Put_Line(" se encontrase en la misma carpeta de Adastegano");
      Put_Line("Si no es asi, use una ruta absoluta");
      Put_Line("P.e: '/home/usuario/archivo.bmp' o ");
      Put_Line("     'C:\Documentos\archivo.bmp");
      Put_Line("      son rutas absolutas; ");
      Put_Line("   'archivo.bmp' es una ruta relativa");
      New_Line(9);
   end Menu_Descifrado_Ruta_Origen;

   procedure Menu_Descifrado_Clave is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Descifrar y restaurar archivo (3/5)---- ");
      Put_Line(" ");
      Put_Line("Introduzca la clave de seguridad");
      New_Line;
      Put_Line("Escriba una contraseña de entre" & Esteganografia.Longitud_Minima_Clave'
         Img & " y" & Esteganografia.Longitud_Maxima_Clave'Img&" caracteres");
      Put_Line(
         "Use la misma contraseña que introdujo al cifrar y ocultar el archivo");
      Put_Line(
         "Si la contraseña es diferente, no podrá restaurar el archivo oculto");
      New_Line;
      Put_Line("Recuerde:");
      Put_Line(
         "- AdaStegano diferencia entre minusculas y mayusculas");
      Put_Line(
         "- Si ha perdido la clave, no podra recuperar el archivo oculto");
      New_Line(11);
   end Menu_Descifrado_Clave ;


   procedure Menu_Descifrado_Confirmar_Clave is 
   begin

      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Descifrar y restaurar archivo (4/5)---- ");
      Put_Line(" ");
      Put_Line("Confirmacion de clave");
      New_Line;
      Put_Line("Por favor, repita la contraseña para asegurar que no");
      Put_Line(" se ha equivocado");
      New_Line(16);
   end Menu_Descifrado_Confirmar_Clave ;


   procedure Menu_Descifrado_Confirmacion_Datos is 

   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Descifrar y restaurar archivo (5/5)---- ");
      Put_Line(" ");
      Put_Line("A continuacion se resumen los datos introducidos");
      New_Line;
      Put_Line("Si ve algun error, presione ESC para volver a los");
      Put_Line(" menus anteriores y corregir los datos");
      Put_Line("Si todo es correcto y quiere comenzar el proceso");
      Put_Line(" presione 's'");
      New_Line(4);
   end Menu_Descifrado_Confirmacion_Datos ;


   -- Confirmacion datos

   procedure Confirmacion_Datos_Metodo (
         S : String ) is 
   begin
      Put_Line("Metodo:       " & S);
   end Confirmacion_Datos_Metodo;

   procedure Confirmacion_Datos_Origen (
         S : String ) is 
   begin
      Put_Line("Ruta origen:  " & S);
   end Confirmacion_Datos_Origen;

   procedure Confirmacion_Datos_Destino (
         S : String ) is 
   begin
      Put_Line("Ruta destino: " & S);
   end Confirmacion_Datos_Destino;

   procedure Confirmacion_Datos_Copia (
         S : String ) is 
   begin
      Put_Line("Ruta copia:   " & S);
   end Confirmacion_Datos_Copia;

   procedure Confirmacion_Datos_Clave (
         S : String ) is 
   begin
      Put_Line("Clave:        " & S );
   end Confirmacion_Datos_Clave;

   -------------------------------------------------------
   procedure Error_Ruta_Invalida is 
      C : Character;  
   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Error al escribir ruta---- ");
      New_Line(3);
      Put_Line(
         "La ruta no es valida y el fichero no existe o esta en uso");
      Put_Line(
         "Asegurese que la ruta del fichero sea correcta o el fichero");
      Put_Line(" no este siendo usado por otra aplicacion");
      New_Line;
      Put_Line("Presione cualquier tecla para volver al menu anterior");
      New_Line(13);
      Get_Immediate(C);
   end Error_Ruta_Invalida;

   procedure Error_Rutas_Iguales is 
      C : Character;  
   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&
         " - Error al escribir rutas---- ");
      New_Line(3);
      Put_Line("No se puede ocultar un fichero dentro de si mismo!");
      Put_Line("Asegurese que la ruta de origen y destino son diferentes");
      New_Line;
      Put_Line("Presione cualquier tecla para volver al menu anterior");
      New_Line(14);
      Get_Immediate(C);
   end Error_Rutas_Iguales;


   procedure Error_Clave_Pequeña is 
      C : Character;  
   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&" - Longitud invalida---- ");
      New_Line(3);
      Put_Line("La contraseña insertada es muy corta");
      Put_Line("Asegurese de que la longitud de la clave es correcta");
      New_Line;
      Put_Line("Presione cualquier tecla para volver al menu anterior");
      New_Line(14);
      Get_Immediate(C);

   end  Error_Clave_Pequeña;


   procedure Error_Clave_Repetida_Diferente is 
      C : Character;  
   begin
      New_Line(2);
      Put_Line(" -----AdaStegano "&Version&" - Clave incorrecta---- ");
      New_Line(3);
      Put_Line("La clave insertada es diferente a la anterior");
      Put_Line("Asegurese de que inserta la clave sin errores");
      New_Line;
      Put_Line("Presione cualquier tecla para volver al menu anterior");
      Put_Line("Recuerde que apretando ESC puede volver a la primera");
      Put_Line(" confirmacion de clave");
      New_Line(12);
      Get_Immediate(C);

   end Error_Clave_Repetida_Diferente;



   ----- 
   procedure Error is 
   begin
      New_Line(3);
      Put_Line("**** ERROR ****");
      New_Line;
   end Error;

   procedure P_Continuar is 
      C : Character;  
   begin
      New_Line(2);
      Put_Line("Pulse una tecla para finalizar");
      Get_Immediate(C);
   end P_Continuar;

   procedure Error_Fatal_Ruta_Invalida (
         A : in     Natural ) is 
   begin
      Error;
      Put_Line("La ruta del archivo no es valida");
      if A=0 then
         P_Continuar;
      else
         New_Line(3);
      end if;
   end Error_Fatal_Ruta_Invalida;



   procedure Error_Fatal_Info_Corrupta (
         A : in     Natural ) is 
   begin
      Error;
      Put_Line("Aparentemente el archivo donde ocultar la informacion");
      Put_Line(" es de un tipo valido, sin embargo su informacion interna");
      Put_Line(" esta corrupta o es incorrecta");
      if A=0 then
         P_Continuar;
      else
         New_Line(3);
      end if;
   end Error_Fatal_Info_Corrupta ;



   procedure Error_Fatal_Longitud_Incorrecta (
         A : in     Natural ) is 
   begin
      Error;
      Put_Line("La clave introducida no tiene una longitud correcta");
      Put_Line("Debe tener un maximo de " & Esteganografia.Longitud_Maxima_Clave'Img & " caracteres y un minimo de "
         & Esteganografia.Longitud_Minima_Clave'Img& " caracteres");
      if A=0 then
         P_Continuar;
      else
         New_Line(3);
      end if;
   end Error_Fatal_Longitud_Incorrecta ;

   procedure Error_Fatal_Archivo_Invalido_Ocult (
         A : in     Natural ) is 
   begin
      Error;
      Put_Line("El archivo elegido para ocultar la informacion no esta");
      Put_Line(" soportado por AdaStegano");
      if A=0 then
         P_Continuar;
      else
         New_Line(3);
      end if;
   end Error_Fatal_Archivo_Invalido_Ocult;

   procedure Error_Fatal_Imposible_Desencriptar (
         A : in     Natural ) is 
   begin
      Error;
      Put_Line("Ha sido imposible desencriptar el archivo elegido con la");
      Put_Line(" clave proporcionada");
      Put_Line("Posibles causas y soluciones:");
      Put_Line(" - La clave no es valida: introduzca la misma clave usada");
      Put_Line("   en el cifrado");
      Put_Line(" - El archivo no tiene informacion oculta: elija un archivo que ");
      Put_Line("   haya sido cifrado por AdaStegano y contenga informacion oculta");
      Put_Line(" - El metodo es incorrecto: pruebe con otro metodo de descifrado");
      if A=0 then
         P_Continuar;
      else
         New_Line(3);
      end if;
   end Error_Fatal_Imposible_Desencriptar ;

   procedure Error_Fatal_Espacio_Insuficiente (
         A : in     Natural ) is 
   begin
      Error;
      Put_Line("El archivo donde ocultar la informacion no tiene suficiente");
      Put_Line(" espacio disponible");
      Put_Line("Elija otro archivo a cifrar mas pequeño o un arcihvo donde ");
      Put_Line(" ocultar la informacion con mas capacidad");
      Put_Line("En las imagenes BMP de 24 bits, elija un archivo con más resolucion");
      if A=0 then
         P_Continuar;
      else
         New_Line(3);
      end if;
   end Error_Fatal_Espacio_Insuficiente ;


   procedure Error_Fatal_Origen_Vacio (
         A : in     Natural ) is 
   begin
      Error;
      Put_Line("El archivo a ocultar esta vacio");
      Put_Line("Para funcionar correctamente, debe tener al menos");
      Put_Line(" un byte");
      Put_Line("No se ha continuado con la operacion");
      if A=0 then
         P_Continuar;
      else
         New_Line(3);
      end if;
   end Error_Fatal_Origen_Vacio ;


   procedure Error_Fatal_Uso_No_Valido (
         A : in     Natural ) is 
   begin
      Error;
      Put_Line("No se ha podido abrir o crear el fichero");
      Put_Line("Asegurese de que el fichero al que accede no ");
      Put_Line(" este abierto por otra aplicacion");
      Put_Line("Si intenta escribir o crear un fichero, asegurese");
      Put_Line(" que tiene permisos para hacerlo");
      Put_Line("No se ha continuado con la operacion");
      if A=0 then
         P_Continuar;
      else
         New_Line(3);
      end if;
   end Error_Fatal_Uso_No_Valido;

   -----

   procedure Error_Argumentos is 
   begin
      New_Line;
      Put_Line("Argumentos no validos");
      Put_Line(
         "Ejecute AdaStegano sin parametros para iniciar un asistente");
      Put_Line(" o ejecute 'adastegano -h' para ver la ayuda");
      New_Line;
   end Error_Argumentos;



end Adastegano_Menu;