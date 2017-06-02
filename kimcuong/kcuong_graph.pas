uses wincrt in '..\src\wincrt.pas',
     windows,
     wingraph in '..\src\wingraph.pas',
     docbmp in '..\docbmp.pas';

const
  canh=10;mau=7;
  fileout='data2.dat';
  lim = 30;
  dir = '..\'   ;

var  a , b: array[-1..canh,-1..canh] of byte;

     c : char;
     i,j,x,y : integer;
     t,tx,ty : integer;
     diem,bonus : dword; s : string;
     time, start : longint;
     gd,gm : integer;
     p : array[0..mau] of diempic;

procedure ngaunhien;
 var i,j : integer;
 begin

  for i:=0 to canh do
    a[i,0]:=random(mau)+1;

 end;

procedure swap(var a,b : byte);
 var t : integer;
 begin
  t:=a; a:=b; b:=t;
 end;

procedure laptrong(var c: integer);
 var i,j,k : integer;
 begin
  c:=0;
  for i:=1 to canh do
   for j:=canh downto 1 do
    if a[i,j]=0 then
     begin
      inc(c);
      for k:=j downto 1 do swap(a[i,k],a[i,k-1]);

     end;

 end;

procedure hienthi;
 var i,j : integer; s:string;   k : dword;
 begin

  for i:=1 to canh do
   for j:=1 to canh do
    if (a[i,j]<>b[i,j]) then
    begin

     b[i,j]:=a[i,j];
     //for k:=1 to 2500 do
     //putpixel(k mod 50 + i*60,k div 50 +j*60,0);
     vepic(p[a[i,j]],i*60,j*60);
    end;
  setcolor(15);
  str(diem,s);outtextxy(10,25,'Diem : '+s);
  str(bonus,s);outtextxy(10,35,'x'+s);
  UpdateGraph(2);
 end;

function ke(i,j,di,dj : integer): integer;
 var m,n,t : integer;
 begin
  if a[i,j]=0 then exit(0);
  m:=i+di;n:=j+dj;
  if m<1 then m:=m+1;
  if m>canh then m:=m-1;
  if n<1 then n:=n+1;
  if n>canh then n:=n-1;
  if ((m=i) and (n=j)) or (a[m,n]<>a[i,j]) then exit(0);
  ke:=1+ke(m,n,di,dj);
  if ke>2 then exit(2);
 end;


procedure ktra ;
 var i,j,m : integer;
     trong : integer;
     vt : array[1..canh,1..canh] of integer;
 begin

  repeat
   fillchar(vt,sizeof(vt),0);
   for i:=1 to canh do
    for j:=1 to canh do
     vt[i,j]:=ke(i,j,1,0)+ke(i,j,0,1)+ke(i,j,-1,0)+ke(i,j,0,-1);


   for i:=1 to canh do
    for j:=1 to canh do
     begin
      if vt[i,j]>1 then diem:=diem+3*bonus;
      if vt[i,j]>=2 then a[i,j]:=0;

      if vt[i,j]>=3 then inc(bonus);
     end;
   ngaunhien;
   hienthi;
   delay(50);
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

function asd(n : integer):string;
 begin
  str(n,asd);
 end;

procedure gameover;
 var f : text; s:string;
     i,j,t,vtri : longint;
     n : array[1..11] of longint;
 begin


  ktra;
  delay(1000);
  setcolor(15);
  str(diem,s);outtextxy(1000,10,'So diem cua ban la: '+s);
  assign(f,fileout);reset(f);
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

  outtextxy(1000,20,'ban dung thu '+asd(vtri));
  for i:=1 to 10 do
   begin
    if i=vtri then setcolor(15) else setcolor(7);
    outtextxy(1000,20+i*10,asd(i)+' : '+asd(n[i]));
   end;
  assign(f,fileout);rewrite(f);
  for i:=1 to 10 do writeln(f,n[i]);
  close(f);
  readln;
  halt;
 end;


begin
 x:=2;y:=2;
 initgraph(gd,gm,'');
 randomize;      UpdateGraph(0);

 fillchar(a,sizeof(a),0);
 fillchar(b,sizeof(b),0);
 for i:=0 to mau do p[i]:=diemanh(dir+'kimcuong/gem/'+asd(i)+'.bmp',40,40);
 for i:=1 to canh do
  for j:=1 to canh do
   a[i,j]:=random(mau)+1;

 ktra;
 diem:=0;bonus:=1;

 hienthi;
 start:=gettickcount;
 //setviewport(0,0,100,20,false);
 s:='ллл';
 repeat
  setcolor($FFFFFF);
  outtextxy(x*60,y*60,#219);

  repeat
   //clearviewport;
   setcolor(0);
   outtextxy(10,10,asd(time div 60)+':'+asd(time mod 60)+s+s+s+s);
   setcolor(15);
   time:=lim-(gettickcount-start) div 1000;
   outtextxy(10,10,asd(time div 60)+':'+asd(time mod 60)+' '+asd(diem)+' '+asd(bonus));


   if time<=0 then gameover;

  until keypressed;
  UpdateGraph(2);
  c:=readkey;
  setcolor(0);
  outtextxy(x*60,y*60,#219);
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
 closegraph;
end.
