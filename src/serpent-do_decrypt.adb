separate(serpent)
procedure do_decrypt(W : Key_Schedule; R0, R1, R2, R3 : in out Unsigned_32) is
   R4 : unsigned_32;
begin

      R4  := W(128+0);
      R0  := R0  xor R4 ;
      R4  := W(128+1);
      R1  := R1  xor R4 ;
      R4  := W(128+2);
      R2  := R2  xor R4 ;
      R4  := W(128+3);
      R3  := R3  xor R4 ;


       R4 := R2; 
       R2 := R2 xor R0;
       R0 := R0 and R3; 
       R4 := R4 or  R3;
       R2 := R2 xor -1; 
       R3 := R3 xor R1;
       R1 := R1 or  R0; 
       R0 := R0 xor R2;
       R2 := R2 and R4; 
       R3 := R3 and R4;
       R1 := R1 xor R2; 
       R2 := R2 xor R0;
       R0 := R0  or R2; 
       R4 := R4 xor R1;
       R0 := R0 xor R3; 
       R3 := R3 xor R4;
       R4 := R4 or  R0; 
       R3 := R3 xor R2;
       R4 := R4 xor R2;
      --Permutation: 3 0 1 4 2

      R2  := W(124+0);
      R3  := R3  xor R2 ;
      R2  := W(124+1);
      R0  := R0  xor R2 ;
      R2  := W(124+2);
      R1  := R1  xor R2 ;
      R2  := W(124+3);
      R4  := R4  xor R2 ;


      R1 := Rotate_Right(R1, 22);
      R3 := Rotate_Right(R3, 5);
      R2 := Shift_Left(R0, 7);
      R1 := R1 xor R4;     
      R3 := R3 xor R0;
      R1 := R1 xor R2;
      R3 := R3 xor R4;
      R4 := Rotate_Right(R4, 7);
      R0 := Rotate_Right(R0, 1);
      R2 := Shift_Left(R3, 3);
      R4 := R4 xor R1;
      R0 := R0 xor R3;
      R4 := R4 xor R2;
      R0 := R0 xor R1;
      R1 := Rotate_Right(R1, 3);
      R3 := Rotate_Right(R3, 13);

--I6

      R3 := R3 xor R1; 
      R2 := R1;
      R1 := R1 and R3; 
      R2 := R2 xor R4;
      R1 := R1 xor -1; 
      R4 := R4 xor R0;
      R1 := R1 xor R4; 
      R2 := R2 or  R3;
      R3 := R3 xor R1; 
      R4 := R4 xor R2;
      R2 := R2 xor R0; 
      R0 := R0 and R4;
      R0 := R0 xor R3; 
      R3 := R3 xor R4;
      R3 := R3 or  R1; 
      R4 := R4 xor R0;
      R2 := R2 xor R3;
      --Permutation: 1 2 4 3 0       
 

      R3  := W(120+0);
      R0  := R0  xor R3 ;
      R3  := W(120+1);
      R1  := R1  xor R3 ;
      R3  := W(120+2);
      R2  := R2  xor R3 ;
      R3  := W(120+3);
      R4  := R4  xor R3 ;


      R2 := Rotate_Right(R2, 22);
      R0 := Rotate_Right(R0, 5);
      R3 := Shift_Left(R1, 7);
      R2 := R2 xor R4;     
      R0 := R0 xor R1;
      R2 := R2 xor R3;
      R0 := R0 xor R4;
      R4 := Rotate_Right(R4, 7);
      R1 := Rotate_Right(R1, 1);
      R3 := Shift_Left(R0, 3);
      R4 := R4 xor R2;
      R1 := R1 xor R0;
      R4 := R4 xor R3;
      R1 := R1 xor R2;
      R2 := Rotate_Right(R2, 3);
      R0 := Rotate_Right(R0, 13);

--I5

      R1 := R1 xor -1; 
      R3 :=  R4;
      R2 := R2 xor R1; 
      R4 := R4 or  R0;
      R4 := R4 xor R2; 
      R2 := R2 or  R1;
      R2 := R2 and R0; 
      R3 := R3 xor R4;
      R2 := R2 xor R3; 
      R3 := R3 or  R0;
      R3 := R3 xor R1; 
      R1 := R1 and R2;
      R1 := R1 xor R4; 
      R3 := R3 xor R2;
      R4 := R4 and R3; 
      R3 := R3 xor R1;
      R4 := R4 xor R0;
      R4 := R4 xor R3; 
      R3 := R3 xor -1;
       --Permutation: 1 4 3 2 0
	

      R0  := W(116+0);
      R1  := R1  xor R0 ;
      R0  := W(116+1);
      R3  := R3  xor R0 ;
      R0  := W(116+2);
      R4  := R4  xor R0 ;
      R0  := W(116+3);
      R2  := R2  xor R0 ;


      R4 := Rotate_Right(R4, 22);
      R1 := Rotate_Right(R1, 5);
      R0 := Shift_Left(R3, 7);
      R4 := R4 xor R2;     
      R1 := R1 xor R3;
      R4 := R4 xor R0;
      R1 := R1 xor R2;
      R2 := Rotate_Right(R2, 7);
      R3 := Rotate_Right(R3, 1);
      R0 := Shift_Left(R1, 3);
      R2 := R2 xor R4;
      R3 := R3 xor R1;
      R2 := R2 xor R0;
      R3 := R3 xor R4;
      R4 := Rotate_Right(R4, 3);
      R1 := Rotate_Right(R1, 13);

--I4

      R0 :=  R4; 
      R4 := R4 and R2;
      R4 := R4 xor R3; 
      R3 := R3 or  R2;
      R3 := R3 and R1; 
      R0 := R0 xor R4;
      R0 := R0 xor R3; 
      R3 := R3 and R4;
      R1 := R1 xor -1; 
      R2 := R2 xor R0;
      R3 := R3 xor R2; 
      R2 := R2 and R1;
      R2 := R2 xor R4; 
      R1 := R1 xor R3;
      R4 := R4 and R1; 
      R2 := R2 xor R1;
      R4 := R4 xor R0;
      R4 := R4 or  R2; 
      R2 := R2 xor R1;
      R4 := R4 xor R3;
      --Permutation: 0 3 2 4 1


      R3  := W(112+0);
      R1  := R1  xor R3 ;
      R3  := W(112+1);
      R2  := R2  xor R3 ;
      R3  := W(112+2);
      R4  := R4  xor R3 ;
      R3  := W(112+3);
      R0  := R0  xor R3 ;


      R4 := Rotate_Right(R4, 22);
      R1 := Rotate_Right(R1, 5);
      R3 := Shift_Left(R2, 7);
      R4 := R4 xor R0;     
      R1 := R1 xor R2;
      R4 := R4 xor R3;
      R1 := R1 xor R0;
      R0 := Rotate_Right(R0, 7);
      R2 := Rotate_Right(R2, 1);
      R3 := Shift_Left(R1, 3);
      R0 := R0 xor R4;
      R2 := R2 xor R1;
      R0 := R0 xor R3;
      R2 := R2 xor R4;
      R4 := Rotate_Right(R4, 3);
      R1 := Rotate_Right(R1, 13);

