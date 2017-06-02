Program DrawRecord;

Uses windows, wincrt, winmouse, RGBA;

Const DoDay=15; MauDF = $8820FF; DLMax = 1500000; tep='Data.draw';

Type Mou = Record
            X, Y : Word;
            Time : Word;
           End;
     MouRecord = array[1..DLMax] of Mou;
     MouMau = Array[1..DLMax] of boolean;
     MouPress = Array[1..DLMax] of boolean;

Var A : MouRecord;
    M : MouMau;
    P : MouPress;
    S : Longword;


Procedure GhiLai;
 Var X1,Y1, X, Y, But : Longint; SoMou : Longword;
     Mau: word; t : longword;
     Key : Char;
     MauCu,SoByte : Longword;
 Begin
  SoMou:=0;
  FillChar(A,Sizeof(A),0);
  FillChar(M,Sizeof(M),0);
  FillChar(P,Sizeof(P),0);

  X:=0; Y:=0; X1:=0; Y1:=0;
  Mau:=1;

  {Bam de bat dau ghi} Repeat Until GetMouseButtons=1;
  t:=GettickCount;
  Key:='5';

  Repeat
   SoByte:=(SoMou*2 shr 3+ SoMou*Sizeof(Mou)+ 4);
   WRiteln(SoMou, ' ',SoByte shr 10,'KB.',SoByte mod 1024);
   X:=GetMouseX;
   Y:=GetMouseY;
   But:=GetMouseButtons;
   If (X<>X1) or (Y<>Y1) then
    begin
     Inc(SoMou);
     A[SoMou].X:=X;
     A[SoMou].Y:=Y;
     A[SoMou].Time:=Gettickcount-t;
     M[SoMou]:=(Mau=1);
     P[SoMou]:=(But=1);
     If (But=1) Then
      If (Mau=1) Then FillTron(X,Y,5)
      Else FillTron(X,Y,DoDay);
     t:=Gettickcount;
     Screen;
    end;
   If Keypressed then key:=readkey;
   If (Key='a') and (Mau<>1) then
    Begin Mau:=1; ChonMau(MauDF,128); ENd;
   If (Key='s') and (Mau<>0) Then
    Begin Mau:=0; CHonMau(0,128); End;
   X1:=X; Y1:=Y;
  Until Key=#27;
  S:=SoMou;
 End;

Procedure PhatLai;
 Var i,SoMou : longword; Key: Char;
 Begin
  Xoa;
  WriteBuf('Hay~ ve~ te^n cua ba.n le^n man` hinh`');Screen;
  For i:=1 to S do
   Begin
    Repeat Until (GetMouseButtons=1);
    If Keypressed Then Key:=Readkey;
    If Key=#27 Then Exit;
    Delay(A[i].Time);
    SetMouseXY(A[i].X,A[i].Y);
    If P[i] Then
     If M[i] Then
      Begin
       ChonMau(MauDF,128);
       FillTron(A[i].X,A[i].Y,5)
      End
     Else
      Begin
       CHonMau(0,128);
       FillTron(A[i].X,A[i].Y,DoDay);
      End;
    Screen;
   End;
 End;

Procedure XuatRa(asd : String);
 Var F : File; i : longword;
     N1,N2 : array[1..DLMax div 8] of byte;
 begin
  Assign(f,asd); rewrite(f,1);
  Blockwrite(f,S,Sizeof(S));
  BlockWrite(f,A,S*Sizeof(Mou));
  For i:=0 to (S div 8) do
   begin
    N1[i+1]:=Byte(M[i*8+1])+Byte(M[i*8+2])*2
           +Byte(M[i*8+3])*4+Byte(M[i*8+4])*8
           +Byte(M[i*8+5])*16+Byte(M[i*8+6])*32
           +Byte(M[i*8+7])*64+Byte(M[i*8+8])*128;
    N2[i+1]:=Byte(P[i*8+1])+Byte(P[i*8+2])*2
           +Byte(P[i*8+3])*4+Byte(P[i*8+4])*8
           +Byte(P[i*8+5])*16+Byte(P[i*8+6])*32
           +Byte(P[i*8+7])*64+Byte(P[i*8+8])*128;
   end;
  BlockWrite(f,N1,S div 8+1);
  BlockWRite(f,N2,S div 8+1);
  Close(f);
 end;

Function Dich(N : Byte) : string;
 Var i : word;
 Begin
  DIch:='00000000';
  i:=1;
  While (N>0) do
   Begin
    If (N mod 2=0) Then Dich[i]:='0'
    Else Dich[i]:='1';
    inc(i);
    N:=N div 2;
   ENd;
 End;

Procedure Doc(asd: string);
 Var F: File; i: longword; j : byte;
     N1, N2 : array[1..DLMax div 8] of byte;
     S1, S2 : string[8];
 Begin
  Assign(f,asd); reset(f,1);
  Blockread(f,S,Sizeof(S));
  Blockread(f,A,S*Sizeof(Mou));
  BlockRead(f,N1,S div 8+1);
  BlockRead(f,N2,S div 8+1);
  For i:=0 to S div 8 do
   Begin
    S1:=Dich(N1[i+1]);
    S2:=Dich(N2[i+1]);
    For j:=1 to 8 do
     begin
      M[i*8+j]:=(S1[j]='1');
      P[i*8+j]:=(S2[j]='1');
     end;
   End;
  Close(f);
 End;

Begin
 KhoiTao(d8bit, m640x480);
 AAOn; UpOff; Xoa;
 ChonMau(MauDF,128);

 //GhiLai;
 //XuatRa(tep);

 Doc(tep);
 PhatLai;

 Tat;
 Repeat Until MessageBox(0,'Hay khong ban Au','',3)=IDYes;

End.
