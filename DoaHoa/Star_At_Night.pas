Program Star_At_night;

uses wincrt, graph;

const  n=300;    maxmau=128;

var  star : array[1..n] of record
                            x,y : integer;
                            mau : byte;
                            sang : boolean;
                           end;
     i: word;

procedure Init;
 var gd,gm : smallint;
     i : word;
 begin
  gd:=d8bit;
  gm:=m800x600;
  Initgraph(gd,gm,'');

  for i:=0 to 255 do setRGBpalette(i*maxmau div 255,i*2 div 3,i*2 div 3,i);
  randomize;
  for i:=1 to n do
   with star[i] do
    begin
     x:=random(GetMaxX)+1;
     y:=random(GetMaxY)+1;
     mau:=random(maxmau-1);
     sang:=true;
    end;
  InstallUserFont('VNI-Kun');
  SetTextstyle(1,0,10);
 end;

procedure DrawStar(i : word);
 var x,y: word;  m,m1,m2,m3 : byte;
 begin
  x:=star[i].x;
  y:=star[i].y;
  m:=star[i].mau;
  m1:=m div 2;
  m2:=m div 3;
  m3:=m div 4;
  putpixel(x,y,m);
  putpixel(x-1,y,m1);putpixel(x-1,y+1,m2);
  putpixel(x+1,y,m1);putpixel(x+1,y+1,m2);
  putpixel(x,y+1,m1);putpixel(x+1,y-1,m2);
  putpixel(x,y-1,m1);putpixel(x-1,y-1,m2);
  putpixel(x-2,y,m3);
  putpixel(x+2,y,m3);
 end;

procedure DrawText(S : string; i: word);
 var lx,ly : word;
 begin
  lx:=textWidth(s);
  ly:=textHeight(s);
  lx:=abs(GetMaxX-lx) div 2;
  ly:=abs(GetMaxY-ly) div 2;
  //setcolor(maxmau div 2);Outtextxy(lx-2,ly,s);Outtextxy(lx+2,ly,s);
  setcolor(i);Outtextxy(lx,ly,s);
 end;

procedure Inra;
 var i : word;
 begin
  for i:=1 to n do
   with star[i] do
   begin

    if sang then inc(mau,1) else dec(mau,1);
    Drawstar(i);
    if (mau>=maxmau) then sang:=false;
    if (mau=0) and not(sang) then
     begin
      x:=random(GetMaxX)+1;
      y:=random(getMaxY)+1;
      mau:=0;
      sang:=true;
     end;

   end;
 end;

begin
 Init;
 i:=0;
 repeat
  Inra;

  DrawText('Star',i);
  inc(i);
  if i>maxmau then i:=0;
  //delay(10);
 until keypressed;
 closegraph;
end.
