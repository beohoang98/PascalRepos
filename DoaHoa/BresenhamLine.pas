Program Bresenham_line;

uses graph, wincrt, windows;

var gd,gm : smallint;
    x,y : integer;
    t,count : longint;

procedure swap(var a,b : integer);
 var t : integer;
 begin
  t:=a;
  a:=b;
  b:=t;
 end;

procedure BresLine(x0,y0,x1,y1 : integer);
 var dx, dy, ystep, x, y : integer;
     err : integer;
     steep : boolean;
     mau: byte  ;
 begin
  mau:=getcolor;
  steep:=abs(y1-y0)>abs(x1-x0);
  if steep then
   begin
    swap(x0,y0);
    swap(x1,y1);
   end;
  if x0>x1 then
   begin
    swap(x0,x1);
    swap(y0,y1);
   end;
  dx:=x1-x0;
  dy:=abs(y1-y0);
  err:=dx div 2;
  y:=y0;
  if y0<y1 then ystep:=1 else ystep:=-1;
  for x:=x0 to x1 do
   begin
    if steep then putpixel(y,x,mau) else putpixel(x,y,mau);
    err:=err-dy;
    if err<0 then
     begin
      y:=y+ystep;
      err:=err+dx;
     end;
   end;

 end;

begin
 initgraph(gd,gm,'');
 count:=0;
 t:=gettickcount;

 repeat

  x:=random(GetmaxX);
  y:=random(GetMaxY);
  Setcolor(random(16));
  BresLine(x,y,random(x),random(y));
  inc(count);
 until (gettickcount-t)>=10000;

 closegraph;
 writeln(count);
 readln;
end.
