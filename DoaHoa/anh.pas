uses crt, wingraph in 'src/wingraph.pas', ve3d;



var asd,dsa : integer;
    f : textfile;
    ngang,doc,alp : longint;
    i,j,n,x,y,z,r : longint;
    xa,ya,co1,co2,co3 : array[0..1000000] of integer;
    c : char; s2 : string[4];
    s3 : char;
    s : char;
    co : array[-1..256] of integer;

procedure diem(x,y,z,n : longint);
 begin
  x:=x;
  y:=y;
  ve3d.diem(x,y,z,n);
  ve3d.diem(x+1,y,z,n);
  ve3d.diem(x+1,y+1,z,n);
  ve3d.diem(x,y+1,z,n);
  ve3d.diem(x,y,z+1,n);
  ve3d.diem(x+1,y,z+1,n);
  ve3d.diem(x+1,y+1,z+1,n);
  ve3d.diem(x,y+1,z+1,n);
 end;







procedure docanh;
 var k,t: longint;  s: char;
 begin
  k:=0;
  for j:=1 to doc do
   for i:=1 to ngang do
     begin
      inc(k);
      read(f,s);
      co1[k]:=ord(s);
      read(f,s);
      co2[k]:=ord(s);
      read(f,s);
      co3[k]:=ord(s);


       n:=t;
       x:=i div 5;
       y:=j div 5;
       xa[k]:=x;
       ya[k]:=y;


     end;

 end;

procedure docmau;
 var a,i : integer;   f : text;
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
 asd:=nopalette; dsa:=10;
 initgraph(asd,dsa,'');
 khoitao(500,0,300,0,-100,0,5000);
 //docmau;
 alp:=30;
 assign(f,'map2.bmp');reset(f);
 {co[0]:=0;
 co[1]:=4; co[2]:=2;
 co[3]:=6; co[4]:=1;
 co[5]:=5; co[6]:=3;
 co[7]:=8; co[8]:=7;
 co[9]:=12; co[10]:=10;
 co[11]:=11; co[12]:=9;
 co[13]:=13; co[14]:=14;
 co[15]:=15; co[16]:=16;}
 for i:=1 to 18 do read(f,s);
 read(f,s2);
 ngang:=ord(s2[1])+ord(s2[2])*256+ord(s2[3])*65536;
 read(f,s2);
 doc:=ord(s2[1])+ord(s2[2])*256+ord(s2[3])*65536;

 doc:=doc;
 for i:=27 to 54+ngang do read(f,s);

  docanh;
 close(f);
 repeat
  xoay(alp+180,15);

  for r:=150 downto 145 do
   begin
   n:=0;
   for i:=-doc div 2 to doc-doc div 2 do
   for j:=ngang downto 1 do
    begin
     z:=trunc(r*sin(i*pi/doc));

     x:=trunc(r*cos(-(j)*2*pi/ngang)*cos(i*pi/doc));
     y:=trunc(r*sin(-(j)*2*pi/ngang)*cos(i*pi/doc));
     n:=n+1;

     diem(x,y,z,co[1]);

    end;
   end;
  c:=readkey;

   if c= #75 then alp:=alp+5;
   if c= #77 then alp:=alp-5;

  cls;
 until c=#27;
 closegraph;
end.
