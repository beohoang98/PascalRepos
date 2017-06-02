uses crt, graph, dos;

const xm=1366;
      ym=768;

var  ga,gb,mau : integer;
     l,i,g : longint;
     c : char;
     x0,y0,z0,xg,yg,zg,n: longint;
     alp : real;
     r,cos1,cos2 : real;
     a,b : integer;
     x,y,z : integer;
     x1,y1,z1,lg : real;
     diem : array[0..xm,0..ym] of real;
     diem2 : array[-2000..2000,-1000..1000] of real;
     asd : array[-300..300,-300..300,-300..300] of integer;

procedure chuyen3d(var x,y,z : real);
 var  tx,ty,tz : real;
 begin
   {.............}
   tx:=x;
   x:= tx*cos(alp*pi/180)+y*sin(alp*pi/180) ;
   y:= tx*sin(alp*pi/180)-y*cos(alp*pi/180) ;
   tz:=z;
   z:= z*cos(r*pi/180)-y*sin(r*pi/180);
   y:= -tz*sin(r*pi/180)-y*cos(r*pi/180);
   {...}
 end;

function timgoc(x,y: real): real;
 begin
  if trunc(x)=0 then
   if y>0 then exit(pi/2)
   else exit(-pi/2);
  if x>0 then
   exit(arctan(y/x))
   else exit(arctan(y/x)+pi);
 end;

procedure diem3d(x,y,z:real;n:integer);
 var gxen1,gxen2,len : real;
     x1,y1 : longint;
 begin
  if (n=0) then exit;
   gxen1:=timgoc(y-yg,x-xg);
   gxen2:=timgoc(y-yg,z-zg);
   x1:=trunc(gxen1*yg) ;
   y1:=trunc(gxen2*yg) ;
   if (x1>=-2000) and (x1<=2000) and (y1>=-1000) and (y1<=1000) then
    begin
     len:=sqrt(sqr(x-xg)+sqr(y-yg)+sqr(z-zg));
     //if len<500 then if len<450 then n:=n+48 else n:=n+24;
     if (len>diem2[x1,y1]) and (diem2[x1,y1]<>0) then n:=n-72
     else diem2[x1,y1]:=len;


    end
   else n:=n+144;
  chuyen3d(x,y,z);
  n:=trunc(n*4-len);

  if y<-l+10 then exit;
  x1:=x0+trunc(x*l/(y+l));
  y1:=z0-trunc(z*l/(y+l));
  if (x1<0) or (x1>xm) then exit;
  if (y1<0) or (y1>ym) then exit;
  len:=sqrt(sqr(x)+sqr(y+l)+sqr(z));
  if (diem[x1,y1]<len) and (diem[x1,y1]<>0) then exit;
  diem[x1,y1]:=len;
  if n>255 then n:=255;
  if n<0 then n:=0;
  setRGBpalette(1,n,n,n);
  putpixel(x1,y1,1);

 end;

procedure line3d(x1,y1,z1,x2,y2,z2,l:REAL);
 var x,y,z : longint;
     len : real;
 begin
  len:=sqrt(sqr(x2-x1)+sqr(y2-y1)+sqr(z2-z1));
  if len<=1 then exit;
  x:=trunc((x1+x2)/2);
  y:=trunc((y1+y2)/2);
  z:=trunc((z1+z2)/2);
  if (x>300) or (x<-300) then exit;
  if (y>300) or (y<-300) then exit;
  if (y>300) or (y<-300) then exit;
  asd[x,y,z]:=mau;
  line3d(x1,y1,z1,x,y,z,l);
  line3d(x,y,z,x2,y2,z2,l);
 end;

procedure box(x,y,z,d,r,h,l:longint);
 begin

  line3d(x,y,z,x+d,y,z,l);line3d(x,y,z,x,y+r,z,l);line3d(x,y,z,x,y,z+h,l);
  line3d(x+d,y,z,x+d,y+r,z,l);line3d(x+d,y,z,x+d,y,z+h,l);
  line3d(x,y+r,z,x+d,y+r,z,l);line3d(x,y+r,z,x,y+r,z+h,l);
  line3d(x,y,z+h,x+d,y,z+h,l);line3d(x,y,z+h,x,y+r,z+h,l);
  line3d(x+d,y+r,z,x+d,y+r,z+h,l);line3d(x+d,y,z+h,x+d,y+r,z+h,l);
  line3d(x,y+r,z+h,x+d,y+r,z+h,l);
 end;

