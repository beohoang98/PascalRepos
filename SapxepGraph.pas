Uses wincrt, rgba;

const n=16000; alpha=$4F;

Var a : array[0..n] of real;
    i : word;

Procedure VeDuong(i: word);
 var m : real;
 Begin
  m:=AlphaHT*(a[i]-trunc(a[i]));
  Line(i*800 div n,0,i*800 div n,trunc(a[i]));
  Diem(i*800 div n,trunc(a[i]+1),MauHt,trunc(m));
 End;

Procedure Inra;
 var i : word;
 Begin
  Xoa;
  For i:=0 to n do VeDUong(i);

  Screen;
 ENd;

Procedure Sort(l, r : integer);
 Var i, j : integer; x, t : real;
 Begin
  i:=l; j:=r;
  x:=a[(l+r) div 2];
  Repeat
   While (a[i]<x) do inc(i);
   While (a[j]>x) do dec(j);
   If Not(i>j) Then
    Begin
     ChonMau(0,$4F);
      VeDuong(i);
      VeDuong(j);
     t:=a[i]; a[i]:=a[j]; a[j]:=t;

     ChonMau($FFFFFF,alpha);
      VeDuong(i);
      VeDuong(j);

     Screen;
     inc(i);
     dec(j);
    End;

   If Keypressed Then Exit;
  Until (i>j);
  If (l<j) then Sort(l,j);
  If (i<r) then sort(i,r);
 End;

Begin
 KhoiTao(d8bit, m800x600); UpOff;
 Randomize;
 ChonMau($FFFFFF,alpha);
 For i:=0 to n do a[i]:=random(6000)/10;
 Inra;
 Sort(0,n);
 Inra;
 Repeat Until Keypressed;
 Tat;
End.