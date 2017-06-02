uses crt, graph;
var  x1,x2,y1,y2:integer;
     gm,gd:integer;
begin
 clrscr;gm:=0;gd:=0;
 x1:=0;x2:=100;
 y1:=0;y2:=200;
 initgraph(gm,gd,'D:\TP\BGI');
 for x1:=-100 to 600 do
  begin
   setcolor(x1 mod 5);
   y1:=round(200*sin(5*x1))+200;
   y2:=round(200*cos(5*x1))+200;
   circle(x1,y2,10);
   setcolor((x1 mod 5)+2);
   circle(x1,y1,5);
   delay(10);
  end;
 for x1:=50 to 150 do
  begin
   setcolor(red);
   y1:=-round((sqrt(abs(x1-100))+sqrt(2500-sqr(x1-100)))*4)+250;
   y2:=-round((sqrt(abs(x1-100))-sqrt(2500-sqr(x1-100)))*4)+250;
   line(x1*3,y1,x1*3,y2);
   line(300,55,x1*3,y1);line(300,55,x1*3,y2);
   line(300,445,x1*3,y2);line(300,445,x1*3,y1);
   setcolor(yellow);
   circle(x1*3,y1,1);
   circle(x1*3,y2,1);
   delay(50);
  end;


 readln;
 closegraph;
end.