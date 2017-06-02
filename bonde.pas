uses crt, wingraph in 'src/wingraph.pas', ve3d, windows;

const x0=500; y0=300;

var gd, gm : integer;
    a,b,c,d,i,j,k: integer;
    mau: byte;
    ch : char;
    x1,y1,z1,t1,x2,y2,z2,t2,l1,l2 : real;
    t : array[0..10] of TPoint;

procedure chuyen4d(var x,y,z,t : real);
 var x1,y1,z1,t1 : real;
 begin
  z1:=z;y1:=y;t1:=t;x1:=x;
  x:=x1*cos(a*pi/180)+t1*sin(a*pi/180);
  t:=x1*sin(a*pi/180)-t1*cos(a*pi/180);
  t1:=t;
  y:=y1*cos(b*pi/180)+t1*sin(b*pi/180);
  t:=y1*sin(b*pi/180)-t1*cos(b*pi/180);
  t1:=t;
  z:=z1*cos(c*pi/180)+t1*sin(c*pi/180);
  t:=z1*sin(c*pi/180)-t1*cos(c*pi/180);
 end;

function tinh(x,y : real): real;
 var gx : real;
 begin
  if y+500=0 then
   if x>=0 then gx:=pi/2 else
   else gx:=-pi/2;
  if y+500>0 then gx:=arctan(x/(y+500))
  else gx:=arctan(x/(y+500))+pi;
  tinh:=gx*300;
 end;

procedure diem4d(x,y,z,t : real);
 var x1,y1,z1 : real;
 begin
  chuyen4d(x,y,z,t);
  x1:=(x*600)/(t+600);
  y1:=(y*600)/(t+600);
  z1:=(z*600)/(t+600);
  diem(x1,y1,z1,mau);

 end;

procedure line4d(x1,y1,z1,t1,x2,y2,z2,t2 : real);
 var xm1,ym1,zm1,xm2,ym2,zm2 : real;
 begin
  chuyen4d(x1,y1,z1,t1);
  chuyen4d(x2,y2,z2,t2);
  xm1:=tinh(x1,t1);ym1:=tinh(y1,t1);zm1:=tinh(z1,t1);
  xm2:=tinh(x2,t2);ym2:=tinh(y2,t2);zm2:=tinh(z2,t2);
  chuyen3d(xm1,ym1,zm1);
  chuyen3d(xm2,ym2,zm2);
  line(trunc(500+xm1),trunc(300-zm1),trunc(500+xm2),trunc(300-zm2));
 end;

begin
 initgraph(gd,gm,'');
 khoitao(500,0,300,0,0,0,300);
 UpdateGraph(0);
 mau:=15;
 a:=0;b:=0; color(15);
 xoay(30,30);
 repeat
  {for i:=0 to 80 do
   for j:=0 to 80 do
    begin
     t1:=0;
     z1:=100*sin(j*pi/40);
     l2:=100*cos(j*pi/40)+200;
     x1:=l2*cos(i*pi/40);
     y1:=l2*sin(i*pi/40);

     line4d(x1,y1,z1,t1,x2,y2,z2,t2);
     x2:=x1;y2:=y1;z2:=z1;t2:=t1;
    end;}
  cls;
  for k:=0 to 1 do
   for i:=0 to 1 do
    begin
    line4d(100,100,i*200-100,k*200-100,-100,100,i*200-100,k*200-100);
    line4d(-100,100,i*200-100,k*200-100,-100,-100,i*200-100,k*200-100);
    line4d(100,-100,i*200-100,k*200-100,100,100,i*200-100,k*200-100);
    line4d(-100,-100,i*200-100,k*200-100,100,-100,i*200-100,k*200-100);
    end;
   for i:=0 to 1 do
   begin
   line4d(100,100,100,i*200-100,100,100,-100,i*200-100);
   line4d(-100,100,100,i*200-100,-100,100,-100,i*200-100);
   line4d(-100,-100,100,i*200-100,-100,-100,-100,i*200-100);
   line4d(100,-100,100,i*200-100,100,-100,-100,i*200-100);
   end;
   for i:=0 to 1 do
   begin
    line4d(100,100,i*200-100,100,100,100,i*200-100,-100);
    line4d(-100,100,i*200-100,100,-100,100,i*200-100,-100);
    line4d(-100,-100,i*200-100,100,-100,-100,i*200-100,-100);
    line4d(100,-100,i*200-100,100,100,-100,i*200-100,-100);
   end;

 {ch:=readkey;
  case ch of
   #75 : a:=a+10;
   #77 : a:=a-10;
   #72 : b:=b+10;
   #80 : b:=b-10;
   'w' : c:=c+10;
   's' : c:=c-10;
   'a' : d:=d+10;
   'd' : d:=d-10;
  end;   }
 b:=b+1;
 if b>=360 then b:=0;
 a:=a+1;
 if a>=360 then a:=0;

 UpdateGraph(2);
 delay(1);



 until keypressed;//ch='0';
 closegraph;

end.
