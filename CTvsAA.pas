Program CTvsAA;

uses graph,crt;

const R0=128; G0=128; B0=255;

var x,y : longint;

Procedure Init;
 var gd,gm : smallint;
 begin
  gd:=d8bit; gm:=m800x600;
  InitGraph(gd,gm,'');
  randomize;
  setRGBpalette(1,R0,G0,B0);
 end;

Procedure Swap(var a,b : longint);
 var t : longint;
 begin
  t:=a; a:=b; b:=t;
 end;

procedure AAline(x0,y0,x1,y1 : longint);
 var x,y,dx,dy,kx,m : longint;  hs,ky : real;
     px,py : ^longint;
     R,G,B : byte;
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
     R:=trunc((1-ky+trunc(ky))*R0);
     G:=trunc((1-ky+trunc(ky))*G0);
     B:=trunc((1-ky+trunc(ky))*B0);
    setRGBpalette(2,R,G,B);
     R:=R0-R; G:=G0-G; B:=B0-B;
    setRGBpalette(3,R,G,B);
    putpixel(px^,py^,2);
     y:=y+1;
    putpixel(px^,py^,1);
     y:=y+1;
    putpixel(px^,py^,3);
   end;
 end;

Procedure CTLine(x0,y0,x1,y1: longint);
 var x,y,dx,dy,kx,m : longint;  hs,ky1 : real;
     px,py : ^longint;
     R,G,B : byte;
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
  y:=y0;ky1:=y;
  x:=x0;kx:=0;
  for x:=x0+1 to x1 do
   begin
    ky1:=(x-x0)*hs+y0;
    y:=trunc(ky1)+2;
     R:=trunc(R0*(ky1-trunc(ky1)));
     G:=trunc(G0*(ky1-trunc(ky1)));
     B:=trunc(B0*(ky1-trunc(ky1)));
    setRGBpalette(2,R,G*2 div 3,B*2 div 3);
     R:=R0-R; G:=G0-G; B:=B0-B;
    setRGBpalette(3,R*2 div 3,G*2 div 3,B);
    Putpixel(px^,py^,2);
     y:=y-1;
    putpixel(px^,py^,1);
    // y:=y-1;
    //putpixel(px^,py^,15);
     y:=y-1;
    putpixel(px^,py^,3);

   end;
 end;

Procedure CTAACircle(x0,y0 : longint; R : word);
 var x : real; y : longint; m,R1,G1,B1 : byte;
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
  while (y<=x+1) do
   begin
     R1:=trunc(R0*(x-trunc(x)));
     G1:=trunc(G0*(x-trunc(x)));
     B1:=trunc(B0*(x-trunc(x)));
    setRGBpalette(2,R1,G1*2 div 3,B1*2 div 3);
     R1:=R0-R1; G1:=G0-G1; B1:=B0-B1;
    setRGBpalette(3,R1*2 div 3,G1*2 div 3,B1);
     m:=1; Plot(trunc(x),y);
     //      Plot(trunc(x)+1,y);

     m:=3; Plot(trunc(x)-1,y);
     m:=2; Plot(trunc(x)+1,y);

    x:=sqrt(sqr(R)-sqr(y));
    inc(y);
   end;
 end;

begin
 Init;
 repeat
  x:=random(400); y:=random(600);
  AALine(400,0,x+400,y);
  CTLine(0,0,x,y);
  CTAACircle(x,y,50);
  delay(200);
 until keypressed;
 CloseGraph;
end.
