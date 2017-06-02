uses crt,graph;
var i : integer;  j : string;
    x,y : integer;
begin
 initgraph(x,y,'');
 cleardevice;
 for i:=0 to 300 do
  begin
   x:=i mod 20;
   y:=i div 20;
   str(i,j);
   setcolor(i);
   outtextxy(x*50,y*50,'   '+#219);
   setcolor(i);
   outtextxy(x*50,y*50,j);
  end;
 readln;
end.
