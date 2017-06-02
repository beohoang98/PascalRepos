uses crt, graph;

var gd, gm : integer;
    i,j,k : longint;
    b : array[1..10] of integer;

begin
 initgraph(gd,gm,'');
 b[1]:=24;
 b[2]:=0;
 b[3]:=72;
 b[4]:=144;
 b[5]:=144;

  for i:=1 to 48 do
   for j:=1 to 4 do
   begin
    setcolor(i+b[j]+31);
    outtextxy((i mod 4)*64+j*16,(i div 4)*16,#219+#219);
    outtextxy((i mod 4)*64+j*16,(i div 4)*16+8,#219+#219);
   end;
 for i:=16 to 31 do
  begin
   setcolor(i);
   outtext(#219);
  end;
 readln;
 closegraph;
end.
