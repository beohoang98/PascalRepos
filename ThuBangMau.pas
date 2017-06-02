program ThuBangMau;

uses graph, crt;

const x0=400; y0=300;

Var x, y : real;
    R,G,B : byte;

Procedure Init;
 var gd,gm : smallint;
 begin
  gd:=d8bit; gm:=m800x600;
  InitGraph(gd,gm,' ');
 end;

begin
 Init;
 for R:=0 to 255 do
  for G:=0 to 255 do
   begin
    x:=x0+0+G*cos(-pi*5/6);
    y:=y0+R+G*sin(-pi*5/6);
    SetRGBpalette(1,R,G,0);
    putpixel(trunc(x),trunc(y),1);
   end;
 for R:=0 to 255 do
  for B:=0 to 255 do
   begin
    x:=x0+0+B*cos(-pi/6);
    y:=y0+R+B*sin(-pi/6);
    SetRGBpalette(1,R,0,B);
    putpixel(trunc(x),trunc(y),1);
   end;
 for B:=0 to 255 do
  for G:=0 to 255 do
   begin
    x:=x0+G*cos(-pi*5/6)+B*cos(-pi/6);
    y:=y0+G*sin(-pi*5/6)+B*sin(-pi/6);
    SetRGBpalette(1,0,G,B);
    putpixel(trunc(x),trunc(y),1);
   end;
 readln;
 CloseGraph;
end.



