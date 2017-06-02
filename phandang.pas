uses crt, graph;

var asd,dsa,i,j : integer;

procedure frac(x,y,g,i : longint; l: real);
 var x1,y1,xm,ym : longint;
 begin
  if l<=2 then exit;
  x1:=trunc(l*cos(g*pi/180)+x);
  y1:=trunc(l*sin(g*pi/180)+y);
  xm:=(x1+x) div 2;
  ym:=(y1+y) div 2;
  line(x,y,x1,y1);
  frac(xm,ym,g+60,i+2,l/3);
  frac(xm,ym,g-60,i+2,l/3);
  frac(x,y,g,i+1,l/2);
  frac(xm,ym,g,i+1,l/2);
  setcolor(i+1);
 end;

procedure ice(x,y,l,i : longint);
 begin
  frac(x,y,-90,i,l);
  frac(x,y,-30,i,l);
  frac(x,y,30,i,l);
  frac(x,y,210,i,l);
  frac(x,y,90,i,l);
  frac(x,y,150,i,l);
 end;


begin
 initgraph(asd,dsa,'');
 randomize;
 setbkcolor(1);
 frac(500,0,90,1,300);
 readln;
 closegraph;
end.
