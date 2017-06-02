uses crt, graph, ve3d;

var asd,dsa : integer;

procedure frac(x,y,z,l,g,r : real;n : integer);
 var x1,y1,z1,m : real;
 begin
  if l<=1 then exit;
  color(n+32);
  z1:=z+sin(r*pi/180)*l;
  m:=cos(r*pi/180)*l;
  x1:=x+cos(g*pi/180)*m;
  y1:=y+sin(g*pi/180)*m;
  line3d(x1,y1,z1,x,y,z);
  frac(x1,y1,z1,l*2/3,g+120,r-15,n+1);
  frac(x1,y1,z1,l/2,g-100,r+40,n+1);
  frac(x1,y1,z1,l*2/3,g,r-10,n+1);

 end;

begin
 initgraph(asd,dsa,'');
 khoitao(500,0,600,0,100,0,600);
 xoay(-30,30);
 frac(0,0,0,130,0,90,1);
 repeat
 until keypressed;
 closegraph;
end.
