Program SBS_Text;

uses wingraph in 'src/wingraph.pas', crt;

const  s = 'LOVE BETH';

var gd,gm : smallint;
    dai,rong : word;
    x,y,X0 : word;
    I,J : DWORD;
    p : array[0..1366,0..786] of byte;
    m : byte;

Procedure Viet(x,y : integer);
 var i,j : word;
 begin
  for i:=0 to rong do
   for j:=0 to dai do
    if p[j,i]<>0 then
    begin
     if p[j,i]<5 then putpixel(j+x,i+y,0);
     if p[j,i]>5 then putpixel(j+x,i+y,p[j,i])
    end;
 end;

begin
 randomize;
 gd:=d8bit; gm:=11;
 initgraph(gd,gm,'');

 SetTextStyle(3,0,85);
 cleardevice;
 dai:=TextWidth(s);
 rong:=TextHeight(s);
 OuttextXY(0,0,s);
 for i:=1 to rong do
  for j:=1 to dai do
   if getpixel(j,i)=0 then p[j,i]:=0
   else p[j,i]:=random(35);
 cleardevice;
 //line(GetMaxX div 2,0,GetMaxX div 2, GetMaxY
 UpdateGraph(0);
 repeat
  //cleardevice;
  for i:=1 to 10000 do
   begin
    x:=random(GetMaxX div 2-1)+1;
    y:=random(GetMaxY-1)+1;
    m:=random(35);
    putpixel(x,y,m);
    putpixel(x+GetMaxX div 2,y,m);
   end;
  X0:=(GetMaxX-2*Dai) div 4;
  Viet(X0,GetMaxY div 2-rong);
  Viet(X0+5+GetMaxX div 2,GetMaxY div 2-rong);
  UpdateGraph(2);
  delay(5);
 until keypressed;
 readln;
 closegraph;
end.