--I3

      R3 :=  R4; 
      R4 := R4 xor R2;
      R1 := R1 xor R4; 
      R3 := R3 and R4;
      R3 := R3 xor R1; 
      R1 := R1 and R2;
      R2 := R2 xor R0; 
      R0 := R0 or  R3;
      R4 := R4 xor R0; 
      R1 := R1 xor R0;
      R2 := R2 xor R3; 
      R0 := R0 and R4;
      R0 := R0 xor R2; 
      R2 := R2 xor R1;
      R2 := R2 or  R4; 
      R1 := R1 xor R0;
      R2 := R2 xor R3;
      R1 := R1 xor R2;
     --Permutation: 2 1 3 0 4


      R3  := W(108+0);
      R4  := R4  xor R3 ;
      R3  := W(108+1);
      R2  := R2  xor R3 ;
      R3  := W(108+2);
      R0  := R0  xor R3 ;
      R3  := W(108+3);
      R1  := R1  xor R3 ;


      R0 := Rotate_Right(R0, 22);
      R4 := Rotate_Right(R4, 5);
      R3 := Shift_Left(R2, 7);
      R0 := R0 xor R1;     
      R4 := R4 xor R2;
      R0 := R0 xor R3;
      R4 := R4 xor R1;
      R1 := Rotate_Right(R1, 7);
      R2 := Rotate_Right(R2, 1);
      R3 := Shift_Left(R4, 3);
      R1 := R1 xor R0;
      R2 := R2 xor R4;
      R1 := R1 xor R3;
      R2 := R2 xor R0;
      R0 := Rotate_Right(R0, 3);
      R4 := Rotate_Right(R4, 13);

--I2

      R0 := R0 xor R1; 
      R1 := R1 xor R4;
      R3 :=  R1; 
      R1 := R1 and R0;
      R1 := R1 xor R2; 
      R2 := R2 or  R0;
      R2 := R2 xor R3; 
      R3 := R3 and R1;
      R0 := R0 xor R1; 
      R3 := R3 and R4;
      R3 := R3 xor R0; 
      R0 := R0 and R2;
      R0 := R0 or  R4; 
      R1 := R1 xor -1;
      R0 := R0 xor R1; 
      R4 := R4 xor R1;
      R4 := R4 and R2; 
      R1 := R1 xor R3;
      R1 := R1 xor R4;
      --Permutation: 1 4 2 3 0

      R4  := W(104+0);
      R2  := R2  xor R4 ;
      R4  := W(104+1);
      R3  := R3  xor R4 ;
      R4  := W(104+2);
      R0  := R0  xor R4 ;
      R4  := W(104+3);
      R1  := R1  xor R4 ;


      R0 := Rotate_Right(R0, 22);
      R2 := Rotate_Right(R2, 5);
      R4 := Shift_Left(R3, 7);
      R0 := R0 xor R1;     
      R2 := R2 xor R3;
      R0 := R0 xor R4;
      R2 := R2 xor R1;
      R1 := Rotate_Right(R1, 7);
      R3 := Rotate_Right(R3, 1);
      R4 := Shift_Left(R2, 3);
      R1 := R1 xor R0;
      R3 := R3 xor R2;
      R1 := R1 xor R4;
      R3 := R3 xor R0;
      R0 := Rotate_Right(R0, 3);
      R2 := Rotate_Right(R2, 13);

--I1

      R4 :=  R3;  
      R3 := R3 xor R1;
      R1 := R1 and R3; 
      R4 := R4 xor R0;
      R1 := R1 xor R2; 
      R2 := R2 or  R3;
      R0 := R0 xor R1; 
      R2 := R2 xor R4;
      R2 := R2 or  R0; 
      R3 := R3 xor R1;
      R2 := R2 xor R3; 
      R3 := R3 or  R1;
      R3 := R3 xor R2; 
      R4 := R4 xor -1;
      R4 := R4 xor R3; 
      R3 := R3 or  R2;
      R3 := R3 xor R2;
      R3 := R3 or  R4;
      R1 := R1 xor R3;
      --Permutation: 4 0 3 2 1

      R3  := W(100+0);
      R4  := R4  xor R3 ;
      R3  := W(100+1);
      R2  := R2  xor R3 ;
      R3  := W(100+2);
      R1  := R1  xor R3 ;
      R3  := W(100+3);
      R0  := R0  xor R3 ;


      R1 := Rotate_Right(R1, 22);
      R4 := Rotate_Right(R4, 5);
      R3 := Shift_Left(R2, 7);
      R1 := R1 xor R0;     
      R4 := R4 xor R2;
      R1 := R1 xor R3;
      R4 := R4 xor R0;
      R0 := Rotate_Right(R0, 7);
      R2 := Rotate_Right(R2, 1);
      R3 := Shift_Left(R4, 3);
      R0 := R0 xor R1;
      R2 := R2 xor R4;
      R0 := R0 xor R3;
      R2 := R2 xor R1;
      R1 := Rotate_Right(R1, 3);
      R4 := Rotate_Right(R4, 13);

--I0

      R1 := R1 xor -1; 
      R3 := R2;
      R2 := R2 or  R4; 
      R3 := R3 xor -1;
      R2 := R2 xor R1; 
      R1 := R1 or  R3;
      R2 := R2 xor R0; 
      R4 := R4 xor R3;
      R1 := R1 xor R4; 
      R4 := R4 and R0;
      R3 := R3 xor R4; 
      R4 := R4 or  R2;
      R4 := R4 xor R1; 
      R0 := R0 xor R3;
      R1 := R1 xor R2; 
      R0 := R0 xor R4;
      R0 := R0 xor R2;
      R1 := R1 and R0;
      R3 := R3 xor R1;
      --Permutation: 0 4 1 3 2


      R1  := W(96+0);
      R4  := R4  xor R1 ;
      R1  := W(96+1);
      R3  := R3  xor R1 ;
      R1  := W(96+2);
      R2  := R2  xor R1 ;
      R1  := W(96+3);
      R0  := R0  xor R1 ;


      R2 := Rotate_Right(R2, 22);
      R4 := Rotate_Right(R4, 5);
      R1 := Shift_Left(R3, 7);
      R2 := R2 xor R0;     
      R4 := R4 xor R3;
      R2 := R2 xor R1;
      R4 := R4 xor R0;
      R0 := Rotate_Right(R0, 7);
      R3 := Rotate_Right(R3, 1);
      R1 := Shift_Left(R4, 3);
      R0 := R0 xor R2;
      R3 := R3 xor R4;
      R0 := R0 xor R1;
      R3 := R3 xor R2;
      R2 := Rotate_Right(R2, 3);
      R4 := Rotate_Right(R4, 13);

