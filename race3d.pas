uses crt, graph, ve3d, windows;

const z=15 ;

var
    gd, gm : integer;
    V, Vx, Vy : real;
    x, y : real;
    goc , t, n, fps: longint;
    c : char;     s : string;
    rx, ry : array[1..1000] of longint;

procedure docbanve;
 var f : text; i: integer;
 begin
  assign(f,'xe.asd');reset(f);
  readln(f,n);
  for i:=1 to n do readln(f,rx[i],ry[i]);
  close(f);
 end;


procedure vexe(x, y , r: real; z : longint );
 var i : integer;
     si, co : real;
     x1, y1 : array[1..1000] of longint;

 begin
  for i:=1 to n do
   begin
    si:=(ry[i])*cos(r)+sin(r)*(rx[i]);
    co:=(rx[i])*cos(r)-sin(r)*(ry[i]);
    x1[i]:=trunc(x+co/5);
    y1[i]:=trunc(y-si/5);
   end;

  for i:=1 to n-1 do
   BEGIN
   line3d(x1[i],y1[i],z,x1[i+1],y1[i+1],z);
   line3d(x1[i],y1[i],0,x1[i+1],y1[i+1],0);
   END;
 end;


procedure xe(g : integer);
 var r : real;
     i : integer;
 begin


  r:=g*pi/180;
  Vx:=Vx+V*cos(r);
  Vy:=Vy+V*sin(r);
  x:=x+Vx;
  y:=y-Vy;
  setcolor(2);
  vexe(0,0,r,z);


 end;



begin
 docbanve;
 initgraph(gd,gm,'');

 khoitao(500,300,300,0,0,0,300);

 x:=100; y:=100;
 V:=0; goc:=0; t:=0;
 c:=readkey;

 repeat
  xoay(0,30);
  repeat
   t:=gettickcount;
   xe(goc);
   if V<0.6 then V:=V+0.05;
   Vx:=Vx*90/100;
   Vy:=Vy*90/100;
   if (goc>=360) or (goc<=-360) then goc:=0;
   setcolor(7);
   box(-500-x,-300-y,0,1000,600,-100);

   str(fps,s);
   outtextxy(10,10,'FPS : '+s);
   cleardevice;
   fps:=trunc(1000/(gettickcount-t));
  until keypressed;
  c:=readkey;
  if c=#75 then goc:=goc-15;
  if c=#77 then goc:=goc+15;


 until c='0';

 closegraph;
end.
