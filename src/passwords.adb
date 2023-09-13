
with Serpent;
use type Serpent.serpent_Key;
with Aes_Cipher;
use Aes_Cipher;

with Ada.Unchecked_Conversion;

package body Passwords is

   function To_Key_Block is new
     Ada.Unchecked_Conversion(String16, Key_Block);

   function To_Cipher_Block is new
     Ada.Unchecked_Conversion(String16, Cipher_Block);

   function To_String16 is new
     Ada.Unchecked_Conversion(Cipher_Block, string16);

   function Key_To_Cipher is new
     Ada.Unchecked_Conversion(Key_Block, Cipher_Block);

   function Password_Encrypt(Passphrase : in String16;
                             Password : in String16) return String32 is

      Key : Serpent.Serpent_Key;
      Keyblock : Key_Block;
      Inblock, OutBlock : Cipher_Block;
   begin
      KeyBlock:= To_Key_Block(Passphrase);
      Inblock := To_Cipher_Block(Password);

      Serpent.New_Key(Key, Key_Block_Variable_Length(Keyblock));
      Serpent.Encrypt(Key, InBlock, OutBlock);

      return To_String(OutBlock);
   end;

   function Password_Decrypt(Passphrase : in String16;
                             Ciphertext : in String32) return String16 is
      Key : Serpent.Serpent_Key;
      Keyblock : Key_Block;
      Inblock, OutBlock : Cipher_Block;
   begin
      Keyblock := To_Key_Block(Passphrase);
      InBlock := Key_To_Cipher(To_Key(Ciphertext));

      Serpent.New_Key(Key, Key_Block_Variable_Length(Keyblock));
      Serpent.Decrypt(Key, InBlock, OutBlock);

      return To_String16(Outblock);
   end;

end Passwords;
