Program Thu_2d_animation;

uses wincrt
     , wingraph
     , winmouse ;

const w=50; h=50;
      hinh : array[1..5] of string=('a1.bmp','a2.bmp','a3.bmp','a4.bmp','a5.bmp');

type RGBtype = packed record
                B,G,R : byte;
               end;

     imgtype = record
                dai,rong : word;
                data : array[0..w,0..h] of RGBtype;
               end;
     imgheader = packed record
                  magic : array[1..2] of char;
                  size : longword;
                  asd : longint;
                  start : longint;
                  dsa: longint;
                  dai, rong : longword;
                  plane, bit : word;
                 end;

     animType = array[1..10] of imgtype;

Var anime : animType;
    i : word;
    X,Y,M,XM,YM : longint;

Function Docimage(s : string; d,r : word): imgtype;
 var f : file;  a: rgbtype; header : imgheader;
     dai,rong,i,j : longword;
 begin
  assign(f,s);reset(f,1);
  blockread(f,header,sizeof(header));
  seek(f,header.start);
  dai:=header.dai;
  rong:=header.rong;
  Docimage.dai:=d;
  Docimage.rong:=r;
  for j:=1 to rong do
   for i:=1 to dai do
    begin
     blockread(f,a,sizeof(a));
     DocImage.data[i*d div dai,r-(j*r div rong)]:=a;
    end;
  close(f);
 end;

procedure Init;
 var gd,gm : smallint;
 begin
  gd:=nopalette; gm:=m800x600;
  initgraph(gd,gm,'');
 end;

Procedure Ve(a : imgtype; x,y : integer);
 var i,j,m : longword;
 begin
  with a do
  for j:=1 to rong do
   for i:=1 to dai do
    //if (data[i,j].R<>data[i,j].B) then
    begin
     m:=(data[i,j].R + data[i,j].G shl 8 + data[i,j].B shl 16);
     Putpixel(i+x,j+y,m);
    end;
  //delay(40);
 end;

Procedure Xoa(a : imgtype; X,Y : integer);
 var i,j : longword;
 begin
  {for j:=1 to a.rong do
   for i:=1 to a.dai do
    putpixel(i+x,j+y,0); }
  setfillstyle(0,0);
  bar(x,y,x+a.dai,y+a.rong);
 end;

begin
 Init;
 UpdateGraph(0);
 //InitMouse;
 For i:=1 to 5 do
  anime[i]:=docimage(hinh[i],50,30);
 i:=2;
 X:=10;Y:=10;
 repeat
  XM:=GetMouseX;
  YM:=GetMouseY;
  if XM>X then inc(X,(XM-X) div 4) else dec(X,(X-XM) div 4);
  if YM>=Y then inc(Y,(YM-Y) div 4) else dec(Y,(Y-YM) div 4);

  Ve(anime[i div 2],X,Y);
  inc(i);
  if i>10 then i:=2;
  UpdateGraph(2);
  delay(20);
  Xoa(anime[i div 2],X,Y);
 until keypressed;
 Closegraph;
end.