--I7

       R1 := R2; 
       R2 := R2 xor R4;
       R4 := R4 and R0; 
       R1 := R1 or  R0;
       R2 := R2 xor -1; 
       R0 := R0 xor R3;
       R3 := R3 or  R4; 
       R4 := R4 xor R2;
       R2 := R2 and R1; 
       R0 := R0 and R1;
       R3 := R3 xor R2; 
       R2 := R2 xor R4;
       R4 := R4  or R2; 
       R1 := R1 xor R3;
       R4 := R4 xor R0; 
       R0 := R0 xor R1;
       R1 := R1 or  R4; 
       R0 := R0 xor R2;
       R1 := R1 xor R2;
      --Permutation: 3 0 1 4 2

      R2  := W(92+0);
      R0  := R0  xor R2 ;
      R2  := W(92+1);
      R4  := R4  xor R2 ;
      R2  := W(92+2);
      R3  := R3  xor R2 ;
      R2  := W(92+3);
      R1  := R1  xor R2 ;


      R3 := Rotate_Right(R3, 22);
      R0 := Rotate_Right(R0, 5);
      R2 := Shift_Left(R4, 7);
      R3 := R3 xor R1;     
      R0 := R0 xor R4;
      R3 := R3 xor R2;
      R0 := R0 xor R1;
      R1 := Rotate_Right(R1, 7);
      R4 := Rotate_Right(R4, 1);
      R2 := Shift_Left(R0, 3);
      R1 := R1 xor R3;
      R4 := R4 xor R0;
      R1 := R1 xor R2;
      R4 := R4 xor R3;
      R3 := Rotate_Right(R3, 3);
      R0 := Rotate_Right(R0, 13);

--I6

      R0 := R0 xor R3; 
      R2 := R3;
      R3 := R3 and R0; 
      R2 := R2 xor R1;
      R3 := R3 xor -1; 
      R1 := R1 xor R4;
      R3 := R3 xor R1; 
      R2 := R2 or  R0;
      R0 := R0 xor R3; 
      R1 := R1 xor R2;
      R2 := R2 xor R4; 
      R4 := R4 and R1;
      R4 := R4 xor R0; 
      R0 := R0 xor R1;
      R0 := R0 or  R3; 
      R1 := R1 xor R4;
      R2 := R2 xor R0;
      --Permutation: 1 2 4 3 0       
 

      R0  := W(88+0);
      R4  := R4  xor R0 ;
      R0  := W(88+1);
      R3  := R3  xor R0 ;
      R0  := W(88+2);
      R2  := R2  xor R0 ;
      R0  := W(88+3);
      R1  := R1  xor R0 ;


      R2 := Rotate_Right(R2, 22);
      R4 := Rotate_Right(R4, 5);
      R0 := Shift_Left(R3, 7);
      R2 := R2 xor R1;     
      R4 := R4 xor R3;
      R2 := R2 xor R0;
      R4 := R4 xor R1;
      R1 := Rotate_Right(R1, 7);
      R3 := Rotate_Right(R3, 1);
      R0 := Shift_Left(R4, 3);
      R1 := R1 xor R2;
      R3 := R3 xor R4;
      R1 := R1 xor R0;
      R3 := R3 xor R2;
      R2 := Rotate_Right(R2, 3);
      R4 := Rotate_Right(R4, 13);

--I5

      R3 := R3 xor -1; 
      R0 :=  R1;
      R2 := R2 xor R3; 
      R1 := R1 or  R4;
      R1 := R1 xor R2; 
      R2 := R2 or  R3;
      R2 := R2 and R4; 
      R0 := R0 xor R1;
      R2 := R2 xor R0; 
      R0 := R0 or  R4;
      R0 := R0 xor R3; 
      R3 := R3 and R2;
      R3 := R3 xor R1; 
      R0 := R0 xor R2;
      R1 := R1 and R0; 
      R0 := R0 xor R3;
      R1 := R1 xor R4;
      R1 := R1 xor R0; 
      R0 := R0 xor -1;
       --Permutation: 1 4 3 2 0
	

      R4  := W(84+0);
      R3  := R3  xor R4 ;
      R4  := W(84+1);
      R0  := R0  xor R4 ;
      R4  := W(84+2);
      R1  := R1  xor R4 ;
      R4  := W(84+3);
      R2  := R2  xor R4 ;


      R1 := Rotate_Right(R1, 22);
      R3 := Rotate_Right(R3, 5);
      R4 := Shift_Left(R0, 7);
      R1 := R1 xor R2;     
      R3 := R3 xor R0;
      R1 := R1 xor R4;
      R3 := R3 xor R2;
      R2 := Rotate_Right(R2, 7);
      R0 := Rotate_Right(R0, 1);
      R4 := Shift_Left(R3, 3);
      R2 := R2 xor R1;
      R0 := R0 xor R3;
      R2 := R2 xor R4;
      R0 := R0 xor R1;
      R1 := Rotate_Right(R1, 3);
      R3 := Rotate_Right(R3, 13);

--I4

      R4 :=  R1; 
      R1 := R1 and R2;
      R1 := R1 xor R0; 
      R0 := R0 or  R2;
      R0 := R0 and R3; 
      R4 := R4 xor R1;
      R4 := R4 xor R0; 
      R0 := R0 and R1;
      R3 := R3 xor -1; 
      R2 := R2 xor R4;
      R0 := R0 xor R2; 
      R2 := R2 and R3;
      R2 := R2 xor R1; 
      R3 := R3 xor R0;
      R1 := R1 and R3; 
      R2 := R2 xor R3;
      R1 := R1 xor R4;
      R1 := R1 or  R2; 
      R2 := R2 xor R3;
      R1 := R1 xor R0;
      --Permutation: 0 3 2 4 1


      R0  := W(80+0);
      R3  := R3  xor R0 ;
      R0  := W(80+1);
      R2  := R2  xor R0 ;
      R0  := W(80+2);
      R1  := R1  xor R0 ;
      R0  := W(80+3);
      R4  := R4  xor R0 ;


      R1 := Rotate_Right(R1, 22);
      R3 := Rotate_Right(R3, 5);
      R0 := Shift_Left(R2, 7);
      R1 := R1 xor R4;     
      R3 := R3 xor R2;
      R1 := R1 xor R0;
      R3 := R3 xor R4;
      R4 := Rotate_Right(R4, 7);
      R2 := Rotate_Right(R2, 1);
      R0 := Shift_Left(R3, 3);
      R4 := R4 xor R1;
      R2 := R2 xor R3;
      R4 := R4 xor R0;
      R2 := R2 xor R1;
      R1 := Rotate_Right(R1, 3);
      R3 := Rotate_Right(R3, 13);

