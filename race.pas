uses crt, graph;

var
    gd, gm : integer;
    V, Vx, Vy : real;
    x, y, goc, t : real;
     n,r, asd: integer;
    c : char;
    rx, ry : array[1..1000] of longint;
    ms : real;

procedure docbanve;
 var f : text; i, min: integer;
 begin
  assign(f,'xe.asd');reset(f);
  min:=10000;
  readln(f,n);
  for i:=1 to n do
   begin
    readln(f,rx[i],ry[i]);
    if (rx[i]<min) and (rx[i]>0) then begin min:=rx[i];asd:=i; end;
   end;
  close(f);
 end;




procedure vexe(x, y , r: real);
 var i : integer;
     si, co : real;
     x1, y1 : array[1..1000] of longint;

 begin
  for i:=1 to n do
   begin
    si:=(ry[i]+ry[asd])*cos(r)+sin(r)*(rx[i]+rx[asd]);
    co:=(rx[i]+rx[asd])*cos(r)-sin(r)*(ry[i]+ry[asd]);
    x1[i]:=trunc(x+co/5);
    y1[i]:=trunc(y-si/5);
    if i=1 then moveto(x1[1],y1[1])
    else lineto(x1[i],y1[i]);
   end;
 end;


procedure xe(g : real);
 var r, r1: real; xx, yy : real;

 begin
  xx:=x;yy:=y;
  r:=g*pi/180;
  Vx:=Vx+V*cos(r);
  Vy:=Vy+V*sin(r);
  x:=x+Vx;
  y:=y-Vy;
  setcolor(2);vexe(x,y,r);
 end;



begin
 docbanve;

 initgraph(gd,gm,'');
 setbkcolor(0);
 x:=100; y:=100;
 V:=0; goc:=0; t:=0;
 c:=readkey;
 repeat
  repeat
   if V <> 0 then t:=sqrt(Vx*Vx+Vy*Vy)*abs(V)/V;
   goc:=goc+t*sin(r*pi/90);
   xe(goc);
   V:=V*97/100;
   Vx:=Vx*ms;
   Vy:=Vy*ms;
   if (goc>=360) or (goc<=-360) then goc:=0;
   delay(30);
   cleardevice;
   r:=0;
   if t>5 then ms:=95/100 else ms:=80/100;
  until keypressed;
  c:=readkey;
  case c of
   #75 : r:=45;
   #77 : r:=-45;
   #72 : V:=V+0.2;
   #80 : V:=V-0.2;
   'a' : begin x:=100;y:=100; end;
  end;

 until c='0';

 closegraph;
end.
