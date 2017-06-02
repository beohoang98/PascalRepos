Program Thu_Neutral;

uses wincrt, wingraph;

const  maxP=300; c=0.01;

var p : array[0..maxP,0..maxP] of integer;
    xin, yin : longint;
    wx1, wy1, wb1, wx2, wy2, wb2, wh1, wh2 : double;
    hilay1, hilay2, hiout : double;
    guess : integer;

procedure kt;
 var i,j: word;gd,gm : smallint;
 begin
  randomize;
  gd:=d4bit; gm:=m800x600;
  InitGraph(gd,gm,' ');
  for i:=1 to maxP do
   for j:=1 to maxP do
    begin
     if (sqr(i-maxP/2)+sqr(j-maxP/2)>=10000) then p[i,j]:=1 else p[i,j]:=-1;
     putpixel(i+maxP,j,(p[i,j]+2)*5);
    end;
  wx1:=0; wy1:=0; wb1:=0; wh1:=0;
  wx2:=0; wy2:=0; wb2:=0; wh2:=0;
 end;

begin
 kt;
 repeat
  xin:=random(maxP)+1;
  yin:=random(maxP)+1;
  hilay1:=(sqr(xin+wh1)+sqr(yin+wb1)-10000);

  if hilay1>=0 then guess:=1 else guess:=-1;
  wx1:=wx1+(p[xin,yin]-guess)*sqr(xin)*c;
  wy1:=wy1+(p[xin,yin]-guess)*sqr(yin)*c;

  wx2:=wx2+(p[xin,yin]-guess)*xin*c;
  wy2:=wy2+(p[xin,yin]-guess)*yin*c;
  wb1:=wb1+(p[xin,yin]-guess)*c;

  wh1:=wh1+(p[xin,yin]-guess)*c;
  if guess=1 then putpixel(xin,yin,15) else putpixel(xin,yin,5);
  //circle(xin,yin,1);

 until keypressed;
 closegraph;
end.