procedure xetZ(x,y : integer);
 var z : integer;
 begin
  if zg>=300 then
    for z:=300 downto -300 do
      diem3d(x,y,z,asd[x,y,z]);
  if (zg<300) and (zg>-300) then
    begin
     for z:=zg to 300 do diem3d(x,y,z,asd[x,y,z]);
     for z:=zg downto -300 do diem3d(x,y,z,asd[x,y,z]);
    end;
  if zg<=-300 then for z:=-300 to 300 do
    diem3d(x,y,z,asd[x,y,z]);
 end;

procedure  xetY(x: integer);
 var y : integer;
 begin
  if yg>=300 then
      for y:=300 downto -300 do
       xetZ(x,y);
  if yg<=-300 then
      for y:=-300 to 300 do xetZ(x,y);
  if (yg<300) and (yg>-300) then
      begin
       for y:=yg to 300 do xetZ(x,y);
       for y:=yg downto -300 do xetZ(x,y);
      end;
 end;

procedure screen;
 var x : integer;
 begin
  if xg>=300 then
   for x:=300 downto -300 do
    xetY(x);
  if xg<=-300 then
   for x:=-300 to 300 do xetY(x);
  if (xg<300) and (xg>-300) then
   begin
    for x:=xg to 300 do xetY(x);
    for x:=xg downto -300 do xetY(x);
   end;

 end;


begin
 ga:=0;
 gb:=m1024x768;

 initgraph(ga,gb,'D:\TP\BGI');l:=6000;

 r:=10;
 x0:=xm div 2;y0:=0;z0:=ym div 2;
 xg:=0;yg:=-500;zg:=250;
 g:=0;alp:=20;
 ClearViewPort;
 x1:=0;y1:=0;z1:=-1;

  mau:=55;
  line3d(-500,0,0,500,0,0,l);
  line3d(0,-100,0,0,100,0,l);
  line3d(0,0,-100,0,0,100,l);
   for i:=10 to 20 do
    for a:=180 to 540 do
    for b:=0 to 720 do
     begin

      z:=trunc(sin(b*pi/(360))*i);
      lg:=cos(b*pi/(360))*i+50;
      x:=trunc(cos(a*pi/(360))*lg);
      y:=trunc(sin(a*pi/(360))*lg);
       if (x-100>-300) and (x+100<300) and (y+100<300) and (y>-300)
        and (z-20>-300) and (z-20<300) then
        begin
       asd[x-100,y-100,b div 3]:=132+i;asd[-x-100,y-100,b div 3]:=132+i;
       asd[x+100,y,z+20]:=140+i;asd[-x+100,y,z+20]:=140+i;
        end;
     end;
   mau:=146;
   for a:=200 downto -200 do
    line3d(-500,a,0,500,a,0,l);
   mau:=155;
   for a:=200 downto -200 do
    line3d(-500,100,a,500,100,a,l);
  repeat
   screen;
   for a:=0 to 36 do
    for b:=-9 to 9 do
     begin
      z:=trunc(sin(b*pi/(18))*10)+zg;
      lg:=cos(b*pi/(18))*10;
      x:=trunc(cos(a*pi/(18))*lg)+xg;
      y:=trunc(sin(a*pi/(18))*lg)+yg;
      diem3d(x,y,z,15);
     end;
   fillchar(diem,sizeof(diem),0);
   fillchar(diem2,sizeof(diem2),0);

  c:=readkey;
  case c of
   #72 : yg:=yg+50;
   #80 : yg:=yg-50;
   #75 : xg:=xg-50;
   #77 : xg:=xg+50;
   'w' : zg:=zg-50;
   's' : zg:=zg+50;
   '8' : r:=r+5;
   '5' : r:=r-5;
   '4' : alp:=alp-5;
   '6' : alp:=alp+5;
  end;
  clearviewport;
 until c='0';
 closegraph;
end.
