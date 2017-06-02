program ThuBangMau;

uses graph, crt;

const x0=400; y0=300; Rmax=295;

Var x, y : real;
    i,j : integer;
    R,G,B : array[0..3600] of byte;

Procedure Init;
 var gd,gm : smallint;
 begin
  gd:=d8bit; gm:=m800x600;
  InitGraph(gd,gm,' ');
 end;

begin
 Init;
 for i:=0 to 1200 do
  begin
   R[i]:=255*(1200-i) div 1200; G[i+1200]:=R[i]; B[i+2400]:=G[i+1200];
   R[i+1200]:=0; B[i]:=0; G[i+2400]:=0;
   R[i+2400]:=255*i div 1200; G[i]:=R[i+2400]; B[i+1200]:=G[i];
  end;
 setcolor(1);
 for i:=0 to 3600 do
  for j:=0 to Rmax do
  begin
   setRGBpalette(1,R[i]*j div Rmax,G[i]*j div Rmax,B[i]*j div Rmax);
   x:=x0+(Rmax-j)*cos(i*pi/1800);
   y:=y0+(Rmax-j)*sin(i*pi/1800);
   putpixel(trunc(x),trunc(y),1);
  end;
 readln;
 CloseGraph;
end.



