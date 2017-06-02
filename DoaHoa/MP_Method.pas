program Midpoint_Method;

uses graph, wincrt;

var x,y : longint;

procedure Init;
 var gd, gm : smallint;
 begin
  gd:=d8bit; gm:=m640x480;
  initgraph(gd,gm,'');
  Cleardevice;
 end;

Procedure Swap(var a,b : longint);
 var t : longint;
 begin
  t:=a;
  a:=b;
  b:=t;
 end;

Procedure Plot(x,y : integer);
 begin
  Putpixel(x,y,15);
 end;

Procedure MLine(x0,y0,x1,y1: longint);
 var dx,dy, err, ystep, x, y,x2,y2,x3,y3 : longint;
     k, dxy : real;
     px,py : ^longint;
 begin
  if (x0=x1) then
   begin
    if y0>y1 then swap(y1,y0);
    for y:=y0 to y1 do plot(x0,y);
    exit;
   end;
  if (y0=y1) then
   begin
    if x0>x1 then swap(x1,x0);
    for x:=x0 to x1 do plot(x,y0);
    exit;
   end;
  if abs(x1-x0)<abs(y1-y0) then
   begin
    swap(x1,y1);swap(x0,y0);
    px:=@y;
    py:=@x;
   end
  else
   begin
    px:=@x;
    py:=@y;
   end;
  if x1<x0 then
   begin
    swap(x1,x0);swap(y1,y0);
   end;
  x:=x0; y:=y0;
  dx:=abs(x1-x0); dy:=abs(y1-y0);
  if y0>y1 then ystep:=-1 else  ystep:=1;
  x2:=x;y2:=y;
  err:=0;
  dxy:=sqrt(dx*dx+dy*dy);
  while x<=x1 do
   begin
    //putpixel(x,y,31);
    k:=abs(err)/dxy;
    if k>=0.5 then putpixel(px^,py^,27);
    if k<0.5 then putpixel(px^,py^,31);
    if (k<1) and (k>0.8) then putpixel(px^,py^,31);
    inc(x);
    err:=err-dy;
    if err<=0 then
     begin
      err:=err+dx;
      y:=y+ystep;
     end;



   end;

 end;



Procedure Mparabol;
 var x,y,d,mx,my : longint;
 begin
  x:=0; y:=0; d:=0;
  mx:=getmaxx div 2;
  my:=getmaxY div 2;
  while x<mx do
   begin
    plot(mx+x,my*2-y);
    plot(mx-x,my*2-y);
    if y>my*2 then exit;
    if d>=0 then
     begin
      inc(y);
      d:=d-16;
     end
    else
     begin
      d:=d+2*x+1;
      inc(x);
     end;
   end;
 end;

Procedure MElip(x0,y0,R1,R2: integer);
 var x,y,err : longint;
 begin
  //line(x0+R1,y0,x0,y0);
  //line(x0,y0+R2,x0,y0);
  x:=R1;
  y:=0;
  err:=0;
  R1:=R1*R1;
  R2:=R2*R2;
  while x>=0 do
   begin
    Plot(x0+x,y0+y);
    Plot(x0-x,y0+y);
    Plot(x0+x,y0-y);
    Plot(x0-x,y0-y);

    if err>0 then
     begin
      dec(x);
      err:=err-2*x*R2-R2;
     end
    else
     begin
      inc(y);
      err:=err+2*y*R1+R1;
     end;
   end;
 end;



Begin
 Init;
 randomize;
 repeat
  //Mparabol;
  //Melip(random(640),random(480),50,120);
  x:=random(640);
  y:=random(480);
  Mline(random(x),random(y),x,y);
 until keypressed;

 Closegraph;
End.