--I3

      R0 :=  R1; 
      R1 := R1 xor R2;
      R3 := R3 xor R1; 
      R0 := R0 and R1;
      R0 := R0 xor R3; 
      R3 := R3 and R2;
      R2 := R2 xor R4; 
      R4 := R4 or  R0;
      R1 := R1 xor R4; 
      R3 := R3 xor R4;
      R2 := R2 xor R0; 
      R4 := R4 and R1;
      R4 := R4 xor R2; 
      R2 := R2 xor R3;
      R2 := R2 or  R1; 
      R3 := R3 xor R4;
      R2 := R2 xor R0;
      R3 := R3 xor R2;
     --Permutation: 2 1 3 0 4


      R0  := W(76+0);
      R1  := R1  xor R0 ;
      R0  := W(76+1);
      R2  := R2  xor R0 ;
      R0  := W(76+2);
      R4  := R4  xor R0 ;
      R0  := W(76+3);
      R3  := R3  xor R0 ;


      R4 := Rotate_Right(R4, 22);
      R1 := Rotate_Right(R1, 5);
      R0 := Shift_Left(R2, 7);
      R4 := R4 xor R3;     
      R1 := R1 xor R2;
      R4 := R4 xor R0;
      R1 := R1 xor R3;
      R3 := Rotate_Right(R3, 7);
      R2 := Rotate_Right(R2, 1);
      R0 := Shift_Left(R1, 3);
      R3 := R3 xor R4;
      R2 := R2 xor R1;
      R3 := R3 xor R0;
      R2 := R2 xor R4;
      R4 := Rotate_Right(R4, 3);
      R1 := Rotate_Right(R1, 13);

--I2

      R4 := R4 xor R3; 
      R3 := R3 xor R1;
      R0 :=  R3; 
      R3 := R3 and R4;
      R3 := R3 xor R2; 
      R2 := R2 or  R4;
      R2 := R2 xor R0; 
      R0 := R0 and R3;
      R4 := R4 xor R3; 
      R0 := R0 and R1;
      R0 := R0 xor R4; 
      R4 := R4 and R2;
      R4 := R4 or  R1; 
      R3 := R3 xor -1;
      R4 := R4 xor R3; 
      R1 := R1 xor R3;
      R1 := R1 and R2; 
      R3 := R3 xor R0;
      R3 := R3 xor R1;
      --Permutation: 1 4 2 3 0

      R1  := W(72+0);
      R2  := R2  xor R1 ;
      R1  := W(72+1);
      R0  := R0  xor R1 ;
      R1  := W(72+2);
      R4  := R4  xor R1 ;
      R1  := W(72+3);
      R3  := R3  xor R1 ;


      R4 := Rotate_Right(R4, 22);
      R2 := Rotate_Right(R2, 5);
      R1 := Shift_Left(R0, 7);
      R4 := R4 xor R3;     
      R2 := R2 xor R0;
      R4 := R4 xor R1;
      R2 := R2 xor R3;
      R3 := Rotate_Right(R3, 7);
      R0 := Rotate_Right(R0, 1);
      R1 := Shift_Left(R2, 3);
      R3 := R3 xor R4;
      R0 := R0 xor R2;
      R3 := R3 xor R1;
      R0 := R0 xor R4;
      R4 := Rotate_Right(R4, 3);
      R2 := Rotate_Right(R2, 13);

--I1

      R1 :=  R0;  
      R0 := R0 xor R3;
      R3 := R3 and R0; 
      R1 := R1 xor R4;
      R3 := R3 xor R2; 
      R2 := R2 or  R0;
      R4 := R4 xor R3; 
      R2 := R2 xor R1;
      R2 := R2 or  R4; 
      R0 := R0 xor R3;
      R2 := R2 xor R0; 
      R0 := R0 or  R3;
      R0 := R0 xor R2; 
      R1 := R1 xor -1;
      R1 := R1 xor R0; 
      R0 := R0 or  R2;
      R0 := R0 xor R2;
      R0 := R0 or  R1;
      R3 := R3 xor R0;
      --Permutation: 4 0 3 2 1

      R0  := W(68+0);
      R1  := R1  xor R0 ;
      R0  := W(68+1);
      R2  := R2  xor R0 ;
      R0  := W(68+2);
      R3  := R3  xor R0 ;
      R0  := W(68+3);
      R4  := R4  xor R0 ;


      R3 := Rotate_Right(R3, 22);
      R1 := Rotate_Right(R1, 5);
      R0 := Shift_Left(R2, 7);
      R3 := R3 xor R4;     
      R1 := R1 xor R2;
      R3 := R3 xor R0;
      R1 := R1 xor R4;
      R4 := Rotate_Right(R4, 7);
      R2 := Rotate_Right(R2, 1);
      R0 := Shift_Left(R1, 3);
      R4 := R4 xor R3;
      R2 := R2 xor R1;
      R4 := R4 xor R0;
      R2 := R2 xor R3;
      R3 := Rotate_Right(R3, 3);
      R1 := Rotate_Right(R1, 13);

--I0

      R3 := R3 xor -1; 
      R0 := R2;
      R2 := R2 or  R1; 
      R0 := R0 xor -1;
      R2 := R2 xor R3; 
      R3 := R3 or  R0;
      R2 := R2 xor R4; 
      R1 := R1 xor R0;
      R3 := R3 xor R1; 
      R1 := R1 and R4;
      R0 := R0 xor R1; 
      R1 := R1 or  R2;
      R1 := R1 xor R3; 
      R4 := R4 xor R0;
      R3 := R3 xor R2; 
      R4 := R4 xor R1;
      R4 := R4 xor R2;
      R3 := R3 and R4;
      R0 := R0 xor R3;
      --Permutation: 0 4 1 3 2


      R3  := W(64+0);
      R1  := R1  xor R3 ;
      R3  := W(64+1);
      R0  := R0  xor R3 ;
      R3  := W(64+2);
      R2  := R2  xor R3 ;
      R3  := W(64+3);
      R4  := R4  xor R3 ;


      R2 := Rotate_Right(R2, 22);
      R1 := Rotate_Right(R1, 5);
      R3 := Shift_Left(R0, 7);
      R2 := R2 xor R4;     
      R1 := R1 xor R0;
      R2 := R2 xor R3;
      R1 := R1 xor R4;
      R4 := Rotate_Right(R4, 7);
      R0 := Rotate_Right(R0, 1);
      R3 := Shift_Left(R1, 3);
      R4 := R4 xor R2;
      R0 := R0 xor R1;
      R4 := R4 xor R3;
      R0 := R0 xor R2;
      R2 := Rotate_Right(R2, 3);
      R1 := Rotate_Right(R1, 13);

