uses crt, wingraph in 'src/wingraph.pas';

var asd,dsa : smallint;

procedure frac(x,y,l,g : real;n,t : integer);
 var x1,y1 : real;
 begin
  if l<=1 then exit;
  setcolor(n);

  x1:=x+cos(g*pi/180)*l;
  y1:=y+sin(g*pi/180)*l;

  line(trunc(x1),trunc(y1),trunc(x),trunc(y));
  if t=1 then begin
   frac(x1,y1,l*4/5,g+15,n+t*256,2);
   frac(x1,y1,l*4/5,g-40,n+t,1);
   end;
  if t=2 then frac(x1,y1,l*4/5,g+15,n+t*256,1);
 end;

begin
 asd:=nopalette;
 dsa:=m1024x768;
 Initgraph(asd,dsa,'');
 UpdateGraph(1);

 frac(500,700,200,-90,33,2);

 readln;
 closegraph;
end.
