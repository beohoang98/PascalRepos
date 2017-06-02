uses crt, graph, ve3d;

type HsbRec = record
      H,S,B : smallint;
     end;
     RgbRec = record
      R,G,B : smallint;
     end;

var asd,dsa : integer;
    f : text;
    ngang,doc,alp : longint;
    i,j,n,x,y,z : longint;
    xa,ya,col : array[0..1000000] of integer;
    s1,c : char; s2 : string[4];
    s3 : char;
    n1 : hsbrec;
    n2 : rgbrec;
    co : array[-1..256] of integer;
    diem1 : array[0..1500,0..800] of integer;
procedure diem(x,y,n : longint);
 begin
  x:=x;
  y:=y;
  putpixel(x,y,n);
  putpixel(x+1,y,n);
  putpixel(x+1,y+1,n);
  putpixel(x,y+1,n);
 end;





procedure timmau;
 var c : char;
     x,y,n : integer;
     s : string;
 begin
  x:=10; y:=10;
  repeat
   n:=getpixel(x,y);
   str(diem1[x,y],s);
   setcolor(15);outtextxy(5,10,s);
   putpixel(x,y,15);
   c:=readkey;
   putpixel(x,y,n);
   setcolor(0);outtextxy(5,10,s);
   case c of
    #75 : x:=x-5;
    #77 : x:=x+5;
    #72 : y:=y-5;
    #80 : y:=y+5;
   end;
  until c=#27;
 end;

procedure docanh;
 var k: longint;
 begin
  k:=0;
  for j:=1 to doc do
   for i:=1 to ngang do
     begin
      read(f,s1);

       k:=k+1;
       n:=ord(s1) ;
       x:=i div 5;
       y:=j div 5;
       xa[k]:=x;
       ya[k]:=y;
       col[k]:=co[n];
     end;

 end;

procedure docmau;
 var a,i : integer;
 begin
  fillchar(co,sizeof(co),0);
  assign(f,'mau256.txt');reset(f);
  i:=1;
  repeat
   readln(f,a);
   co[a]:=i;
   i:=i+1;
  until a=-1;
  co[0]:=0;
  for i:=1 to 256 do
   if co[i]=0 then co[i]:=co[i-1];
  close(f);
 end;

begin
 clrscr;
 initgraph(asd,dsa,'');
 khoitao(500,0,300,0,-100,0,1000);
 docmau;
 alp:=30;
 assign(f,'wc2014.bmp');reset(f);
 {co[0]:=0;
 co[1]:=4; co[2]:=2;
 co[3]:=6; co[4]:=1;
 co[5]:=5; co[6]:=3;
 co[7]:=8; co[8]:=7;
 co[9]:=12; co[10]:=10;
 co[11]:=11; co[12]:=9;
 co[13]:=13; co[14]:=14;
 co[15]:=15; co[16]:=16;}
 for i:=1 to 17 do read(f,s1);
 read(f,s2);
 ngang:=ord(s2[1])+ord(s2[2])*16+ord(s2[3])*256;
 read(f,s2);
 doc:=ord(s2[1])+ord(s2[2])*16+ord(s2[3])*256;
 doc:=doc div 4;
 for i:=26 to 54+ngang do read(f,s1);

  docanh;
 close(f);
 repeat
  xoay(alp,15);
  n:=0;
  for i:=1 to doc do
   for j:=ngang downto 1 do
    begin
     z:=trunc(200*sin(i*pi/(180*8)));

     x:=trunc(200*cos(-j*pi/1800)*cos(i*pi/(180*8)));
     y:=trunc(200*sin(-j*pi/1800)*cos(i*pi/(180*8)));
     n:=n+1;
     ve3d.diem(x,y,z,col[n]);
     ve3d.diem(x,y,-z,col[n]);
    end;
  c:=readkey;

   if c= #75 then alp:=alp+5;
   if c= #77 then alp:=alp-5;

  cls;
 until c=#27;
 closegraph;
end.