--I7

       R3 := R2; 
       R2 := R2 xor R1;
       R1 := R1 and R4; 
       R3 := R3 or  R4;
       R2 := R2 xor -1; 
       R4 := R4 xor R0;
       R0 := R0 or  R1; 
       R1 := R1 xor R2;
       R2 := R2 and R3; 
       R4 := R4 and R3;
       R0 := R0 xor R2; 
       R2 := R2 xor R1;
       R1 := R1  or R2; 
       R3 := R3 xor R0;
       R1 := R1 xor R4; 
       R4 := R4 xor R3;
       R3 := R3 or  R1; 
       R4 := R4 xor R2;
       R3 := R3 xor R2;
      --Permutation: 3 0 1 4 2

      R2  := W(60+0);
      R4  := R4  xor R2 ;
      R2  := W(60+1);
      R1  := R1  xor R2 ;
      R2  := W(60+2);
      R0  := R0  xor R2 ;
      R2  := W(60+3);
      R3  := R3  xor R2 ;


      R0 := Rotate_Right(R0, 22);
      R4 := Rotate_Right(R4, 5);
      R2 := Shift_Left(R1, 7);
      R0 := R0 xor R3;     
      R4 := R4 xor R1;
      R0 := R0 xor R2;
      R4 := R4 xor R3;
      R3 := Rotate_Right(R3, 7);
      R1 := Rotate_Right(R1, 1);
      R2 := Shift_Left(R4, 3);
      R3 := R3 xor R0;
      R1 := R1 xor R4;
      R3 := R3 xor R2;
      R1 := R1 xor R0;
      R0 := Rotate_Right(R0, 3);
      R4 := Rotate_Right(R4, 13);

--I6

      R4 := R4 xor R0; 
      R2 := R0;
      R0 := R0 and R4; 
      R2 := R2 xor R3;
      R0 := R0 xor -1; 
      R3 := R3 xor R1;
      R0 := R0 xor R3; 
      R2 := R2 or  R4;
      R4 := R4 xor R0; 
      R3 := R3 xor R2;
      R2 := R2 xor R1; 
      R1 := R1 and R3;
      R1 := R1 xor R4; 
      R4 := R4 xor R3;
      R4 := R4 or  R0; 
      R3 := R3 xor R1;
      R2 := R2 xor R4;
      --Permutation: 1 2 4 3 0       
 

      R4  := W(56+0);
      R1  := R1  xor R4 ;
      R4  := W(56+1);
      R0  := R0  xor R4 ;
      R4  := W(56+2);
      R2  := R2  xor R4 ;
      R4  := W(56+3);
      R3  := R3  xor R4 ;


      R2 := Rotate_Right(R2, 22);
      R1 := Rotate_Right(R1, 5);
      R4 := Shift_Left(R0, 7);
      R2 := R2 xor R3;     
      R1 := R1 xor R0;
      R2 := R2 xor R4;
      R1 := R1 xor R3;
      R3 := Rotate_Right(R3, 7);
      R0 := Rotate_Right(R0, 1);
      R4 := Shift_Left(R1, 3);
      R3 := R3 xor R2;
      R0 := R0 xor R1;
      R3 := R3 xor R4;
      R0 := R0 xor R2;
      R2 := Rotate_Right(R2, 3);
      R1 := Rotate_Right(R1, 13);

--I5

      R0 := R0 xor -1; 
      R4 :=  R3;
      R2 := R2 xor R0; 
      R3 := R3 or  R1;
      R3 := R3 xor R2; 
      R2 := R2 or  R0;
      R2 := R2 and R1; 
      R4 := R4 xor R3;
      R2 := R2 xor R4; 
      R4 := R4 or  R1;
      R4 := R4 xor R0; 
      R0 := R0 and R2;
      R0 := R0 xor R3; 
      R4 := R4 xor R2;
      R3 := R3 and R4; 
      R4 := R4 xor R0;
      R3 := R3 xor R1;
      R3 := R3 xor R4; 
      R4 := R4 xor -1;
       --Permutation: 1 4 3 2 0
	

      R1  := W(52+0);
      R0  := R0  xor R1 ;
      R1  := W(52+1);
      R4  := R4  xor R1 ;
      R1  := W(52+2);
      R3  := R3  xor R1 ;
      R1  := W(52+3);
      R2  := R2  xor R1 ;


      R3 := Rotate_Right(R3, 22);
      R0 := Rotate_Right(R0, 5);
      R1 := Shift_Left(R4, 7);
      R3 := R3 xor R2;     
      R0 := R0 xor R4;
      R3 := R3 xor R1;
      R0 := R0 xor R2;
      R2 := Rotate_Right(R2, 7);
      R4 := Rotate_Right(R4, 1);
      R1 := Shift_Left(R0, 3);
      R2 := R2 xor R3;
      R4 := R4 xor R0;
      R2 := R2 xor R1;
      R4 := R4 xor R3;
      R3 := Rotate_Right(R3, 3);
      R0 := Rotate_Right(R0, 13);

--I4

      R1 :=  R3; 
      R3 := R3 and R2;
      R3 := R3 xor R4; 
      R4 := R4 or  R2;
      R4 := R4 and R0; 
      R1 := R1 xor R3;
      R1 := R1 xor R4; 
      R4 := R4 and R3;
      R0 := R0 xor -1; 
      R2 := R2 xor R1;
      R4 := R4 xor R2; 
      R2 := R2 and R0;
      R2 := R2 xor R3; 
      R0 := R0 xor R4;
      R3 := R3 and R0; 
      R2 := R2 xor R0;
      R3 := R3 xor R1;
      R3 := R3 or  R2; 
      R2 := R2 xor R0;
      R3 := R3 xor R4;
      --Permutation: 0 3 2 4 1


      R4  := W(48+0);
      R0  := R0  xor R4 ;
      R4  := W(48+1);
      R2  := R2  xor R4 ;
      R4  := W(48+2);
      R3  := R3  xor R4 ;
      R4  := W(48+3);
      R1  := R1  xor R4 ;


      R3 := Rotate_Right(R3, 22);
      R0 := Rotate_Right(R0, 5);
      R4 := Shift_Left(R2, 7);
      R3 := R3 xor R1;     
      R0 := R0 xor R2;
      R3 := R3 xor R4;
      R0 := R0 xor R1;
      R1 := Rotate_Right(R1, 7);
      R2 := Rotate_Right(R2, 1);
      R4 := Shift_Left(R0, 3);
      R1 := R1 xor R3;
      R2 := R2 xor R0;
      R1 := R1 xor R4;
      R2 := R2 xor R3;
      R3 := Rotate_Right(R3, 3);
      R0 := Rotate_Right(R0, 13);

