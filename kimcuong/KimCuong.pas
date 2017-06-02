uses crt;

const
  canh=10;mau=7;

var  a : array[0..canh,0..canh] of integer;
     c : char;
     i,j,x,y : integer;
     t,tx,ty : integer;

procedure ngaunhien;
 var i,j : integer;
 begin

  for i:=0 to canh do
      a[i,0]:=random(mau)+1;

 end;

procedure swap(var a,b : integer);
 var t : integer;
 begin
  t:=a; a:=b; b:=t;
 end;

procedure laptrong;
 var i,j,k : integer;
 begin
  for i:=canh downto 1 do
   for j:=canh downto 1 do
    if a[i,j]=0 then
      for k:=j downto 1 do swap(a[i,k],a[i,k-1]);

 end;

procedure xetdoc;
 var i,j , t, c, k : integer;
 begin
  t:=0;
  for i:=1 to canh do
   begin
    c:=1;
    for j:=1 to canh do
     begin
      if a[i,j]=t then c:=c+1 else c:=1;
      if c=3 then
       for k:=0 to 2 do a[i,j-k]:=0;
      t:=a[i,j];
     end;
   end;

 end;

procedure xetngang;
 var i,j , t, c, k : integer;
 begin
  t:=0;
  for j:=canh downto 1 do
   begin
    c:=1;
    for i:=1 to canh do
     begin
      if (a[i,j]=t) and (t<>0) then c:=c+1 else c:=1;
      if c=3 then
       for k:=0 to 2 do a[i-k,j]:=0;
      t:=a[i,j];
     end;
   end;

 end;

procedure hienthi;
 var i,j : integer;
 begin

  for i:=1 to canh do
   for j:=1 to canh do
    begin

     gotoxy(i*2,j*2);textcolor(a[i,j]);
     write(#219);
    end;
 end;

procedure doi;
 var l : integer;
 begin
  t:=t+1;
  if t=1 then begin tx:=x;ty:=y; end
  else
   begin
    l:=round(sqrt(sqr(tx-x)+sqr(ty-y)));
    if l=1 then swap(a[tx,ty],a[x,y]);
    t:=0;
   end;
 end;

begin
 x:=2;y:=2;
 clrscr;
 randomize;
 for i:=0 to canh do a[i,1]:=random(mau)+1;
 repeat
  repeat
   xetdoc;
   xetngang;
   ngaunhien;
   laptrong;
   hienthi;
   gotoxy(x*2,y*2);textcolor(12);write(#219);
   delay(20);
  until keypressed;
 c:=readkey;
  case c of
   #75 : x:=x-1;
   #77 : x:=x+1;
   #72 : y:=y-1;
   #80 : y:=y+1;
   'a' : doi;

  end;
 if x>10 then x:=10;
 if x<1 then x:=1;
 if y>10 then y:=10;
 if y<1 then y:=1;
 until c=#27;
end.