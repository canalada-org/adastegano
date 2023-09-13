

package Passwords is

   subtype String16 is String(1..16);


   function Password_Encrypt(Passphrase : in String16;
                             Password : in String16) return String16;

   function Password_Decrypt(Passphrase : in String16;
                             Ciphertext : in String16) return String16;

end Passwords;
