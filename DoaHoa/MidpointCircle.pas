Program Midpoint_Circle;

uses graph, wincrt,windows;

var gd,gm : smallint;
    x,y : integer;
    time, count : longint;


procedure Mcircle(x0,y0 : integer; R : word);
 var x,y,err : integer;  m: byte;
 begin
  //m:=getcolor;
  x:=0;
  y:=R;
  err:=1-R;
  while (x<=y) do
   begin
    line(x0-x,y0+y,x0+x,y0+y);
    line(x0-x,y0-y,x0+x,y0-y);
    line(x0-y,y0-x,x0+y,y0-x);
    line(x0-y,y0+x,x0+y,y0+x);

    if err<0 then err:=err+2*x+1
    else
     begin
      err:=err+2*(x-y)+1;
      dec(y);
     end;

    inc(x);
   end;
 end;


begin
 //gd:=d8bit;

 initgraph(gd,gm,'');
 count:=0;
 time:=gettickcount;
 repeat
  x:=random(GetmaxX);
  y:=random(GetMaxY);
  Setcolor(random(16));
  Mcircle(x,y,10);
  inc(count);
 until (gettickcount-time)>=20000;
 closegraph;
 writeln(count);
 readln;
end.
