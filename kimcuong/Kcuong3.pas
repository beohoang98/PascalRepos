uses crt, windows;

const
  canh=9;mau=7;
  style : array[1..3] of char = (#219,#15,#1);


type gem = record
      m : integer;
      kieu : char;
     end;

var  a : array[-1..canh,-1..canh] of gem;
     hole, gem2 : gem;
     c : char;
     i,j,x,y : integer;
     t,tx,ty : integer;
     diem,bonus : longint; s : string;
     time, start : longint;

procedure ngaunhien;
 var i,j : integer;
 begin

  for i:=0 to canh do
      begin
      a[i,0].kieu:=style[1];
      a[i,0].m:=random(mau)+1;
      end;
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
     write(a[i,j].kieu);
    end;
  textcolor(15);
  gotoxy(10,25);write('Diem : ',diem);
  gotoxy(10,26);write('x',bonus);
 end;

function xet(i,j: integer): byte;
 begin
  if a[i,j].m=0 then exit;
  xet:=0;
  if (i>1) and (i<canh) then
       if (a[i+1,j].m=a[i,j].m) and (a[i-1,j].m=a[i,j].m) then
        if (j>1) and (j<canh) then
         if (a[i,j+1].m=a[i,j].m) and (a[i,j-1].m=a[i,j].m) then
          xet:=3
         else xet:=1
        else xet:=1
       else
        if (j>1) and (j<canh) then
         if (a[i,j+1].m=a[i,j].m) and (a[i,j-1].m=a[i,j].m) then
          xet:=2
         else
        else
      else
       if (j>1) and (j<canh) then
        if (a[i,j+1].m=a[i,j].m) and (a[i,j-1].m=a[i,j].m) then
         xet:=2;

 end;

procedure no4(i,j: integer);
 var m,n : integer;
 begin
  a[i,j]:=hole;
  for m:=i-1 to i+1 do
   for n:=j-1 to j+1 do
    if (m>=1) and (m<=canh) and (n>=1) and (n<=canh) then
     if (a[m,n].kieu=style[2]) then no4(m,n)
     else a[m,n]:=hole;

  diem:=diem+6*bonus;
  hienthi;
  delay(50);
 end;

procedure no3(i,j,vt : integer);
 var m : integer;
 begin
  a[i,j]:=hole;
  if vt=1 then
  for m:=i-1 to i+1 do
   if (m>=1) and (m<=canh) then
    if a[m,j].kieu=style[2] then no4(m,j)
    else a[m,j]:=hole;
  if vt=2 then
  for m:=j-1 to j+1 do
   if (m>=1) and (m<=canh) then
    if a[i,m].kieu=style[2] then no4(i,m)
    else a[i,m]:=hole;
  diem:=diem+3*bonus;
  hienthi;
  delay(50);
 end;


procedure ktra ;
 var i,j,m : integer;
     trong : integer;
     vt : array[1..canh,1..canh] of byte;
 begin

  repeat
  fillchar(vt,sizeof(vt),0);
  for i:=1 to canh do
   for j:=1 to canh do
     vt[i,j]:=xet(i,j);



  for i:=1 to canh do
   for j:=1 to canh do
    case vt[i,j] of
      1 : begin

           no3(i,j,1);

           for m:=i-1 to i+1 do
            if (m>=1) and (m<=canh) and (m<>i) then
             if vt[m,j]<>0 then a[i,j]:=gem2;
           for m:=j-1 to j+1 do
            if (m>=1) and (m<=canh) and (m<>j) then
             if vt[i,m]=2 then a[i,j]:=gem2;
           if a[i,j].m=15 then inc(bonus);
          end;
      2 : begin

           no3(i,j,2);

           for m:=i-1 to i+1 do
            if (m>=1) and (m<=canh)and (m<>i) then
             if vt[m,j]=1 then a[i,j]:=gem2;
           for m:=j-1 to j+1 do
            if (m>=1) and (m<=canh) and (m<>j) then
             if vt[i,m]<>0 then a[i,j]:=gem2;
           if a[i,j].m=15 then inc(bonus);
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

procedure gameover;
 var f : text;
     i,j,t,vtri : longint;
     n : array[1..11] of longint;
 begin
  for i:=1 to canh do
   for j:=1 to canh do
    if a[i,j].kieu=style[2] then no4(i,j);
  ktra;
  delay(1000);
  textcolor(7);
  writeln('So diem cua ban la: ',diem);
  assign(f,'data.dat');reset(f);
  for i:=1 to 10 do
   readln(f,n[i]);
  close(f);
  n[11]:=diem;
  vtri:=11;
  for i:=1 to 10 do
   for j:=i+1 to 11 do
    if n[i]<n[j] then
     begin

      t:=n[i];n[i]:=n[j];n[j]:=t;
      if n[i]=diem then vtri:=i;
     end;
  writeln('ban dung thu ',vtri);
  for i:=1 to 10 do writeln(i,' : ',n[i]);
  assign(f,'data.dat');rewrite(f);
  for i:=1 to 10 do writeln(f,n[i]);
  close(f);
  readln;
  halt;
 end;


begin
 x:=2;y:=2;

 randomize;
 hole.kieu:=style[1];hole.m:=0;
 gem2.kieu:=style[2];gem2.m:=15;
 fillchar(a,sizeof(a),#219);
 for i:=1 to canh do
  for j:=1 to canh do
   a[i,j].m:=random(mau)+1;
 ktra;
 diem:=0;bonus:=1;
 clrscr;
 hienthi;
 start:=gettickcount;
 gotoxy(1,29);
 for i:=1 to 60 do write(#219);
 repeat

  gotoxy(x*2-1,y*2);textcolor(15);write(#222);
  gotoxy(x*2+1,y*2);textcolor(15);write(#221);
  gotoxy(x*2,y*2+1);write(#223);
  gotoxy(x*2,y*2-1);write(#220);

  repeat
   textcolor(15);
   time:=60000-(gettickcount-start);
   gotoxy(10,27);write(time div 60000,'p',time div 1000 mod 60000:2);
   gotoxy(time div 1000+1,29);textcolor(0);
   write(#219);
   if time<=0 then gameover;
  until keypressed;
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

 if x>canh then x:=canh;
 if x<1 then x:=1;
 if y>canh then y:=canh;
 if y<1 then y:=1;
 until c=#27;
end.