--I3

      R4 :=  R3; 
      R3 := R3 xor R2;
      R0 := R0 xor R3; 
      R4 := R4 and R3;
      R4 := R4 xor R0; 
      R0 := R0 and R2;
      R2 := R2 xor R1; 
      R1 := R1 or  R4;
      R3 := R3 xor R1; 
      R0 := R0 xor R1;
      R2 := R2 xor R4; 
      R1 := R1 and R3;
      R1 := R1 xor R2; 
      R2 := R2 xor R0;
      R2 := R2 or  R3; 
      R0 := R0 xor R1;
      R2 := R2 xor R4;
      R0 := R0 xor R2;
     --Permutation: 2 1 3 0 4


      R4  := W(44+0);
      R3  := R3  xor R4 ;
      R4  := W(44+1);
      R2  := R2  xor R4 ;
      R4  := W(44+2);
      R1  := R1  xor R4 ;
      R4  := W(44+3);
      R0  := R0  xor R4 ;


      R1 := Rotate_Right(R1, 22);
      R3 := Rotate_Right(R3, 5);
      R4 := Shift_Left(R2, 7);
      R1 := R1 xor R0;     
      R3 := R3 xor R2;
      R1 := R1 xor R4;
      R3 := R3 xor R0;
      R0 := Rotate_Right(R0, 7);
      R2 := Rotate_Right(R2, 1);
      R4 := Shift_Left(R3, 3);
      R0 := R0 xor R1;
      R2 := R2 xor R3;
      R0 := R0 xor R4;
      R2 := R2 xor R1;
      R1 := Rotate_Right(R1, 3);
      R3 := Rotate_Right(R3, 13);

--I2

      R1 := R1 xor R0; 
      R0 := R0 xor R3;
      R4 :=  R0; 
      R0 := R0 and R1;
      R0 := R0 xor R2; 
      R2 := R2 or  R1;
      R2 := R2 xor R4; 
      R4 := R4 and R0;
      R1 := R1 xor R0; 
      R4 := R4 and R3;
      R4 := R4 xor R1; 
      R1 := R1 and R2;
      R1 := R1 or  R3; 
      R0 := R0 xor -1;
      R1 := R1 xor R0; 
      R3 := R3 xor R0;
      R3 := R3 and R2; 
      R0 := R0 xor R4;
      R0 := R0 xor R3;
      --Permutation: 1 4 2 3 0

      R3  := W(40+0);
      R2  := R2  xor R3 ;
      R3  := W(40+1);
      R4  := R4  xor R3 ;
      R3  := W(40+2);
      R1  := R1  xor R3 ;
      R3  := W(40+3);
      R0  := R0  xor R3 ;


      R1 := Rotate_Right(R1, 22);
      R2 := Rotate_Right(R2, 5);
      R3 := Shift_Left(R4, 7);
      R1 := R1 xor R0;     
      R2 := R2 xor R4;
      R1 := R1 xor R3;
      R2 := R2 xor R0;
      R0 := Rotate_Right(R0, 7);
      R4 := Rotate_Right(R4, 1);
      R3 := Shift_Left(R2, 3);
      R0 := R0 xor R1;
      R4 := R4 xor R2;
      R0 := R0 xor R3;
      R4 := R4 xor R1;
      R1 := Rotate_Right(R1, 3);
      R2 := Rotate_Right(R2, 13);

--I1

      R3 :=  R4;  
      R4 := R4 xor R0;
      R0 := R0 and R4; 
      R3 := R3 xor R1;
      R0 := R0 xor R2; 
      R2 := R2 or  R4;
      R1 := R1 xor R0; 
      R2 := R2 xor R3;
      R2 := R2 or  R1; 
      R4 := R4 xor R0;
      R2 := R2 xor R4; 
      R4 := R4 or  R0;
      R4 := R4 xor R2; 
      R3 := R3 xor -1;
      R3 := R3 xor R4; 
      R4 := R4 or  R2;
      R4 := R4 xor R2;
      R4 := R4 or  R3;
      R0 := R0 xor R4;
      --Permutation: 4 0 3 2 1

      R4  := W(36+0);
      R3  := R3  xor R4 ;
      R4  := W(36+1);
      R2  := R2  xor R4 ;
      R4  := W(36+2);
      R0  := R0  xor R4 ;
      R4  := W(36+3);
      R1  := R1  xor R4 ;


      R0 := Rotate_Right(R0, 22);
      R3 := Rotate_Right(R3, 5);
      R4 := Shift_Left(R2, 7);
      R0 := R0 xor R1;     
      R3 := R3 xor R2;
      R0 := R0 xor R4;
      R3 := R3 xor R1;
      R1 := Rotate_Right(R1, 7);
      R2 := Rotate_Right(R2, 1);
      R4 := Shift_Left(R3, 3);
      R1 := R1 xor R0;
      R2 := R2 xor R3;
      R1 := R1 xor R4;
      R2 := R2 xor R0;
      R0 := Rotate_Right(R0, 3);
      R3 := Rotate_Right(R3, 13);

--I0

      R0 := R0 xor -1; 
      R4 := R2;
      R2 := R2 or  R3; 
      R4 := R4 xor -1;
      R2 := R2 xor R0; 
      R0 := R0 or  R4;
      R2 := R2 xor R1; 
      R3 := R3 xor R4;
      R0 := R0 xor R3; 
      R3 := R3 and R1;
      R4 := R4 xor R3; 
      R3 := R3 or  R2;
      R3 := R3 xor R0; 
      R1 := R1 xor R4;
      R0 := R0 xor R2; 
      R1 := R1 xor R3;
      R1 := R1 xor R2;
      R0 := R0 and R1;
      R4 := R4 xor R0;
      --Permutation: 0 4 1 3 2


      R0  := W(32+0);
      R3  := R3  xor R0 ;
      R0  := W(32+1);
      R4  := R4  xor R0 ;
      R0  := W(32+2);
      R2  := R2  xor R0 ;
      R0  := W(32+3);
      R1  := R1  xor R0 ;


      R2 := Rotate_Right(R2, 22);
      R3 := Rotate_Right(R3, 5);
      R0 := Shift_Left(R4, 7);
      R2 := R2 xor R1;     
      R3 := R3 xor R4;
      R2 := R2 xor R0;
      R3 := R3 xor R1;
      R1 := Rotate_Right(R1, 7);
      R4 := Rotate_Right(R4, 1);
      R0 := Shift_Left(R3, 3);
      R1 := R1 xor R2;
      R4 := R4 xor R3;
      R1 := R1 xor R0;
      R4 := R4 xor R2;
      R2 := Rotate_Right(R2, 3);
      R3 := Rotate_Right(R3, 13);

