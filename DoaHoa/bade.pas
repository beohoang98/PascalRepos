uses crt, graph;

var  ga,gb : integer;
     l,i,g : longint;
     c : char;
     x0,y0,z0,xg,yg,zg,n: longint;
     alp : real;
     r,cos1,cos2 : real;
     a,b : integer;
     x,y,z,lg : real;
     x1,y1,z1 : real;
     diem : array[0..1024,0..800] of real;
     diem2 : array[0..1000,0..800] of real;

procedure chuyen3d(var x,y,z : real);
 var  tx,ty,tz : real;
 begin
   {.............}
   tx:=x;
   x:= tx*cos(alp)-y*sin(alp) ;
   y:= -tx*sin(alp)-y*cos(alp) ;
   tz:=z;
   z:= z*cos(r)+y*sin(r);
   y:= tz*sin(r)-y*cos(r);
   {...}
 end;



procedure diem3d(x,y,z:real;n:integer);
 var gxen1,gxen2,len : real;
     x1,y1 : longint;
 begin
  if (n=0) then exit;
  if y>yg+5 then
   begin
   len:=sqrt(sqr(x-xg)+sqr(y-yg)+sqr(z-zg));
   x1:=x0+trunc((x-xg)*-yg/(y-yg));
   y1:=z0-trunc((z-zg)*-yg/(y-yg));
   if (x1<0) or (x1>1000) then exit;
   if (y1<0) or (y1>800) then exit;
   if (len>diem2[x1,y1]) and (diem2[x1,y1]<>0) then n:=0
   else diem2[x1,y1]:=len;
   end
  else n:=0;
  n:=n-trunc(len/10);
  n:=n*2;
  chuyen3d(x,y,z);


  if y<-l+10 then exit;
  x1:=x0+trunc(x*l/(y+l));
  y1:=z0-trunc(z*l/(y+l));
  if (x1<0) or (x1>1024) then exit;
  if (y1<0) or (y1>760) then exit;
  len:=sqrt(sqr(x)+sqr(y+l)+sqr(z));
  if (diem[x1,y1]<len) and (diem[x1,y1]<>0) then exit;
  diem[x1,y1]:=len;
  if n<=0 then n:=0;
  if n>255 then n:=255;
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
  diem3d(x,y,z,45);
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
begin
 ga:=0;
 gb:=m1024x768;

 initgraph(ga,gb,'D:\TP\BGI');l:=600;

 r:=15;
 x0:=500;y0:=0;z0:=300;
 xg:=0;yg:=-600;zg:=-200;
 g:=0;alp:=45;
 ClearViewPort;
 x1:=0;y1:=0;z1:=-1;
 repeat
  line3d(-500,0,0,500,0,0,l);
  line3d(0,-100,0,0,100,0,l);
  line3d(0,0,-100,0,0,100,l);
    n:=80;
   for g:=-1 to 2 do
   begin
    for a:=0 to 360 do
    for b:=0 to 360 do
     begin

     z:=sin(b*pi/(180))*(20+g);
     lg:=cos(b*pi/(180))*(20+g)+50;
     x:=cos(a*pi/(180))*lg;
     y:=sin(a*pi/(180))*lg;
     diem3d(x+100,y,z,n);

    end;


   for  a:=-1000 to 1000 do
    for b:=-300 to 300 do
     begin
      z:=((sin(a*0.015)+sin(b*0.03))*30);
      diem3d(a/3,b,z-g,(trunc(z) div 5+150));
     end;
   end;
   fillchar(diem,sizeof(diem),0);
   fillchar(diem2,sizeof(diem2),0);
  c:=readkey;
  case c of
   #72 : yg:=yg+15;
   #80 : yg:=yg-15;
   #75 : xg:=xg-15;
   #77 : xg:=xg+15;
   'w' : zg:=zg-5;
   's' : zg:=zg+5;
   '8' : r:=r+5*pi/180;
   '5' : r:=r-5*pi/180;
   '4' : alp:=alp-5*pi/180;
   '6' : alp:=alp+5*pi/180;
  end;
  cleardevice;
 until c='0';
 closegraph;
end.
