program BezierCurve;

uses wincrt, wingraph, winmouse;

type ptype = record
              x,y : longint;
             end;

var gd,gm : smallint;
    a,b,c : ptype;
    but : longint;

Function Goc(x,y : integer): real;
 begin
  if x=0 then
   if y>=0 then exit(pi/2)
   else exit(-pi/2);
  if x>0 then exit(arctan(y/x))
  else
   exit(arctan(y/x)-pi);

 end;

Procedure QBezier(a,b,c : ptype);
 var t: real; x,y,xx,yy : real;
 begin
  moveto(c.x,c.y);
  t:=0;
  repeat
   xx:=x;
   yy:=y;
   x:=(a.x*t*t + 2*b.x*t*(1-t) + c.x*(1-t)*(1-t));
   y:=(a.y*t*t + 2*b.y*t*(1-t) + c.y*(1-t)*(1-t));

   if trunc(x)<>trunc(xx) then
    begin
     putpixel(trunc(x),trunc(y)+1,trunc(16+(y-trunc(y))*15));
     putpixel(trunc(x),trunc(y),31);
     putpixel(trunc(x),trunc(y)-1,31);
     putpixel(trunc(x),trunc(y)-2,trunc(31-(y-trunc(y))*15));
    end;
   if abs(y-yy)>0.4 then
    begin
     putpixel(trunc(x)+2,trunc(y),trunc(16+(x-trunc(x))*15));
     putpixel(trunc(x)+1,trunc(y),31);
     putpixel(trunc(x),trunc(y),31);
     putpixel(trunc(x)-1,trunc(y),trunc(31-(x-trunc(x))*15));
    end;

   t:=t+0.001;
  until (t>=1);
  putpixel(a.x,a.y,15);
 end;

Procedure CBezier(a,b,c,d : ptype);
 var t: real ; x,y,xx,yy : real;
 begin
  moveto(d.x,d.y);
  t:=0;
  while t<1 do
   begin
    xx:=x;
    yy:=y;
    x:=(a.x*t*t*t+3*b.x*t*t*(1-t)+3*c.x*t*sqr(1-t)+d.x*sqr(1-t)*(1-t));
    y:=(a.y*t*t*t+3*b.y*t*t*(1-t)+3*c.y*t*sqr(1-t)+d.y*sqr(1-t)*(1-t));
    putpixel(trunc(x),trunc(y),trunc(31-(y-trunc(y))*15));
    putpixel(trunc(x),trunc(y)+1,trunc(31));
    putpixel(trunc(x),trunc(y)+2,trunc(16+(y-trunc(y))*15));
    t:=t+0.0001;
   end;
  putpixel(a.x,a.y,15);
 end;

procedure Bcurve(a,b,c : ptype);
 var c1,c2,c3,c4,c5,c6 : ptype; lAB, lBC : real;
 begin
  {Tinh c3}
  lAB:=sqrt(sqr(b.x-a.x)+sqr(b.y-a.y));
  lBC:=Sqrt(sqr(c.x-b.x)+sqr(c.y-b.y));
  c3.x:=trunc(b.x-cos(g1)*l);
  c3.y:=trunc(b.y-sin(g1)*l);
  {Tinh c4}
  l:=sqrt(sqr(b.x-c.x)+sqr(b.y-c.y))/3;
  c4.x:=trunc(b.x+cos(g1)*l);
  c4.y:=trunc(b.y+sin(g1)*l);
  {tinh c5,c1 neu muon ve duong cong kin}

  {Ve curve}
  begin
   QBezier(a,c3,b);
   QBezier(b,c4,c);
  end;
 end;

begin
 randomize;
 gd:=d8bit; gm:=m800x600;
 InitGraph(gd,gm,'');
 UpdateGraph(0);
 //InitMouse;
 a.x:=100; a.y:=100;
 b.x:=10; b.y:=50;
 c.x:=500; c.y:=300;
 repeat
  cleardevice;
   begin gd:=random(3)-1; gm:=random(3)-1;  end;
  a.x:=a.x+gd;
  a.y:=a.y+gd;
  c.x:=c.x+gm;
  c.y:=c.y+gd;
  b.x:=GetMouseX;
  b.y:=GetMouseY;
  but:=GetMouseButtons;
  QBezier(a,b,c);
  Bcurve(a,b,c,but<>0);

  putpixel(a.x,a.y,12);
  putpixel(b.x,b.y,12);
  putpixel(c.x,c.y,12);
  UpdateGraph(2);
  delay(40);
 until keypressed;
 closegraph;
end.