--I7

       R0 := R2; 
       R2 := R2 xor R3;
       R3 := R3 and R1; 
       R0 := R0 or  R1;
       R2 := R2 xor -1; 
       R1 := R1 xor R4;
       R4 := R4 or  R3; 
       R3 := R3 xor R2;
       R2 := R2 and R0; 
       R1 := R1 and R0;
       R4 := R4 xor R2; 
       R2 := R2 xor R3;
       R3 := R3  or R2; 
       R0 := R0 xor R4;
       R3 := R3 xor R1; 
       R1 := R1 xor R0;
       R0 := R0 or  R3; 
       R1 := R1 xor R2;
       R0 := R0 xor R2;
      --Permutation: 3 0 1 4 2

      R2  := W(28+0);
      R1  := R1  xor R2 ;
      R2  := W(28+1);
      R3  := R3  xor R2 ;
      R2  := W(28+2);
      R4  := R4  xor R2 ;
      R2  := W(28+3);
      R0  := R0  xor R2 ;


      R4 := Rotate_Right(R4, 22);
      R1 := Rotate_Right(R1, 5);
      R2 := Shift_Left(R3, 7);
      R4 := R4 xor R0;     
      R1 := R1 xor R3;
      R4 := R4 xor R2;
      R1 := R1 xor R0;
      R0 := Rotate_Right(R0, 7);
      R3 := Rotate_Right(R3, 1);
      R2 := Shift_Left(R1, 3);
      R0 := R0 xor R4;
      R3 := R3 xor R1;
      R0 := R0 xor R2;
      R3 := R3 xor R4;
      R4 := Rotate_Right(R4, 3);
      R1 := Rotate_Right(R1, 13);

--I6

      R1 := R1 xor R4; 
      R2 := R4;
      R4 := R4 and R1; 
      R2 := R2 xor R0;
      R4 := R4 xor -1; 
      R0 := R0 xor R3;
      R4 := R4 xor R0; 
      R2 := R2 or  R1;
      R1 := R1 xor R4; 
      R0 := R0 xor R2;
      R2 := R2 xor R3; 
      R3 := R3 and R0;
      R3 := R3 xor R1; 
      R1 := R1 xor R0;
      R1 := R1 or  R4; 
      R0 := R0 xor R3;
      R2 := R2 xor R1;
      --Permutation: 1 2 4 3 0       
 

      R1  := W(24+0);
      R3  := R3  xor R1 ;
      R1  := W(24+1);
      R4  := R4  xor R1 ;
      R1  := W(24+2);
      R2  := R2  xor R1 ;
      R1  := W(24+3);
      R0  := R0  xor R1 ;


      R2 := Rotate_Right(R2, 22);
      R3 := Rotate_Right(R3, 5);
      R1 := Shift_Left(R4, 7);
      R2 := R2 xor R0;     
      R3 := R3 xor R4;
      R2 := R2 xor R1;
      R3 := R3 xor R0;
      R0 := Rotate_Right(R0, 7);
      R4 := Rotate_Right(R4, 1);
      R1 := Shift_Left(R3, 3);
      R0 := R0 xor R2;
      R4 := R4 xor R3;
      R0 := R0 xor R1;
      R4 := R4 xor R2;
      R2 := Rotate_Right(R2, 3);
      R3 := Rotate_Right(R3, 13);

--I5

      R4 := R4 xor -1; 
      R1 :=  R0;
      R2 := R2 xor R4; 
      R0 := R0 or  R3;
      R0 := R0 xor R2; 
      R2 := R2 or  R4;
      R2 := R2 and R3; 
      R1 := R1 xor R0;
      R2 := R2 xor R1; 
      R1 := R1 or  R3;
      R1 := R1 xor R4; 
      R4 := R4 and R2;
      R4 := R4 xor R0; 
      R1 := R1 xor R2;
      R0 := R0 and R1; 
      R1 := R1 xor R4;
      R0 := R0 xor R3;
      R0 := R0 xor R1; 
      R1 := R1 xor -1;
       --Permutation: 1 4 3 2 0
	

      R3  := W(20+0);
      R4  := R4  xor R3 ;
      R3  := W(20+1);
      R1  := R1  xor R3 ;
      R3  := W(20+2);
      R0  := R0  xor R3 ;
      R3  := W(20+3);
      R2  := R2  xor R3 ;


      R0 := Rotate_Right(R0, 22);
      R4 := Rotate_Right(R4, 5);
      R3 := Shift_Left(R1, 7);
      R0 := R0 xor R2;     
      R4 := R4 xor R1;
      R0 := R0 xor R3;
      R4 := R4 xor R2;
      R2 := Rotate_Right(R2, 7);
      R1 := Rotate_Right(R1, 1);
      R3 := Shift_Left(R4, 3);
      R2 := R2 xor R0;
      R1 := R1 xor R4;
      R2 := R2 xor R3;
      R1 := R1 xor R0;
      R0 := Rotate_Right(R0, 3);
      R4 := Rotate_Right(R4, 13);

--I4

      R3 :=  R0; 
      R0 := R0 and R2;
      R0 := R0 xor R1; 
      R1 := R1 or  R2;
      R1 := R1 and R4; 
      R3 := R3 xor R0;
      R3 := R3 xor R1; 
      R1 := R1 and R0;
      R4 := R4 xor -1; 
      R2 := R2 xor R3;
      R1 := R1 xor R2; 
      R2 := R2 and R4;
      R2 := R2 xor R0; 
      R4 := R4 xor R1;
      R0 := R0 and R4; 
      R2 := R2 xor R4;
      R0 := R0 xor R3;
      R0 := R0 or  R2; 
      R2 := R2 xor R4;
      R0 := R0 xor R1;
      --Permutation: 0 3 2 4 1


      R1  := W(16+0);
      R4  := R4  xor R1 ;
      R1  := W(16+1);
      R2  := R2  xor R1 ;
      R1  := W(16+2);
      R0  := R0  xor R1 ;
      R1  := W(16+3);
      R3  := R3  xor R1 ;


      R0 := Rotate_Right(R0, 22);
      R4 := Rotate_Right(R4, 5);
      R1 := Shift_Left(R2, 7);
      R0 := R0 xor R3;     
      R4 := R4 xor R2;
      R0 := R0 xor R1;
      R4 := R4 xor R3;
      R3 := Rotate_Right(R3, 7);
      R2 := Rotate_Right(R2, 1);
      R1 := Shift_Left(R4, 3);
      R3 := R3 xor R0;
      R2 := R2 xor R4;
      R3 := R3 xor R1;
      R2 := R2 xor R0;
      R0 := Rotate_Right(R0, 3);
      R4 := Rotate_Right(R4, 13);

