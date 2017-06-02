uses crt,graph;
var i : integer;  j : string;
    x,y,R,G,B : integer;
begin
 initgraph(x,y,'');
  cleardevice;      i:=-1;
 for R:=1 to 8 do
  for G:=1 to 8 do
   for B:=1 to 4 do
    begin
     inc(i);
     setRGBpalette(i,B*64,G*32,R*32);
    end;
 for i:=0 to 255 do

  begin
   x:=i mod 20;
   y:=i div 20;
   str(i,j);
   setcolor(i);
   outtextxy(x*50,y*50,#219);
   r:=getpixel(x*50,y*50);
   setcolor(i);
   str(r,j);
   outtextxy(x*50,y*50,' '+j);
  end;
 readln;
end.
