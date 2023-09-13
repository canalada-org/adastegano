

package Passwords is

   subtype String16 is String(1..16);
   subtype String32 is String(1..32);

   function Password_Encrypt(Passphrase : in String16;
                             Password : in String16) return String32;

   function Password_Decrypt(Passphrase : in String16;
                             Ciphertext : in String32) return String16;

end Passwords;