--I3

      R1 :=  R0; 
      R0 := R0 xor R2;
      R4 := R4 xor R0; 
      R1 := R1 and R0;
      R1 := R1 xor R4; 
      R4 := R4 and R2;
      R2 := R2 xor R3; 
      R3 := R3 or  R1;
      R0 := R0 xor R3; 
      R4 := R4 xor R3;
      R2 := R2 xor R1; 
      R3 := R3 and R0;
      R3 := R3 xor R2; 
      R2 := R2 xor R4;
      R2 := R2 or  R0; 
      R4 := R4 xor R3;
      R2 := R2 xor R1;
      R4 := R4 xor R2;
     --Permutation: 2 1 3 0 4


      R1  := W(12+0);
      R0  := R0  xor R1 ;
      R1  := W(12+1);
      R2  := R2  xor R1 ;
      R1  := W(12+2);
      R3  := R3  xor R1 ;
      R1  := W(12+3);
      R4  := R4  xor R1 ;


      R3 := Rotate_Right(R3, 22);
      R0 := Rotate_Right(R0, 5);
      R1 := Shift_Left(R2, 7);
      R3 := R3 xor R4;     
      R0 := R0 xor R2;
      R3 := R3 xor R1;
      R0 := R0 xor R4;
      R4 := Rotate_Right(R4, 7);
      R2 := Rotate_Right(R2, 1);
      R1 := Shift_Left(R0, 3);
      R4 := R4 xor R3;
      R2 := R2 xor R0;
      R4 := R4 xor R1;
      R2 := R2 xor R3;
      R3 := Rotate_Right(R3, 3);
      R0 := Rotate_Right(R0, 13);

--I2

      R3 := R3 xor R4; 
      R4 := R4 xor R0;
      R1 :=  R4; 
      R4 := R4 and R3;
      R4 := R4 xor R2; 
      R2 := R2 or  R3;
      R2 := R2 xor R1; 
      R1 := R1 and R4;
      R3 := R3 xor R4; 
      R1 := R1 and R0;
      R1 := R1 xor R3; 
      R3 := R3 and R2;
      R3 := R3 or  R0; 
      R4 := R4 xor -1;
      R3 := R3 xor R4; 
      R0 := R0 xor R4;
      R0 := R0 and R2; 
      R4 := R4 xor R1;
      R4 := R4 xor R0;
      --Permutation: 1 4 2 3 0

      R0  := W(8+0);
      R2  := R2  xor R0 ;
      R0  := W(8+1);
      R1  := R1  xor R0 ;
      R0  := W(8+2);
      R3  := R3  xor R0 ;
      R0  := W(8+3);
      R4  := R4  xor R0 ;


      R3 := Rotate_Right(R3, 22);
      R2 := Rotate_Right(R2, 5);
      R0 := Shift_Left(R1, 7);
      R3 := R3 xor R4;     
      R2 := R2 xor R1;
      R3 := R3 xor R0;
      R2 := R2 xor R4;
      R4 := Rotate_Right(R4, 7);
      R1 := Rotate_Right(R1, 1);
      R0 := Shift_Left(R2, 3);
      R4 := R4 xor R3;
      R1 := R1 xor R2;
      R4 := R4 xor R0;
      R1 := R1 xor R3;
      R3 := Rotate_Right(R3, 3);
      R2 := Rotate_Right(R2, 13);

--I1

      R0 :=  R1;  
      R1 := R1 xor R4;
      R4 := R4 and R1; 
      R0 := R0 xor R3;
      R4 := R4 xor R2; 
      R2 := R2 or  R1;
      R3 := R3 xor R4; 
      R2 := R2 xor R0;
      R2 := R2 or  R3; 
      R1 := R1 xor R4;
      R2 := R2 xor R1; 
      R1 := R1 or  R4;
      R1 := R1 xor R2; 
      R0 := R0 xor -1;
      R0 := R0 xor R1; 
      R1 := R1 or  R2;
      R1 := R1 xor R2;
      R1 := R1 or  R0;
      R4 := R4 xor R1;
      --Permutation: 4 0 3 2 1

      R1  := W(4+0);
      R0  := R0  xor R1 ;
      R1  := W(4+1);
      R2  := R2  xor R1 ;
      R1  := W(4+2);
      R4  := R4  xor R1 ;
      R1  := W(4+3);
      R3  := R3  xor R1 ;


      R4 := Rotate_Right(R4, 22);
      R0 := Rotate_Right(R0, 5);
      R1 := Shift_Left(R2, 7);
      R4 := R4 xor R3;     
      R0 := R0 xor R2;
      R4 := R4 xor R1;
      R0 := R0 xor R3;
      R3 := Rotate_Right(R3, 7);
      R2 := Rotate_Right(R2, 1);
      R1 := Shift_Left(R0, 3);
      R3 := R3 xor R4;
      R2 := R2 xor R0;
      R3 := R3 xor R1;
      R2 := R2 xor R4;
      R4 := Rotate_Right(R4, 3);
      R0 := Rotate_Right(R0, 13);

--I0

      R4 := R4 xor -1; 
      R1 := R2;
      R2 := R2 or  R0; 
      R1 := R1 xor -1;
      R2 := R2 xor R4; 
      R4 := R4 or  R1;
      R2 := R2 xor R3; 
      R0 := R0 xor R1;
      R4 := R4 xor R0; 
      R0 := R0 and R3;
      R1 := R1 xor R0; 
      R0 := R0 or  R2;
      R0 := R0 xor R4; 
      R3 := R3 xor R1;
      R4 := R4 xor R2; 
      R3 := R3 xor R0;
      R3 := R3 xor R2;
      R4 := R4 and R3;
      R1 := R1 xor R4;
      --Permutation: 0 4 1 3 2


      R4  := W(0+0);
      R0  := R0  xor R4 ;
      R4  := W(0+1);
      R1  := R1  xor R4 ;
      R4  := W(0+2);
      R2  := R2  xor R4 ;
      R4  := W(0+3);
      R3  := R3  xor R4 ;

end;
