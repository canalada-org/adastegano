separate(serpent)
procedure do_encrypt(W : Key_Schedule; R0, R1, R2, R3 : in out Unsigned_32) is
   R4 : Unsigned_32;
begin

      R4  := W(0+0);
      R0  := R0  xor R4 ;
      R4  := W(0+1);
      R1  := R1  xor R4 ;
      R4  := W(0+2);
      R2  := R2  xor R4 ;
      R4  := W(0+3);
      R3  := R3  xor R4 ;



      R3  := R3  xor R0 ;
      R4  := R1 ;
      R1  := R1  and R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R1 ;
      R2  := R2  xor R4 ;
      R4  := -1  xor R4 ;
      R4  := R4  or  R1 ;
      R1  := R1  xor R3 ;
      R1  := R1  xor R4 ;
      R3  := R3  or  R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R3 ;

      --Permutation: 1 4 2 0 3
      --w := R1; x := R4; y := R2; z := R0;


      R1 := Rotate_Left(R1, 13);
      R2 := Rotate_Left(R2, 3);
      R0 := R0 xor R2;     
      R3 := Shift_Left(R1, 3);
      R4 := R4 xor R1;
      R0 := R0 xor R3;
      R4 := R4 xor R2;      
      R0 := Rotate_Left(R0, 7);
      R4 := Rotate_Left(R4, 1);
      R2 := R2 xor R0;
      R3 := Shift_Left(R4, 7);
      R1 := R1 xor R4;
      R2 := R2 xor R3;
      R1 := R1 xor R0;
      R2 := Rotate_Left(R2, 22);
      R1 := Rotate_Left(R1, 5);
     


      R3  := W(4+0);
      R1  := R1  xor R3 ;
      R3  := W(4+1);
      R4  := R4  xor R3 ;
      R3  := W(4+2);
      R2  := R2  xor R3 ;
      R3  := W(4+3);
      R0  := R0  xor R3 ;


      R4  := -1 xor  R4 ;
      R3  := R1 ;
      R1  := R1  xor R4 ;
      R3  := R3  or  R4 ;
      R3  := R3  xor R0 ;
      R0  := R0  and R1 ;
      R2  := R2  xor R3 ;
      R0  := R0  xor R4 ;
      R0  := R0  or  R2 ;
      R1  := R1  xor R3 ;
      R0  := R0  xor R1 ;
      R4  := R4  and R2 ;
      R1  := R1  or  R4 ;
      R4  := R4  xor R3 ;
      R1  := R1  xor R2 ;
      R3  := R3  or  R0 ;
      R1  := R1  xor R3 ;
      R3  := -1  xor  R3 ;
      R4  := R4  xor R0 ;
      R3  := R3  and R2 ;
      R4  := -1  xor  R4 ;
      R3  := R3  xor R1 ;
      R4  := R4  xor R3 ;

      --Permutation: 3 1 2 0 4
      --w := R0 ; x := R4 ; y := R2 ; z := R1 ;




      R0 := Rotate_Left(R0, 13);
      R2 := Rotate_Left(R2, 3);
      R1 := R1 xor R2;     
      R3 := Shift_Left(R0, 3);
      R4 := R4 xor R0;
      R1 := R1 xor R3;
      R4 := R4 xor R2;      
      R1 := Rotate_Left(R1, 7);
      R4 := Rotate_Left(R4, 1);
      R2 := R2 xor R1;
      R3 := Shift_Left(R4, 7);
      R0 := R0 xor R4;
      R2 := R2 xor R3;
      R0 := R0 xor R1;
      R2 := Rotate_Left(R2, 22);
      R0 := Rotate_Left(R0, 5);
     


      R3  := W(8+0);
      R0  := R0  xor R3 ;
      R3  := W(8+1);
      R4  := R4  xor R3 ;
      R3  := W(8+2);
      R2  := R2  xor R3 ;
      R3  := W(8+3);
      R1  := R1  xor R3 ;


      R3  := R0 ;
      R0  := R0  and R2 ;
      R0  := R0  xor R1 ;
      R2  := R2  xor R4 ;
      R2  := R2  xor R0 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R4 ;
      R3  := R3  xor R2 ;
      R4  := R1 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R0 ;
      R0  := R0  and R4 ;
      R3  := R3  xor R0 ;
      R4  := R4  xor R1 ;
      R4  := R4  xor R3 ;
      R3  := -1  xor R3 ;

      --Permutation: 2 3 1 4 0
      -- w := R2 ; x := R1 ; y := R4 ; z := R3 ;

      R2 := Rotate_Left(R2, 13);
      R4 := Rotate_Left(R4, 3);
      R3 := R3 xor R4;     
      R0 := Shift_Left(R2, 3);
      R1 := R1 xor R2;
      R3 := R3 xor R0;
      R1 := R1 xor R4;      
      R3 := Rotate_Left(R3, 7);
      R1 := Rotate_Left(R1, 1);
      R4 := R4 xor R3;
      R0 := Shift_Left(R1, 7);
      R2 := R2 xor R1;
      R4 := R4 xor R0;
      R2 := R2 xor R3;
      R4 := Rotate_Left(R4, 22);
      R2 := Rotate_Left(R2, 5);
     


      R0  := W(12+0);
      R2  := R2  xor R0 ;
      R0  := W(12+1);
      R1  := R1  xor R0 ;
      R0  := W(12+2);
      R4  := R4  xor R0 ;
      R0  := W(12+3);
      R3  := R3  xor R0 ;



      R0  := R2 ;
      R2  := R2  or R3 ;
      R3  := R3  xor R1 ;
      R1  := R1  and R0 ;
      R0  := R0  xor R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R2 ;
      R0  := R0  or  R1 ;
      R3  := R3  xor R0 ;
      R2  := R2  xor R1 ;
      R0  := R0  and R2 ;
      R1  := R1  xor R3 ;
      R0  := R0  xor R4 ;
      R1  := R1  or  R2 ;
      R1  := R1  xor R4 ;
      R2  := R2  xor R3 ;
      R4  := R1 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R2 ;

      --Permutation: 1 2 3 4 0
      --w := R1 ; x := R4 ; y := R3 ; z := R0 ;

      R1 := Rotate_Left(R1, 13);
      R3 := Rotate_Left(R3, 3);
      R0 := R0 xor R3;     
      R2 := Shift_Left(R1, 3);
      R4 := R4 xor R1;
      R0 := R0 xor R2;
      R4 := R4 xor R3;      
      R0 := Rotate_Left(R0, 7);
      R4 := Rotate_Left(R4, 1);
      R3 := R3 xor R0;
      R2 := Shift_Left(R4, 7);
      R1 := R1 xor R4;
      R3 := R3 xor R2;
      R1 := R1 xor R0;
      R3 := Rotate_Left(R3, 22);
      R1 := Rotate_Left(R1, 5);
     


      R2  := W(16+0);
      R1  := R1  xor R2 ;
      R2  := W(16+1);
      R4  := R4  xor R2 ;
      R2  := W(16+2);
      R3  := R3  xor R2 ;
      R2  := W(16+3);
      R0  := R0  xor R2 ;


      R4  := R4  xor R0 ;
      R0  := -1  xor  R0 ;
      R3  := R3  xor R0 ;
      R0  := R0  xor R1 ;
      R2  := R4 ;
      R4  := R4  and R0 ;
      R4  := R4  xor R3 ;
      R2  := R2  xor R0 ;
      R1  := R1  xor R2 ;
      R3  := R3  and R2 ;
      R3  := R3  xor R1 ;
      R1  := R1  and R4 ;
      R0  := R0  xor R1 ;
      R2  := R2  or  R4 ;
      R2  := R2  xor R1 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R3 ;
      R3  := R3  and R0 ;
      R1  := -1  xor R1 ;
      R2  := R2  xor R3 ;

      --Permutation: 1 4 0 3 2
      -- w := R4 ; x := R2 ; y := R1 ; z := R0 ;


      R4 := Rotate_Left(R4, 13);
      R1 := Rotate_Left(R1, 3);
      R0 := R0 xor R1;     
      R3 := Shift_Left(R4, 3);
      R2 := R2 xor R4;
      R0 := R0 xor R3;
      R2 := R2 xor R1;      
      R0 := Rotate_Left(R0, 7);
      R2 := Rotate_Left(R2, 1);
      R1 := R1 xor R0;
      R3 := Shift_Left(R2, 7);
      R4 := R4 xor R2;
      R1 := R1 xor R3;
      R4 := R4 xor R0;
      R1 := Rotate_Left(R1, 22);
      R4 := Rotate_Left(R4, 5);
     


      R3  := W(20+0);
      R4  := R4  xor R3 ;
      R3  := W(20+1);
      R2  := R2  xor R3 ;
      R3  := W(20+2);
      R1  := R1  xor R3 ;
      R3  := W(20+3);
      R0  := R0  xor R3 ;



      R4  := R4  xor R2 ;
      R2  := R2  xor R0 ;
      R0  := -1  xor R0 ;
      R3  := R2 ;
      R2  := R2  and R4 ;
      R1  := R1  xor R0 ;
      R2  := R2  xor R1 ;
      R1  := R1  or  R3 ;
      R3  := R3  xor R0 ;
      R0  := R0  and R2 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R2 ;
      R3  := R3  xor R1 ;
      R1  := R1  xor R4 ;
      R4  := R4  and R0 ;
      R1  := -1  xor R1 ;
      R4  := R4  xor R3 ;
      R3  := R3  or  R0 ;
      R1  := R1  xor R3 ;

      --Permutation: 1 3 0 2 4
      --w := R2 ; x := R0 ; y := R4 ; z := R1 ;


      R2 := Rotate_Left(R2, 13);
      R4 := Rotate_Left(R4, 3);
      R1 := R1 xor R4;     
      R3 := Shift_Left(R2, 3);
      R0 := R0 xor R2;
      R1 := R1 xor R3;
      R0 := R0 xor R4;      
      R1 := Rotate_Left(R1, 7);
      R0 := Rotate_Left(R0, 1);
      R4 := R4 xor R1;
      R3 := Shift_Left(R0, 7);
      R2 := R2 xor R0;
      R4 := R4 xor R3;
      R2 := R2 xor R1;
      R4 := Rotate_Left(R4, 22);
      R2 := Rotate_Left(R2, 5);
     


      R3  := W(24+0);
      R2  := R2  xor R3 ;
      R3  := W(24+1);
      R0  := R0  xor R3 ;
      R3  := W(24+2);
      R4  := R4  xor R3 ;
      R3  := W(24+3);
      R1  := R1  xor R3 ;




      R4  := -1  xor R4 ;
      R3  := R1 ;
      R1  := R1  and R2 ;
      R2  := R2  xor R3 ;
      R1  := R1  xor R4 ;
      R4  := R4  or  R3 ;
      R0  := R0  xor R1 ;
      R4  := R4  xor R2 ;
      R2  := R2  or  R0 ;
      R4  := R4  xor R0 ;
      R3  := R3  xor R2 ;
      R2  := R2  or  R1 ;
      R2  := R2  xor R4 ;
      R3  := R3  xor R1 ;
      R3  := R3  xor R2 ;
      R1  := -1  xor R1 ;
      R4  := R4  and R3 ;
      R4  := R4  xor R1 ;

      --Permutation: 0 1 4 2 3
      --w := R2 ; x := R0 ; y := R3 ; z := R4 ;


      R2 := Rotate_Left(R2, 13);
      R3 := Rotate_Left(R3, 3);
      R4 := R4 xor R3;     
      R1 := Shift_Left(R2, 3);
      R0 := R0 xor R2;
      R4 := R4 xor R1;
      R0 := R0 xor R3;      
      R4 := Rotate_Left(R4, 7);
      R0 := Rotate_Left(R0, 1);
      R3 := R3 xor R4;
      R1 := Shift_Left(R0, 7);
      R2 := R2 xor R0;
      R3 := R3 xor R1;
      R2 := R2 xor R4;
      R3 := Rotate_Left(R3, 22);
      R2 := Rotate_Left(R2, 5);
     


      R1  := W(28+0);
      R2  := R2  xor R1 ;
      R1  := W(28+1);
      R0  := R0  xor R1 ;
      R1  := W(28+2);
      R3  := R3  xor R1 ;
      R1  := W(28+3);
      R4  := R4  xor R1 ;


      R1  := R3 ;
      R3  := R3  and R0 ;
      R3  := R3  xor R4 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R3  := R3  xor R0 ;
      R0  := R0  xor R2 ;
      R2  := R2  or  R1 ;
      R2  := R2  xor R3 ;
      R4  := R4  xor R0 ;
      R3  := R3  xor R4 ;
      R4  := R4  and R2 ;
      R4  := R4  xor R1 ;
      R1  := R1  xor R3 ;
      R3  := R3  and R2 ;
      R1  := -1  xor R1 ;
      R3  := R3  xor R1 ;
      R1  := R1  and R2 ;
      R0  := R0  xor R4 ;
      R1  := R1  xor R0 ;

      --Permutation: 2 4 3 0 1
      --w := R3 ; x := R1 ; y := R4 ; z := R2 ;


      R3 := Rotate_Left(R3, 13);
      R4 := Rotate_Left(R4, 3);
      R2 := R2 xor R4;     
      R0 := Shift_Left(R3, 3);
      R1 := R1 xor R3;
      R2 := R2 xor R0;
      R1 := R1 xor R4;      
      R2 := Rotate_Left(R2, 7);
      R1 := Rotate_Left(R1, 1);
      R4 := R4 xor R2;
      R0 := Shift_Left(R1, 7);
      R3 := R3 xor R1;
      R4 := R4 xor R0;
      R3 := R3 xor R2;
      R4 := Rotate_Left(R4, 22);
      R3 := Rotate_Left(R3, 5);
     


      R0  := W(32+0);
      R3  := R3  xor R0 ;
      R0  := W(32+1);
      R1  := R1  xor R0 ;
      R0  := W(32+2);
      R4  := R4  xor R0 ;
      R0  := W(32+3);
      R2  := R2  xor R0 ;



      R2  := R2  xor R3 ;
      R0  := R1 ;
      R1  := R1  and R2 ;
      R0  := R0  xor R4 ;
      R1  := R1  xor R3 ;
      R3  := R3  or  R2 ;
      R3  := R3  xor R0 ;
      R0  := R0  xor R2 ;
      R2  := R2  xor R4 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R0 ;
      R0  := -1  xor R0 ;
      R0  := R0  or  R1 ;
      R1  := R1  xor R2 ;
      R1  := R1  xor R0 ;
      R2  := R2  or  R3 ;
      R1  := R1  xor R2 ;
      R0  := R0  xor R2 ;

      --Permutation: 1 4 2 0 3
      --w := R1; x := R0; y := R4; z := R3;


      R1 := Rotate_Left(R1, 13);
      R4 := Rotate_Left(R4, 3);
      R3 := R3 xor R4;     
      R2 := Shift_Left(R1, 3);
      R0 := R0 xor R1;
      R3 := R3 xor R2;
      R0 := R0 xor R4;      
      R3 := Rotate_Left(R3, 7);
      R0 := Rotate_Left(R0, 1);
      R4 := R4 xor R3;
      R2 := Shift_Left(R0, 7);
      R1 := R1 xor R0;
      R4 := R4 xor R2;
      R1 := R1 xor R3;
      R4 := Rotate_Left(R4, 22);
      R1 := Rotate_Left(R1, 5);
     


      R2  := W(36+0);
      R1  := R1  xor R2 ;
      R2  := W(36+1);
      R0  := R0  xor R2 ;
      R2  := W(36+2);
      R4  := R4  xor R2 ;
      R2  := W(36+3);
      R3  := R3  xor R2 ;


      R0  := -1 xor  R0 ;
      R2  := R1 ;
      R1  := R1  xor R0 ;
      R2  := R2  or  R0 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R1 ;
      R4  := R4  xor R2 ;
      R3  := R3  xor R0 ;
      R3  := R3  or  R4 ;
      R1  := R1  xor R2 ;
      R3  := R3  xor R1 ;
      R0  := R0  and R4 ;
      R1  := R1  or  R0 ;
      R0  := R0  xor R2 ;
      R1  := R1  xor R4 ;
      R2  := R2  or  R3 ;
      R1  := R1  xor R2 ;
      R2  := -1  xor  R2 ;
      R0  := R0  xor R3 ;
      R2  := R2  and R4 ;
      R0  := -1  xor  R0 ;
      R2  := R2  xor R1 ;
      R0  := R0  xor R2 ;

      --Permutation: 3 1 2 0 4
      --w := R3 ; x := R0 ; y := R4 ; z := R1 ;




      R3 := Rotate_Left(R3, 13);
      R4 := Rotate_Left(R4, 3);
      R1 := R1 xor R4;     
      R2 := Shift_Left(R3, 3);
      R0 := R0 xor R3;
      R1 := R1 xor R2;
      R0 := R0 xor R4;      
      R1 := Rotate_Left(R1, 7);
      R0 := Rotate_Left(R0, 1);
      R4 := R4 xor R1;
      R2 := Shift_Left(R0, 7);
      R3 := R3 xor R0;
      R4 := R4 xor R2;
      R3 := R3 xor R1;
      R4 := Rotate_Left(R4, 22);
      R3 := Rotate_Left(R3, 5);
     


      R2  := W(40+0);
      R3  := R3  xor R2 ;
      R2  := W(40+1);
      R0  := R0  xor R2 ;
      R2  := W(40+2);
      R4  := R4  xor R2 ;
      R2  := W(40+3);
      R1  := R1  xor R2 ;


      R2  := R3 ;
      R3  := R3  and R4 ;
      R3  := R3  xor R1 ;
      R4  := R4  xor R0 ;
      R4  := R4  xor R3 ;
      R1  := R1  or  R2 ;
      R1  := R1  xor R0 ;
      R2  := R2  xor R4 ;
      R0  := R1 ;
      R1  := R1  or  R2 ;
      R1  := R1  xor R3 ;
      R3  := R3  and R0 ;
      R2  := R2  xor R3 ;
      R0  := R0  xor R1 ;
      R0  := R0  xor R2 ;
      R2  := -1  xor R2 ;

      --Permutation: 2 3 1 4 0
      -- w := R4 ; x := R1 ; y := R0 ; z := R2 ;

      R4 := Rotate_Left(R4, 13);
      R0 := Rotate_Left(R0, 3);
      R2 := R2 xor R0;     
      R3 := Shift_Left(R4, 3);
      R1 := R1 xor R4;
      R2 := R2 xor R3;
      R1 := R1 xor R0;      
      R2 := Rotate_Left(R2, 7);
      R1 := Rotate_Left(R1, 1);
      R0 := R0 xor R2;
      R3 := Shift_Left(R1, 7);
      R4 := R4 xor R1;
      R0 := R0 xor R3;
      R4 := R4 xor R2;
      R0 := Rotate_Left(R0, 22);
      R4 := Rotate_Left(R4, 5);
     


      R3  := W(44+0);
      R4  := R4  xor R3 ;
      R3  := W(44+1);
      R1  := R1  xor R3 ;
      R3  := W(44+2);
      R0  := R0  xor R3 ;
      R3  := W(44+3);
      R2  := R2  xor R3 ;



      R3  := R4 ;
      R4  := R4  or R2 ;
      R2  := R2  xor R1 ;
      R1  := R1  and R3 ;
      R3  := R3  xor R0 ;
      R0  := R0  xor R2 ;
      R2  := R2  and R4 ;
      R3  := R3  or  R1 ;
      R2  := R2  xor R3 ;
      R4  := R4  xor R1 ;
      R3  := R3  and R4 ;
      R1  := R1  xor R2 ;
      R3  := R3  xor R0 ;
      R1  := R1  or  R4 ;
      R1  := R1  xor R0 ;
      R4  := R4  xor R2 ;
      R0  := R1 ;
      R1  := R1  or  R2 ;
      R1  := R1  xor R4 ;

      --Permutation: 1 2 3 4 0
      --w := R1 ; x := R0 ; y := R2 ; z := R3 ;

      R1 := Rotate_Left(R1, 13);
      R2 := Rotate_Left(R2, 3);
      R3 := R3 xor R2;     
      R4 := Shift_Left(R1, 3);
      R0 := R0 xor R1;
      R3 := R3 xor R4;
      R0 := R0 xor R2;      
      R3 := Rotate_Left(R3, 7);
      R0 := Rotate_Left(R0, 1);
      R2 := R2 xor R3;
      R4 := Shift_Left(R0, 7);
      R1 := R1 xor R0;
      R2 := R2 xor R4;
      R1 := R1 xor R3;
      R2 := Rotate_Left(R2, 22);
      R1 := Rotate_Left(R1, 5);
     


      R4  := W(48+0);
      R1  := R1  xor R4 ;
      R4  := W(48+1);
      R0  := R0  xor R4 ;
      R4  := W(48+2);
      R2  := R2  xor R4 ;
      R4  := W(48+3);
      R3  := R3  xor R4 ;


      R0  := R0  xor R3 ;
      R3  := -1  xor  R3 ;
      R2  := R2  xor R3 ;
      R3  := R3  xor R1 ;
      R4  := R0 ;
      R0  := R0  and R3 ;
      R0  := R0  xor R2 ;
      R4  := R4  xor R3 ;
      R1  := R1  xor R4 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R1 ;
      R1  := R1  and R0 ;
      R3  := R3  xor R1 ;
      R4  := R4  or  R0 ;
      R4  := R4  xor R1 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R2 ;
      R2  := R2  and R3 ;
      R1  := -1  xor R1 ;
      R4  := R4  xor R2 ;

      --Permutation: 1 4 0 3 2
      -- w := R0 ; x := R4 ; y := R1 ; z := R3 ;


      R0 := Rotate_Left(R0, 13);
      R1 := Rotate_Left(R1, 3);
      R3 := R3 xor R1;     
      R2 := Shift_Left(R0, 3);
      R4 := R4 xor R0;
      R3 := R3 xor R2;
      R4 := R4 xor R1;      
      R3 := Rotate_Left(R3, 7);
      R4 := Rotate_Left(R4, 1);
      R1 := R1 xor R3;
      R2 := Shift_Left(R4, 7);
      R0 := R0 xor R4;
      R1 := R1 xor R2;
      R0 := R0 xor R3;
      R1 := Rotate_Left(R1, 22);
      R0 := Rotate_Left(R0, 5);
     


      R2  := W(52+0);
      R0  := R0  xor R2 ;
      R2  := W(52+1);
      R4  := R4  xor R2 ;
      R2  := W(52+2);
      R1  := R1  xor R2 ;
      R2  := W(52+3);
      R3  := R3  xor R2 ;



      R0  := R0  xor R4 ;
      R4  := R4  xor R3 ;
      R3  := -1  xor R3 ;
      R2  := R4 ;
      R4  := R4  and R0 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R1 ;
      R1  := R1  or  R2 ;
      R2  := R2  xor R3 ;
      R3  := R3  and R4 ;
      R3  := R3  xor R0 ;
      R2  := R2  xor R4 ;
      R2  := R2  xor R1 ;
      R1  := R1  xor R0 ;
      R0  := R0  and R3 ;
      R1  := -1  xor R1 ;
      R0  := R0  xor R2 ;
      R2  := R2  or  R3 ;
      R1  := R1  xor R2 ;

      --Permutation: 1 3 0 2 4
      --w := R4 ; x := R3 ; y := R0 ; z := R1 ;


      R4 := Rotate_Left(R4, 13);
      R0 := Rotate_Left(R0, 3);
      R1 := R1 xor R0;     
      R2 := Shift_Left(R4, 3);
      R3 := R3 xor R4;
      R1 := R1 xor R2;
      R3 := R3 xor R0;      
      R1 := Rotate_Left(R1, 7);
      R3 := Rotate_Left(R3, 1);
      R0 := R0 xor R1;
      R2 := Shift_Left(R3, 7);
      R4 := R4 xor R3;
      R0 := R0 xor R2;
      R4 := R4 xor R1;
      R0 := Rotate_Left(R0, 22);
      R4 := Rotate_Left(R4, 5);
     


      R2  := W(56+0);
      R4  := R4  xor R2 ;
      R2  := W(56+1);
      R3  := R3  xor R2 ;
      R2  := W(56+2);
      R0  := R0  xor R2 ;
      R2  := W(56+3);
      R1  := R1  xor R2 ;




      R0  := -1  xor R0 ;
      R2  := R1 ;
      R1  := R1  and R4 ;
      R4  := R4  xor R2 ;
      R1  := R1  xor R0 ;
      R0  := R0  or  R2 ;
      R3  := R3  xor R1 ;
      R0  := R0  xor R4 ;
      R4  := R4  or  R3 ;
      R0  := R0  xor R3 ;
      R2  := R2  xor R4 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R0 ;
      R2  := R2  xor R1 ;
      R2  := R2  xor R4 ;
      R1  := -1  xor R1 ;
      R0  := R0  and R2 ;
      R0  := R0  xor R1 ;

      --Permutation: 0 1 4 2 3
      --w := R4 ; x := R3 ; y := R2 ; z := R0 ;


      R4 := Rotate_Left(R4, 13);
      R2 := Rotate_Left(R2, 3);
      R0 := R0 xor R2;     
      R1 := Shift_Left(R4, 3);
      R3 := R3 xor R4;
      R0 := R0 xor R1;
      R3 := R3 xor R2;      
      R0 := Rotate_Left(R0, 7);
      R3 := Rotate_Left(R3, 1);
      R2 := R2 xor R0;
      R1 := Shift_Left(R3, 7);
      R4 := R4 xor R3;
      R2 := R2 xor R1;
      R4 := R4 xor R0;
      R2 := Rotate_Left(R2, 22);
      R4 := Rotate_Left(R4, 5);
     


      R1  := W(60+0);
      R4  := R4  xor R1 ;
      R1  := W(60+1);
      R3  := R3  xor R1 ;
      R1  := W(60+2);
      R2  := R2  xor R1 ;
      R1  := W(60+3);
      R0  := R0  xor R1 ;


      R1  := R2 ;
      R2  := R2  and R3 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R3 ;
      R1  := R1  xor R2 ;
      R2  := R2  xor R3 ;
      R3  := R3  xor R4 ;
      R4  := R4  or  R1 ;
      R4  := R4  xor R2 ;
      R0  := R0  xor R3 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R4 ;
      R0  := R0  xor R1 ;
      R1  := R1  xor R2 ;
      R2  := R2  and R4 ;
      R1  := -1  xor R1 ;
      R2  := R2  xor R1 ;
      R1  := R1  and R4 ;
      R3  := R3  xor R0 ;
      R1  := R1  xor R3 ;

      --Permutation: 2 4 3 0 1
      --w := R2 ; x := R1 ; y := R0 ; z := R4 ;


      R2 := Rotate_Left(R2, 13);
      R0 := Rotate_Left(R0, 3);
      R4 := R4 xor R0;     
      R3 := Shift_Left(R2, 3);
      R1 := R1 xor R2;
      R4 := R4 xor R3;
      R1 := R1 xor R0;      
      R4 := Rotate_Left(R4, 7);
      R1 := Rotate_Left(R1, 1);
      R0 := R0 xor R4;
      R3 := Shift_Left(R1, 7);
      R2 := R2 xor R1;
      R0 := R0 xor R3;
      R2 := R2 xor R4;
      R0 := Rotate_Left(R0, 22);
      R2 := Rotate_Left(R2, 5);
     


      R3  := W(64+0);
      R2  := R2  xor R3 ;
      R3  := W(64+1);
      R1  := R1  xor R3 ;
      R3  := W(64+2);
      R0  := R0  xor R3 ;
      R3  := W(64+3);
      R4  := R4  xor R3 ;



      R4  := R4  xor R2 ;
      R3  := R1 ;
      R1  := R1  and R4 ;
      R3  := R3  xor R0 ;
      R1  := R1  xor R2 ;
      R2  := R2  or  R4 ;
      R2  := R2  xor R3 ;
      R3  := R3  xor R4 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R1 ;
      R0  := R0  xor R3 ;
      R3  := -1  xor R3 ;
      R3  := R3  or  R1 ;
      R1  := R1  xor R4 ;
      R1  := R1  xor R3 ;
      R4  := R4  or  R2 ;
      R1  := R1  xor R4 ;
      R3  := R3  xor R4 ;

      --Permutation: 1 4 2 0 3
      --w := R1; x := R3; y := R0; z := R2;


      R1 := Rotate_Left(R1, 13);
      R0 := Rotate_Left(R0, 3);
      R2 := R2 xor R0;     
      R4 := Shift_Left(R1, 3);
      R3 := R3 xor R1;
      R2 := R2 xor R4;
      R3 := R3 xor R0;      
      R2 := Rotate_Left(R2, 7);
      R3 := Rotate_Left(R3, 1);
      R0 := R0 xor R2;
      R4 := Shift_Left(R3, 7);
      R1 := R1 xor R3;
      R0 := R0 xor R4;
      R1 := R1 xor R2;
      R0 := Rotate_Left(R0, 22);
      R1 := Rotate_Left(R1, 5);
     


      R4  := W(68+0);
      R1  := R1  xor R4 ;
      R4  := W(68+1);
      R3  := R3  xor R4 ;
      R4  := W(68+2);
      R0  := R0  xor R4 ;
      R4  := W(68+3);
      R2  := R2  xor R4 ;


      R3  := -1 xor  R3 ;
      R4  := R1 ;
      R1  := R1  xor R3 ;
      R4  := R4  or  R3 ;
      R4  := R4  xor R2 ;
      R2  := R2  and R1 ;
      R0  := R0  xor R4 ;
      R2  := R2  xor R3 ;
      R2  := R2  or  R0 ;
      R1  := R1  xor R4 ;
      R2  := R2  xor R1 ;
      R3  := R3  and R0 ;
      R1  := R1  or  R3 ;
      R3  := R3  xor R4 ;
      R1  := R1  xor R0 ;
      R4  := R4  or  R2 ;
      R1  := R1  xor R4 ;
      R4  := -1  xor  R4 ;
      R3  := R3  xor R2 ;
      R4  := R4  and R0 ;
      R3  := -1  xor  R3 ;
      R4  := R4  xor R1 ;
      R3  := R3  xor R4 ;

      --Permutation: 3 1 2 0 4
      --w := R2 ; x := R3 ; y := R0 ; z := R1 ;




      R2 := Rotate_Left(R2, 13);
      R0 := Rotate_Left(R0, 3);
      R1 := R1 xor R0;     
      R4 := Shift_Left(R2, 3);
      R3 := R3 xor R2;
      R1 := R1 xor R4;
      R3 := R3 xor R0;      
      R1 := Rotate_Left(R1, 7);
      R3 := Rotate_Left(R3, 1);
      R0 := R0 xor R1;
      R4 := Shift_Left(R3, 7);
      R2 := R2 xor R3;
      R0 := R0 xor R4;
      R2 := R2 xor R1;
      R0 := Rotate_Left(R0, 22);
      R2 := Rotate_Left(R2, 5);
     


      R4  := W(72+0);
      R2  := R2  xor R4 ;
      R4  := W(72+1);
      R3  := R3  xor R4 ;
      R4  := W(72+2);
      R0  := R0  xor R4 ;
      R4  := W(72+3);
      R1  := R1  xor R4 ;


      R4  := R2 ;
      R2  := R2  and R0 ;
      R2  := R2  xor R1 ;
      R0  := R0  xor R3 ;
      R0  := R0  xor R2 ;
      R1  := R1  or  R4 ;
      R1  := R1  xor R3 ;
      R4  := R4  xor R0 ;
      R3  := R1 ;
      R1  := R1  or  R4 ;
      R1  := R1  xor R2 ;
      R2  := R2  and R3 ;
      R4  := R4  xor R2 ;
      R3  := R3  xor R1 ;
      R3  := R3  xor R4 ;
      R4  := -1  xor R4 ;

      --Permutation: 2 3 1 4 0
      -- w := R0 ; x := R1 ; y := R3 ; z := R4 ;

      R0 := Rotate_Left(R0, 13);
      R3 := Rotate_Left(R3, 3);
      R4 := R4 xor R3;     
      R2 := Shift_Left(R0, 3);
      R1 := R1 xor R0;
      R4 := R4 xor R2;
      R1 := R1 xor R3;      
      R4 := Rotate_Left(R4, 7);
      R1 := Rotate_Left(R1, 1);
      R3 := R3 xor R4;
      R2 := Shift_Left(R1, 7);
      R0 := R0 xor R1;
      R3 := R3 xor R2;
      R0 := R0 xor R4;
      R3 := Rotate_Left(R3, 22);
      R0 := Rotate_Left(R0, 5);
     


      R2  := W(76+0);
      R0  := R0  xor R2 ;
      R2  := W(76+1);
      R1  := R1  xor R2 ;
      R2  := W(76+2);
      R3  := R3  xor R2 ;
      R2  := W(76+3);
      R4  := R4  xor R2 ;



      R2  := R0 ;
      R0  := R0  or R4 ;
      R4  := R4  xor R1 ;
      R1  := R1  and R2 ;
      R2  := R2  xor R3 ;
      R3  := R3  xor R4 ;
      R4  := R4  and R0 ;
      R2  := R2  or  R1 ;
      R4  := R4  xor R2 ;
      R0  := R0  xor R1 ;
      R2  := R2  and R0 ;
      R1  := R1  xor R4 ;
      R2  := R2  xor R3 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R3 ;
      R0  := R0  xor R4 ;
      R3  := R1 ;
      R1  := R1  or  R4 ;
      R1  := R1  xor R0 ;

      --Permutation: 1 2 3 4 0
      --w := R1 ; x := R3 ; y := R4 ; z := R2 ;

      R1 := Rotate_Left(R1, 13);
      R4 := Rotate_Left(R4, 3);
      R2 := R2 xor R4;     
      R0 := Shift_Left(R1, 3);
      R3 := R3 xor R1;
      R2 := R2 xor R0;
      R3 := R3 xor R4;      
      R2 := Rotate_Left(R2, 7);
      R3 := Rotate_Left(R3, 1);
      R4 := R4 xor R2;
      R0 := Shift_Left(R3, 7);
      R1 := R1 xor R3;
      R4 := R4 xor R0;
      R1 := R1 xor R2;
      R4 := Rotate_Left(R4, 22);
      R1 := Rotate_Left(R1, 5);
     


      R0  := W(80+0);
      R1  := R1  xor R0 ;
      R0  := W(80+1);
      R3  := R3  xor R0 ;
      R0  := W(80+2);
      R4  := R4  xor R0 ;
      R0  := W(80+3);
      R2  := R2  xor R0 ;


      R3  := R3  xor R2 ;
      R2  := -1  xor  R2 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R1 ;
      R0  := R3 ;
      R3  := R3  and R2 ;
      R3  := R3  xor R4 ;
      R0  := R0  xor R2 ;
      R1  := R1  xor R0 ;
      R4  := R4  and R0 ;
      R4  := R4  xor R1 ;
      R1  := R1  and R3 ;
      R2  := R2  xor R1 ;
      R0  := R0  or  R3 ;
      R0  := R0  xor R1 ;
      R1  := R1  or  R2 ;
      R1  := R1  xor R4 ;
      R4  := R4  and R2 ;
      R1  := -1  xor R1 ;
      R0  := R0  xor R4 ;

      --Permutation: 1 4 0 3 2
      -- w := R3 ; x := R0 ; y := R1 ; z := R2 ;


      R3 := Rotate_Left(R3, 13);
      R1 := Rotate_Left(R1, 3);
      R2 := R2 xor R1;     
      R4 := Shift_Left(R3, 3);
      R0 := R0 xor R3;
      R2 := R2 xor R4;
      R0 := R0 xor R1;      
      R2 := Rotate_Left(R2, 7);
      R0 := Rotate_Left(R0, 1);
      R1 := R1 xor R2;
      R4 := Shift_Left(R0, 7);
      R3 := R3 xor R0;
      R1 := R1 xor R4;
      R3 := R3 xor R2;
      R1 := Rotate_Left(R1, 22);
      R3 := Rotate_Left(R3, 5);
     


      R4  := W(84+0);
      R3  := R3  xor R4 ;
      R4  := W(84+1);
      R0  := R0  xor R4 ;
      R4  := W(84+2);
      R1  := R1  xor R4 ;
      R4  := W(84+3);
      R2  := R2  xor R4 ;



      R3  := R3  xor R0 ;
      R0  := R0  xor R2 ;
      R2  := -1  xor R2 ;
      R4  := R0 ;
      R0  := R0  and R3 ;
      R1  := R1  xor R2 ;
      R0  := R0  xor R1 ;
      R1  := R1  or  R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  and R0 ;
      R2  := R2  xor R3 ;
      R4  := R4  xor R0 ;
      R4  := R4  xor R1 ;
      R1  := R1  xor R3 ;
      R3  := R3  and R2 ;
      R1  := -1  xor R1 ;
      R3  := R3  xor R4 ;
      R4  := R4  or  R2 ;
      R1  := R1  xor R4 ;

      --Permutation: 1 3 0 2 4
      --w := R0 ; x := R2 ; y := R3 ; z := R1 ;


      R0 := Rotate_Left(R0, 13);
      R3 := Rotate_Left(R3, 3);
      R1 := R1 xor R3;     
      R4 := Shift_Left(R0, 3);
      R2 := R2 xor R0;
      R1 := R1 xor R4;
      R2 := R2 xor R3;      
      R1 := Rotate_Left(R1, 7);
      R2 := Rotate_Left(R2, 1);
      R3 := R3 xor R1;
      R4 := Shift_Left(R2, 7);
      R0 := R0 xor R2;
      R3 := R3 xor R4;
      R0 := R0 xor R1;
      R3 := Rotate_Left(R3, 22);
      R0 := Rotate_Left(R0, 5);
     


      R4  := W(88+0);
      R0  := R0  xor R4 ;
      R4  := W(88+1);
      R2  := R2  xor R4 ;
      R4  := W(88+2);
      R3  := R3  xor R4 ;
      R4  := W(88+3);
      R1  := R1  xor R4 ;




      R3  := -1  xor R3 ;
      R4  := R1 ;
      R1  := R1  and R0 ;
      R0  := R0  xor R4 ;
      R1  := R1  xor R3 ;
      R3  := R3  or  R4 ;
      R2  := R2  xor R1 ;
      R3  := R3  xor R0 ;
      R0  := R0  or  R2 ;
      R3  := R3  xor R2 ;
      R4  := R4  xor R0 ;
      R0  := R0  or  R1 ;
      R0  := R0  xor R3 ;
      R4  := R4  xor R1 ;
      R4  := R4  xor R0 ;
      R1  := -1  xor R1 ;
      R3  := R3  and R4 ;
      R3  := R3  xor R1 ;

      --Permutation: 0 1 4 2 3
      --w := R0 ; x := R2 ; y := R4 ; z := R3 ;


      R0 := Rotate_Left(R0, 13);
      R4 := Rotate_Left(R4, 3);
      R3 := R3 xor R4;     
      R1 := Shift_Left(R0, 3);
      R2 := R2 xor R0;
      R3 := R3 xor R1;
      R2 := R2 xor R4;      
      R3 := Rotate_Left(R3, 7);
      R2 := Rotate_Left(R2, 1);
      R4 := R4 xor R3;
      R1 := Shift_Left(R2, 7);
      R0 := R0 xor R2;
      R4 := R4 xor R1;
      R0 := R0 xor R3;
      R4 := Rotate_Left(R4, 22);
      R0 := Rotate_Left(R0, 5);
     


      R1  := W(92+0);
      R0  := R0  xor R1 ;
      R1  := W(92+1);
      R2  := R2  xor R1 ;
      R1  := W(92+2);
      R4  := R4  xor R1 ;
      R1  := W(92+3);
      R3  := R3  xor R1 ;


      R1  := R4 ;
      R4  := R4  and R2 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R2 ;
      R1  := R1  xor R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R0 ;
      R0  := R0  or  R1 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R2 ;
      R4  := R4  xor R3 ;
      R3  := R3  and R0 ;
      R3  := R3  xor R1 ;
      R1  := R1  xor R4 ;
      R4  := R4  and R0 ;
      R1  := -1  xor R1 ;
      R4  := R4  xor R1 ;
      R1  := R1  and R0 ;
      R2  := R2  xor R3 ;
      R1  := R1  xor R2 ;

      --Permutation: 2 4 3 0 1
      --w := R4 ; x := R1 ; y := R3 ; z := R0 ;


      R4 := Rotate_Left(R4, 13);
      R3 := Rotate_Left(R3, 3);
      R0 := R0 xor R3;     
      R2 := Shift_Left(R4, 3);
      R1 := R1 xor R4;
      R0 := R0 xor R2;
      R1 := R1 xor R3;      
      R0 := Rotate_Left(R0, 7);
      R1 := Rotate_Left(R1, 1);
      R3 := R3 xor R0;
      R2 := Shift_Left(R1, 7);
      R4 := R4 xor R1;
      R3 := R3 xor R2;
      R4 := R4 xor R0;
      R3 := Rotate_Left(R3, 22);
      R4 := Rotate_Left(R4, 5);
     


      R2  := W(96+0);
      R4  := R4  xor R2 ;
      R2  := W(96+1);
      R1  := R1  xor R2 ;
      R2  := W(96+2);
      R3  := R3  xor R2 ;
      R2  := W(96+3);
      R0  := R0  xor R2 ;



      R0  := R0  xor R4 ;
      R2  := R1 ;
      R1  := R1  and R0 ;
      R2  := R2  xor R3 ;
      R1  := R1  xor R4 ;
      R4  := R4  or  R0 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R0 ;
      R0  := R0  xor R3 ;
      R3  := R3  or  R1 ;
      R3  := R3  xor R2 ;
      R2  := -1  xor R2 ;
      R2  := R2  or  R1 ;
      R1  := R1  xor R0 ;
      R1  := R1  xor R2 ;
      R0  := R0  or  R4 ;
      R1  := R1  xor R0 ;
      R2  := R2  xor R0 ;

      --Permutation: 1 4 2 0 3
      --w := R1; x := R2; y := R3; z := R4;


      R1 := Rotate_Left(R1, 13);
      R3 := Rotate_Left(R3, 3);
      R4 := R4 xor R3;     
      R0 := Shift_Left(R1, 3);
      R2 := R2 xor R1;
      R4 := R4 xor R0;
      R2 := R2 xor R3;      
      R4 := Rotate_Left(R4, 7);
      R2 := Rotate_Left(R2, 1);
      R3 := R3 xor R4;
      R0 := Shift_Left(R2, 7);
      R1 := R1 xor R2;
      R3 := R3 xor R0;
      R1 := R1 xor R4;
      R3 := Rotate_Left(R3, 22);
      R1 := Rotate_Left(R1, 5);
     


      R0  := W(100+0);
      R1  := R1  xor R0 ;
      R0  := W(100+1);
      R2  := R2  xor R0 ;
      R0  := W(100+2);
      R3  := R3  xor R0 ;
      R0  := W(100+3);
      R4  := R4  xor R0 ;


      R2  := -1 xor  R2 ;
      R0  := R1 ;
      R1  := R1  xor R2 ;
      R0  := R0  or  R2 ;
      R0  := R0  xor R4 ;
      R4  := R4  and R1 ;
      R3  := R3  xor R0 ;
      R4  := R4  xor R2 ;
      R4  := R4  or  R3 ;
      R1  := R1  xor R0 ;
      R4  := R4  xor R1 ;
      R2  := R2  and R3 ;
      R1  := R1  or  R2 ;
      R2  := R2  xor R0 ;
      R1  := R1  xor R3 ;
      R0  := R0  or  R4 ;
      R1  := R1  xor R0 ;
      R0  := -1  xor  R0 ;
      R2  := R2  xor R4 ;
      R0  := R0  and R3 ;
      R2  := -1  xor  R2 ;
      R0  := R0  xor R1 ;
      R2  := R2  xor R0 ;

      --Permutation: 3 1 2 0 4
      --w := R4 ; x := R2 ; y := R3 ; z := R1 ;




      R4 := Rotate_Left(R4, 13);
      R3 := Rotate_Left(R3, 3);
      R1 := R1 xor R3;     
      R0 := Shift_Left(R4, 3);
      R2 := R2 xor R4;
      R1 := R1 xor R0;
      R2 := R2 xor R3;      
      R1 := Rotate_Left(R1, 7);
      R2 := Rotate_Left(R2, 1);
      R3 := R3 xor R1;
      R0 := Shift_Left(R2, 7);
      R4 := R4 xor R2;
      R3 := R3 xor R0;
      R4 := R4 xor R1;
      R3 := Rotate_Left(R3, 22);
      R4 := Rotate_Left(R4, 5);
     


      R0  := W(104+0);
      R4  := R4  xor R0 ;
      R0  := W(104+1);
      R2  := R2  xor R0 ;
      R0  := W(104+2);
      R3  := R3  xor R0 ;
      R0  := W(104+3);
      R1  := R1  xor R0 ;


      R0  := R4 ;
      R4  := R4  and R3 ;
      R4  := R4  xor R1 ;
      R3  := R3  xor R2 ;
      R3  := R3  xor R4 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R2 ;
      R0  := R0  xor R3 ;
      R2  := R1 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R4 ;
      R4  := R4  and R2 ;
      R0  := R0  xor R4 ;
      R2  := R2  xor R1 ;
      R2  := R2  xor R0 ;
      R0  := -1  xor R0 ;

      --Permutation: 2 3 1 4 0
      -- w := R3 ; x := R1 ; y := R2 ; z := R0 ;

      R3 := Rotate_Left(R3, 13);
      R2 := Rotate_Left(R2, 3);
      R0 := R0 xor R2;     
      R4 := Shift_Left(R3, 3);
      R1 := R1 xor R3;
      R0 := R0 xor R4;
      R1 := R1 xor R2;      
      R0 := Rotate_Left(R0, 7);
      R1 := Rotate_Left(R1, 1);
      R2 := R2 xor R0;
      R4 := Shift_Left(R1, 7);
      R3 := R3 xor R1;
      R2 := R2 xor R4;
      R3 := R3 xor R0;
      R2 := Rotate_Left(R2, 22);
      R3 := Rotate_Left(R3, 5);
     


      R4  := W(108+0);
      R3  := R3  xor R4 ;
      R4  := W(108+1);
      R1  := R1  xor R4 ;
      R4  := W(108+2);
      R2  := R2  xor R4 ;
      R4  := W(108+3);
      R0  := R0  xor R4 ;



      R4  := R3 ;
      R3  := R3  or R0 ;
      R0  := R0  xor R1 ;
      R1  := R1  and R4 ;
      R4  := R4  xor R2 ;
      R2  := R2  xor R0 ;
      R0  := R0  and R3 ;
      R4  := R4  or  R1 ;
      R0  := R0  xor R4 ;
      R3  := R3  xor R1 ;
      R4  := R4  and R3 ;
      R1  := R1  xor R0 ;
      R4  := R4  xor R2 ;
      R1  := R1  or  R3 ;
      R1  := R1  xor R2 ;
      R3  := R3  xor R0 ;
      R2  := R1 ;
      R1  := R1  or  R0 ;
      R1  := R1  xor R3 ;

      --Permutation: 1 2 3 4 0
      --w := R1 ; x := R2 ; y := R0 ; z := R4 ;

      R1 := Rotate_Left(R1, 13);
      R0 := Rotate_Left(R0, 3);
      R4 := R4 xor R0;     
      R3 := Shift_Left(R1, 3);
      R2 := R2 xor R1;
      R4 := R4 xor R3;
      R2 := R2 xor R0;      
      R4 := Rotate_Left(R4, 7);
      R2 := Rotate_Left(R2, 1);
      R0 := R0 xor R4;
      R3 := Shift_Left(R2, 7);
      R1 := R1 xor R2;
      R0 := R0 xor R3;
      R1 := R1 xor R4;
      R0 := Rotate_Left(R0, 22);
      R1 := Rotate_Left(R1, 5);
     


      R3  := W(112+0);
      R1  := R1  xor R3 ;
      R3  := W(112+1);
      R2  := R2  xor R3 ;
      R3  := W(112+2);
      R0  := R0  xor R3 ;
      R3  := W(112+3);
      R4  := R4  xor R3 ;


      R2  := R2  xor R4 ;
      R4  := -1  xor  R4 ;
      R0  := R0  xor R4 ;
      R4  := R4  xor R1 ;
      R3  := R2 ;
      R2  := R2  and R4 ;
      R2  := R2  xor R0 ;
      R3  := R3  xor R4 ;
      R1  := R1  xor R3 ;
      R0  := R0  and R3 ;
      R0  := R0  xor R1 ;
      R1  := R1  and R2 ;
      R4  := R4  xor R1 ;
      R3  := R3  or  R2 ;
      R3  := R3  xor R1 ;
      R1  := R1  or  R4 ;
      R1  := R1  xor R0 ;
      R0  := R0  and R4 ;
      R1  := -1  xor R1 ;
      R3  := R3  xor R0 ;

      --Permutation: 1 4 0 3 2
      -- w := R2 ; x := R3 ; y := R1 ; z := R4 ;


      R2 := Rotate_Left(R2, 13);
      R1 := Rotate_Left(R1, 3);
      R4 := R4 xor R1;     
      R0 := Shift_Left(R2, 3);
      R3 := R3 xor R2;
      R4 := R4 xor R0;
      R3 := R3 xor R1;      
      R4 := Rotate_Left(R4, 7);
      R3 := Rotate_Left(R3, 1);
      R1 := R1 xor R4;
      R0 := Shift_Left(R3, 7);
      R2 := R2 xor R3;
      R1 := R1 xor R0;
      R2 := R2 xor R4;
      R1 := Rotate_Left(R1, 22);
      R2 := Rotate_Left(R2, 5);
     


      R0  := W(116+0);
      R2  := R2  xor R0 ;
      R0  := W(116+1);
      R3  := R3  xor R0 ;
      R0  := W(116+2);
      R1  := R1  xor R0 ;
      R0  := W(116+3);
      R4  := R4  xor R0 ;



      R2  := R2  xor R3 ;
      R3  := R3  xor R4 ;
      R4  := -1  xor R4 ;
      R0  := R3 ;
      R3  := R3  and R2 ;
      R1  := R1  xor R4 ;
      R3  := R3  xor R1 ;
      R1  := R1  or  R0 ;
      R0  := R0  xor R4 ;
      R4  := R4  and R3 ;
      R4  := R4  xor R2 ;
      R0  := R0  xor R3 ;
      R0  := R0  xor R1 ;
      R1  := R1  xor R2 ;
      R2  := R2  and R4 ;
      R1  := -1  xor R1 ;
      R2  := R2  xor R0 ;
      R0  := R0  or  R4 ;
      R1  := R1  xor R0 ;

      --Permutation: 1 3 0 2 4
      --w := R3 ; x := R4 ; y := R2 ; z := R1 ;


      R3 := Rotate_Left(R3, 13);
      R2 := Rotate_Left(R2, 3);
      R1 := R1 xor R2;     
      R0 := Shift_Left(R3, 3);
      R4 := R4 xor R3;
      R1 := R1 xor R0;
      R4 := R4 xor R2;      
      R1 := Rotate_Left(R1, 7);
      R4 := Rotate_Left(R4, 1);
      R2 := R2 xor R1;
      R0 := Shift_Left(R4, 7);
      R3 := R3 xor R4;
      R2 := R2 xor R0;
      R3 := R3 xor R1;
      R2 := Rotate_Left(R2, 22);
      R3 := Rotate_Left(R3, 5);
     


      R0  := W(120+0);
      R3  := R3  xor R0 ;
      R0  := W(120+1);
      R4  := R4  xor R0 ;
      R0  := W(120+2);
      R2  := R2  xor R0 ;
      R0  := W(120+3);
      R1  := R1  xor R0 ;




      R2  := -1  xor R2 ;
      R0  := R1 ;
      R1  := R1  and R3 ;
      R3  := R3  xor R0 ;
      R1  := R1  xor R2 ;
      R2  := R2  or  R0 ;
      R4  := R4  xor R1 ;
      R2  := R2  xor R3 ;
      R3  := R3  or  R4 ;
      R2  := R2  xor R4 ;
      R0  := R0  xor R3 ;
      R3  := R3  or  R1 ;
      R3  := R3  xor R2 ;
      R0  := R0  xor R1 ;
      R0  := R0  xor R3 ;
      R1  := -1  xor R1 ;
      R2  := R2  and R0 ;
      R2  := R2  xor R1 ;

      --Permutation: 0 1 4 2 3
      --w := R3 ; x := R4 ; y := R0 ; z := R2 ;


      R3 := Rotate_Left(R3, 13);
      R0 := Rotate_Left(R0, 3);
      R2 := R2 xor R0;     
      R1 := Shift_Left(R3, 3);
      R4 := R4 xor R3;
      R2 := R2 xor R1;
      R4 := R4 xor R0;      
      R2 := Rotate_Left(R2, 7);
      R4 := Rotate_Left(R4, 1);
      R0 := R0 xor R2;
      R1 := Shift_Left(R4, 7);
      R3 := R3 xor R4;
      R0 := R0 xor R1;
      R3 := R3 xor R2;
      R0 := Rotate_Left(R0, 22);
      R3 := Rotate_Left(R3, 5);
     


      R1  := W(124+0);
      R3  := R3  xor R1 ;
      R1  := W(124+1);
      R4  := R4  xor R1 ;
      R1  := W(124+2);
      R0  := R0  xor R1 ;
      R1  := W(124+3);
      R2  := R2  xor R1 ;


      R1  := R0 ;
      R0  := R0  and R4 ;
      R0  := R0  xor R2 ;
      R2  := R2  and R4 ;
      R1  := R1  xor R0 ;
      R0  := R0  xor R4 ;
      R4  := R4  xor R3 ;
      R3  := R3  or  R1 ;
      R3  := R3  xor R0 ;
      R2  := R2  xor R4 ;
      R0  := R0  xor R2 ;
      R2  := R2  and R3 ;
      R2  := R2  xor R1 ;
      R1  := R1  xor R0 ;
      R0  := R0  and R3 ;
      R1  := -1  xor R1 ;
      R0  := R0  xor R1 ;
      R1  := R1  and R3 ;
      R4  := R4  xor R2 ;
      R1  := R1  xor R4 ;

      --Permutation: 2 4 3 0 1
      --w := R0 ; x := R1 ; y := R2 ; z := R3 ;


      R4  := W(128+0);
      R0  := R0  xor R4 ;
      R4  := W(128+1);
      R1  := R1  xor R4 ;
      R4  := W(128+2);
      R2  := R2  xor R4 ;
      R4  := W(128+3);
      R3  := R3  xor R4 ;

end;
