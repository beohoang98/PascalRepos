Program PixelRGB;

uses wincrt, graph;

var gd,gm : integer;
    i : integer;

procedure pixel(x,y : integer; R,G,B : byte);
 begin
  if G>0 then G:=G+85;
  if B>0 then B:=B+170;
  putpixel(x*2,y*2,R);  putpixel(x*2+1,y*2,B);
  putpixel(x*2,y*2+1,G);putpixel(x*2+1,y*2+1,B);
 end;

begin
 initgraph(gd,gm,'');
 for i:=1 to 85 do
  begin
   setRGBpalette(i,i*3,0,0);
   setRGBpalette(i+85,0,i*3,0);
   setRGBpalette(i+170,0,0,i*3);
  end;
 for i:=0 to 255 do pixel(i+100,100,i,i,i);
 repeat until keypressed;
 closegraph;
end.