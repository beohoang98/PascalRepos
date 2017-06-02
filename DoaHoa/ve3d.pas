UNIT VE3D;



interface
 procedure khoitao(x,y,z,z1,z2,z3,l0:longint);
 procedure chuyen3d(var x,y,z: real);
 function tinh(x,y: double):double;
 procedure xoay(gx,gy : longint);
 procedure diem(x,y,z:double;n:integer);
 procedure line3d(x1,y1,z1,x2,y2,z2:double);
 procedure line3dto(x,y,z: double);
 procedure box(x,y,z,d,r,h:double);
 procedure cau(x,y,z,n:real);
 procedure color(n : integer);
 procedure cls;

Implementation

 Uses crt, wingraph in 'src/wingraph.pas';

 Var x0,y0,z0,xg,yg,zg,l: longint;
     r1,r2, alp1,alp2 : real;
     mau : word;
     diem3d : array[0..1024,0..768] of real;
 procedure khoitao(x,y,z,z1,z2,z3,l0:longint);
  var asd,dsa : integer;
  begin
   x0:=x;y0:=y;z0:=z;l:=l0;
   xg:=z1;yg:=z2;zg:=z3;

   mau:=7;
  end;

 procedure xoay(gx, gy: longint);
  begin
   fillchar(diem3d,sizeof(diem3d),0);
   r1:=cos(gy*pi/180);r2:=sin(gy*pi/180);
   alp1:=cos(gx*pi/180);alp2:=sin(gx*pi/180);
  end;

 procedure chuyen3d(var x,y,z : real);
 var  tx,ty,tz : real;
 begin
   tx:=x;ty:=y;
   x:=tx*alp1+y*alp2 ;
   y:=tx*alp2-y*alp1 ;
   tz:=z;
   z:= z*r1-y*r2;
   y:=-tz*r2-y*r1;
 end;

function tinh(x,y : double):double;
 begin
  if y<-l+5 then exit(0);
  exit((x*l)/(y+l));
 end;

procedure diem(x,y,z : double; n : integer);
  var x1,y1 : longint;
      len : real;
  begin
  if n=0 then exit;
  x:=x+xg;y:=y-yg;z:=z+zg;
  chuyen3d(x,y,z);
  len:=sqrt(sqr(x)+sqr(z)+sqr(y+l));
  if y<=-l then exit;
  x1:=trunc(tinh(x,y)+x0);
  y1:=trunc(z0-tinh(z,y));
  if (x1<0) or (x1>1024) then exit;
  if (y1<0) or (y1>768) then exit;
  if (diem3d[x1,y1]<len) and (diem3d[x1,y1]<>0) then exit;

  diem3d[x1,y1]:=len;
  putpixel(x1,y1,n);
  end;

 procedure line3d(x1,y1,z1,x2,y2,z2:double);
  var x,y,z,l : double;

  begin
   l:=sqrt(sqr(x1-x2)+sqr(y1-y2)+sqr(z1-z2));
   if l<=1 then exit;
   x:=(x1+x2)/2;
   y:=(y1+y2)/2;
   z:=(z1+z2)/2;
   diem(x,y,z,mau);
   line3d(x,y,z,x1,y1,z1);
   line3d(x,y,z,x2,y2,z2);
  end;

 procedure box(x,y,z,d,r,h:double);
  var i,w : integer;
  begin
   for i:=0 to 1 do
    begin
    line3d(x,y,z+i*h,x+d,y,z+i*h);
    line3d(x,y,z+i*h,x,y+r,z+i*h);
    line3d(x+d,y,z+i*h,x+d,y+r,z+i*h);
    line3d(x,y+r,z+i*h,x+d,y+r,z+i*h);
    end;
  end;

 procedure line3dto(x,y,z:double);
  var x1,y1 : double;
  begin
   chuyen3d(x,y,z);
   x:=x+xg;y:=y+yg;z:=z+zg;
   if y<=-l+5 then exit;
   x1:=tinh(x,y);
   y1:=tinh(z,y);
   lineto(trunc(x0+x1),trunc(z0-y1));
  end;

 procedure cau(x,y,z,n:real);
  var x1,y1,z1 : real;
      i,j,m : integer;
  begin
   for i:=0 to 10 do
    for j:=-9 to 9 do
     begin
      z1:=sin(j*pi/18)*n+z;
      x1:=cos(j*pi/18)*cos(i*pi/5)*n+x;
      y1:=cos(j*pi/18)*sin(i*pi/5)*n+y;

      diem(x1,y1,z1,mau);

     end;
  end;

 procedure color(n : integer);
 begin
  mau:=n;
 end;

 procedure cls;
  begin
   cleardevice;
   fillchar(diem3d,sizeof(diem3d),0);
  end;


begin

end.




