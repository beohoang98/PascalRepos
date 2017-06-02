program anti_alias;

uses wingraph, winmouse, wincrt;

var gd,gm : smallint;
    X, Y, M, t : longint;

procedure swap(var a,b : longint);
 var t : longint;
 begin
  t:=a;a:=b;b:=t;
 end;

procedure AAline(x0,y0,x1,y1 : longint);
 var x,y,dx,dy,kx,m : longint;  hs,ky : real;
     px,py : ^longint;
 begin
  if x0>x1 then
   begin
    swap(x1,x0);swap(y1,y0);
   end;
  if abs(x1-x0)>=abs(y1-y0) then
   begin
    px:=@x;
    py:=@y;
   end
  else
   begin
    swap(x1,y1); swap(x0,y0);
    px:=@y;
    py:=@x;
   end;
  dx:=x1-x0;
  dy:=y1-y0;
  hs:=dy/dx;
  y:=y0;ky:=y;
  x:=x0;kx:=0;
  for x:=x0 to x1 do
   begin
    ky:=(x-x0)*hs+y0;
    y:=trunc(ky)-1;
    m:=31-trunc((ky-trunc(ky))*15);
    putpixel(px^,py^,m);
    y:=y+1;
    putpixel(px^,py^,31);
    y:=y+1;
    putpixel(px^,py^,31);
    y:=y+1;
    m:=31-trunc((1-ky+trunc(ky))*15);
    putpixel(px^,py^,m);
   end;
 end;



Procedure AACircle(x0,y0 : longint; R : word);
 var x : real; y : longint; m : byte;

 Procedure Plot(x,y: longint);
  begin
   putpixel(x0+x,y0+y,m);
   putpixel(x0+x,y0-y,m);
   putpixel(x0-x,y0+y,m);
   putpixel(x0-x,y0-y,m);
   putpixel(x0+y,y0+x,m);
   putpixel(x0+y,y0-x,m);
   putpixel(x0-y,y0+x,m);
   putpixel(x0-y,y0-x,m);
  end;

 begin
  x:=R;
  y:=0;
  while (y<=x) do
   begin
    m:=31-trunc((x-trunc(x))*15);
    Plot(trunc(x-2),y);
    m:=31;
    Plot(trunc(x-1),y);
    Plot(trunc(x),y);
    m:=31-trunc((1-x+trunc(x))*15);
    Plot(trunc(x+1),y);

    x:=sqrt(sqr(R)-sqr(y));
    inc(y);
   end;
 end;

Procedure AAParabol;
 var x,y : real; m: byte;
 Procedure plot(x,y : integer);
  begin
   putpixel(GetMaxX div 2+x,GetMaxY*2 div 3-y,m);
   putpixel(GetMaxX div 2-x,GetMaxY*2 div 3-y,m);
  end;
 begin
  x:=0; y:=0;
  while x>=y do
   begin
    m:=31-trunc((y-trunc(y))*15);
    plot(trunc(x),trunc(y-1));
    m:=31;
    Plot(trunc(x),trunc(y));
    m:=31-trunc((1-y+trunc(y))*15);
    plot(trunc(x),trunc(y+1));
    x:=x+1;
    y:=sqr(x)/64;
   end;
  while (y>=x) and (y<600) do
   begin
    m:=31-trunc((x-trunc(x))*15);
    plot(trunc(x-1),trunc(y));
    m:=31;
    plot(trunc(x),trunc(y));
    m:=31-trunc((1-x+trunc(x))*15);
    plot(trunc(x+1),trunc(y));
    y:=y+1;
    x:=sqrt(y*64);
   end;
 end;

Procedure AASin;
 var y : real; x,x1 : longint; m: byte;
 begin
  x1:=0;
  for x:=0 to GetMaxX do
   begin
    y:=sin((x+t)/30)*30;
    m:=31-trunc((abs(y-trunc(y))*15));
    putpixel(x,300+trunc(y),m);
    m:=31-trunc((1-abs(y-trunc(y)))*15);
    if x>x1 then
     if y>0 then putpixel(x,300+trunc(y+1),m)
     else putpixel(x,300+trunc(y-1),m)
    else putpixel(x-1,300+trunc(y),31-trunc(abs(x-trunc(x))*15));
    x1:=x;
   end;
 end;

begin
 gd:=d8bit; gm:=m800x600;
 initgraph(gd,gm,''); UpdateGraph(0);
 //InitMouse;
 t:=0;
 repeat
  //GetMouseState(X,Y,M);
  cleardevice;
  AAline(0,0,GetMouseX,GetMouseY);
  AACircle(GetMouseX,GetMouseY,100);
  t:=t+1;
  if t>2*pi*30 then t:=0;
  //AASin;
  //AAParabol;
  UpdateGraph(2);
  delay(10);

 until GetMouseButtons>0;
 closegraph;
end.
