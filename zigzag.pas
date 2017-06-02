var M,N : integer;
    x,y,i,d : integer;
    a : array[1..1000,1..1000] of word;

begin
 Write('Nhap M,N : ');readln(M,N);
 //M:=5;n:=5;
 i:=1;
 x:=1;
 y:=1;
 d:=1;
 while i<=M*n do
  begin
   a[x,y]:=i;
   inc(i);
   x:=x+d;
   y:=y-d;
    if (x<1) or (x>M) or (y<1) or (y>N) then d:=-d;
    if x>M then begin x:=M;y:=y+2; end;
    if y>N then begin y:=N;x:=x+2; end;
    if y<1 then y:=1;
    if x<1 then x:=1;
  end;

  for y:=1 to N do
  begin
   for x:=1 to M do write(a[x,y]:3);
   writeln;
  end;

 readln;

end.
