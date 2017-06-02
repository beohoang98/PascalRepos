uses crt;

const
  canh=10;mau=7;
  style = char=(#219,#15,#1);


type gem = record
      m : integer;
      kieu : char;
     end;

var  a : array[0..canh,0..canh] of gem;
     c : char;
     i,j,x,y : integer;
     t,tx,ty : integer;
     diem : longint; s : string;

procedure ngaunhien;
 var i,j : integer;
 begin

  for i:=0 to canh do
      a[i,0].m:=random(mau)+1;

 end;

procedure swap(var a,b : gem);
 var t : gem;
 begin
  t:=a; a:=b; b:=t;
 end;

procedure laptrong(var c: integer);
 var i,j,k : integer;
 begin
  c:=0;
  for i:=1 to canh do
   for j:=canh downto 1 do
    if a[i,j].m=0 then
     begin
      inc(c);
      for k:=j downto 1 do swap(a[i,k],a[i,k-1]);

     end;

 end;

procedure hienthi;
 var i,j : integer;
 begin

  for i:=1 to canh do
   for j:=1 to canh do
    begin

     gotoxy(i*2,j*2);textcolor(a[i,j].m);
     write(style(1));
    end;
  textcolor(15);
  gotoxy(10,25);write('Diem : ',diem);
 end;

procedure ktra ;
 var i,j : integer;
     trong : integer;
     vt : array[1..canh,1..canh] of byte;
 begin

  repeat
  fillchar(vt,sizeof(vt),0);
  for i:=1 to canh do
   for j:=1 to canh do
     begin
      if (i>1) and (i<canh) then
       if (a[i+1,j].m=a[i,j].m) and (a[i-1,j].m=a[i,j].m) then
        if (j>1) and (j<canh) then
         if (a[i,j+1].m=a[i,j].m) and (a[i,j-1].m=a[i,j].m) then
          vt[i,j]:=3
         else vt[i,j]:=1
        else vt[i,j]:=1
       else
        if (j>1) and (j<canh) then
         if (a[i,j+1].m=a[i,j].m) and (a[i,j-1].m=a[i,j].m) then
          vt[i,j]:=2
         else
        else
      else
       if (j>1) and (j<canh) then
        if (a[i,j+1].m=a[i,j].m) and (a[i,j-1].m=a[i,j].m) then
         vt[i,j]:=2;
     end;

   for i:=1 to canh do
    for j:=1 to canh do
     case vt[i,j] of
      1 : begin
           a[i,j].m:=0;
           a[i+1,j].m:=0;
           a[i-1,j].m:=0;
           diem:=diem+3;

          end;
      2 : begin
           a[i,j].m:=0;
           a[i,j-1].m:=0;
           a[i,j+1].m:=0;
           diem:=diem+3;

          end;
      3 : begin
           a[i,j].m:=0;
           a[i+1,j].m:=0;
           a[i-1,j].m:=0;
           a[i,j-1].m:=0;
           a[i,j+1].m:=0;
           diem:=diem+5;

          end;
     end;
    ngaunhien;
    laptrong(trong);
    hienthi;
   until trong=0;
 end;





procedure doi;
 var l,t1 : integer;
 begin
  t:=t+1;
  if t=1 then
   begin
    tx:=x;ty:=y;
    gotoxy(x*2,y*2);textcolor(a[x,y].m+8);
    write(style[1]);
   end
  else
   begin
    l:=round(sqrt(sqr(tx-x)+sqr(ty-y)));
    t1:=diem;
    if (l=1) then swap(a[tx,ty],a[x,y]);
    ktra;
    if t1=diem then swap(a[tx,ty],a[x,y]);
    t:=0;
    hienthi;
   end;
 end;

begin
 x:=2;y:=2;
 clrscr;
 randomize;
 for i:=0 to canh do a[i,1].m:=random(mau)+1;
 ktra;
 diem:=0;
 hienthi;
 repeat

  gotoxy(x*2-1,y*2);textcolor(15);write(#222);
  gotoxy(x*2+1,y*2);textcolor(15);write(#221);
  gotoxy(x*2,y*2+1);write(#223);
  gotoxy(x*2,y*2-1);write(#220);
  c:=readkey;
  gotoxy(x*2-1,y*2);textcolor(0);write(#222);
  gotoxy(x*2+1,y*2);textcolor(0);write(#221);
  gotoxy(x*2,y*2+1);write(#223);
  gotoxy(x*2,y*2-1);write(#220);
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
