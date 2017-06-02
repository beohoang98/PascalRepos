uses crt, graph;

var  a,b : integer;
     l,i,g : integer;
     c : char;
     x0,y0,z0,xg,yg,zg: longint;
     alp : real;
     r : real;




procedure diem(x,y,z,l:longint);
 var x1,y1 : longint;
 begin

  x1:=(x*l) div (y+l);
  y1:=(z*l) div (y+l);
  setcolor(white);

  putpixel(x0+x1,z0-y1,7);
 end;

procedure line3d(x1,y1,z1,x2,y2,z2,l:REAL);
 var x,y,x3,y3: REAL;
     tx, ty, tz : REAL;
 begin
  x1:=x1+xg;y1:=y1+yg;z1:=z1+zg;
  x2:=x2+xg;y2:=y2+yg;z2:=z2+zg;

   tx:=x1;ty:=y1;tz:=z1;
   y1:= tz*sin(0)-ty*cos(0) ;
   z1:= tz*cos(0)+ty*sin(0) ;
   x1:= tx*cos(alp)+y1*sin(alp) ;
   y1:= tx*sin(alp)-y1*cos(alp) ;
   tz:=z1;
   z1:= z1*cos(r)+y1*sin(r);
   y1:= tz*sin(r)-y1*cos(r);
   {...}
   tx:=x2;ty:=y2;tz:=z2;
   y2:= tz*sin(0)-ty*cos(0);
   z2:= tz*cos(0)+ty*sin(0);
   x2:= tx*cos(alp)+y2*sin(alp) ;
   y2:= tx*sin(alp)-y2*cos(alp) ;
   tz:=z2;
   z2:= z2*cos(r)+y2*sin(r);
   y2:= tz*sin(r)-y2*cos(r);
   {......}
  if y1<>-l then x:=(x1*l)/(y1+l);
  if y1<>-l then y:=(z1*l)/(l+y1);
  if y2<>-l then begin
   x3:=(x2*l)/(l+y2);
   y3:=(z2*l)/(l+y2);
   end;
  line(trunc(x0+x),trunc(z0-y),trunc(x0+x3),trunc(z0-y3));
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
 initgraph(a,b,'D:\TP\BGI');l:=500;
 r:=0;
 x0:=300;y0:=200;z0:=300;
 xg:=0;yg:=0;zg:=0;
 g:=0;alp:=0;
 repeat
  line3d(-100-xg,0-yg,0-zg,100-xg,0-yg,0-zg,l);
  line3d(0-xg,-100-yg,0-zg,0-xg,100-yg,0-zg,l);
  line3d(0-xg,0-yg,-100-zg,0-xg,0-yg,100-zg,l);
  repeat
   setcolor(7);
   box(30,20,-20,50,40,25,l);
   box(30,25,-20,50,20,40,l);
   line3d(30,25,20,30,20,5,l);
   line3d(80,25,20,80,20,5,l);
   line3d(30,60,5,30,45,20,l);
   line3d(80,60,5,80,45,20,l);
   delay(30);
  until keypressed;
   cleardevice;
  c:=readkey;
  if c=#72 then yg:=yg+5;
  if c=#80 then yg:=yg-5;
  if c=#75 then xg:=xg-5;
  if c=#77 then xg:=xg+5;
  if c='w' then zg:=zg-5;
  if c='s' then zg:=zg+5;
  if c='8' then r:=r+pi/180;
  if c='5' then r:=r-pi/180;
  if c='4' then alp:=alp-pi/180;
  if c='6' then alp:=alp+pi/180;
 until c='0';
 closegraph;
end.
