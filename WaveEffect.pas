
Program Song;

uses wingraph, wincrt, winmouse;

const MaxX=500; step=1000;   Ms=0.001; Ygiua = 300; count=55;

Var  chdiem : array[1..MaxX] of record
                                 y : real;
                                 V,a : real;
                                end;
     i : integer;   m:real;
     t : word;

Procedure Init;
 var gd,gm : smallint;
 begin
  gd:=d8bit;
  gm:=m800x600;
  InitGraph(gd,gm,'');
  UpdateGraph(0);
  for i:=1 to maxX do
   begin
    chdiem[i].y:=Ygiua;
    chdiem[i].V:=0;
    chdiem[i].a:=0;
   end;
  for i:=0 to 255 do setRGBpalette(i,i*2 div 3,0,i);
 end;

Procedure Tinh(i : word);
 begin
  chdiem[i].V:=chdiem[i].V+chdiem[i].a*ms;
  chdiem[i].y:=chdiem[i].y+chdiem[i].V/step;
  chdiem[i].a:=-chdiem[i].y+Ygiua;
  if i>1 then
   begin
    chdiem[i].a:=chdiem[i].a-(chdiem[i].y-chdiem[i-1].y);
    chdiem[i-1].a:=chdiem[i-1].a+(chdiem[i].y-chdiem[i-1].y);
   end;
  if i<maxX then
   begin
    chdiem[i].a:=chdiem[i].a-(chdiem[i].y-chdiem[i+1].y)*ms;
    chdiem[i+1].a:=chdiem[i+1].a+(chdiem[i].y-chdiem[i+1].y)*ms;
   end;
 end;

begin
 Init;
 chdiem[1].V:=10;
 t:=0;
 repeat
  if GetMouseButtons=1 then
   for i:=1 to MaxX do chdiem[i].V:=chdiem[i].V*(1+ms/i);
  inc(t);
  for i:=1 to MaxX do Tinh(i);

  if t>=count then
   begin
    cleardevice;
    for i:=1 to MaxX do
    begin
     m:=chdiem[i].y;
     m:=m-trunc(m);
     putpixel(i,trunc(chdiem[i].y)+1,trunc((m)*255));
     putpixel(i,trunc(chdiem[i].y),255);
     putpixel(i,trunc(chdiem[i].y-1),255);
     putpixel(i,trunc(chdiem[i].y)-2,trunc((1-m)*255));
    end;
    UpdateGraph(2);
    t:=0;
   end;
  //delay(5);

 until keypressed;
 CloseGraph;
end.
