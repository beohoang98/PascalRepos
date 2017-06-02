Program RGBA;

uses wingraph in 'src/wingraph.pas', wincrt in 'src/wincrt.pas';

const maxX= 1366; maxY=768;

var  pixel : array[0..maxX,0..maxY] of
       record
        R,G,B : byte;
       end;
     Mauht : longword;
     Alpha : byte;
     x,y : longint;

procedure Init;
 var gd,gm : smallint;
 begin
  gd:=nopalette;
  gm:=1;
  initgraph(gd,gm,'');
  fillchar(pixel,sizeof(pixel),0);
  Mauht:=$FFFFFF;
  Alpha:=255;
  UpdateGraph(0);
 end;

procedure diem(x,y : longint;mau: longword;A : byte);
 var R1,G1,B1,A1 : byte;
 begin
  if (x<0) or (x>MaxX) or (y<0) or (y>maxY) then exit;
  if A=255 then begin putpixel(x,y,mau); exit; end;
  if A=0 then exit;
  R1:=Lo(Lo(mau));
  G1:=Hi(Lo(mau));
  B1:=Hi(mau);
  A1:=255-A;
  with pixel[x,y] do
   begin
    R:=(R*A1+R1*A) shr 8;
    G:=(G*A1+G1*A) shr 8;
    B:=(B*A1+B1*A) shr 8;
    mau:=R+G shl 8+ B shl 16;
   end;
  putpixel(x,y,mau);
 end;

procedure line2d(x1,y1,x2,y2: longint);
 var i, step1,step2,x,y,t : longint;
     max : word;
 begin
  if x1=x2 then
   begin
    if y1>y2 then begin t:=y1;y1:=y2;y2:=t; end;
    for i:=y1 to y2 do diem(x1,i,mauht,alpha);
    exit;
   end;
  if y1=y2 then
   begin
    if x1>x2 then begin t:=x1;x1:=x2;x2:=t; end;
    for i:=x1 to x2 do diem(i,y1,mauht,alpha);
    exit;
   end;
  step1:=x2-x1;
  step2:=y2-y1;
  if abs(step1)>abs(step2) then max:=abs(step1) else max:=abs(step2);
  for i:=0 to max do
   begin
    x:=trunc(x1+i*step1/max);
    y:=trunc(y1+i*step2/max);
    diem(x,y,mauht,alpha);
   end;
 end;

procedure bar(x1,y1,x2,y2: longint);
 var t: longint;
 begin
  if x1>x2 then begin t:=x1;x1:=x2;x2:=t; end;
  for t:=x1 to x2 do
   line2d(t,y1,t,y2);
 end;

procedure tron(x,y: longint; R: word);
 var i,j,m : longint;  k : real;
 begin
  if R=0 then exit;
  if R=1 then begin diem(x,y,mauht,alpha); exit; end;
  diem(x,y+R+1,mauht,alpha div 2);
  diem(x,y-R-1,mauht,alpha div 2);
  line2d(x,y+R,x,y-R);
  i:=1;j:=R;
  while i<j do
   begin
    k:=sqrt(R*R-i*i);
    j:=trunc(k);
    k:=abs(k-j);
    diem(x+i,y+j+1,mauht,trunc(alpha*k));
    diem(x+i,y-j-1,mauht,trunc(alpha*k));
    diem(x-i,y+j+1,mauht,trunc(alpha*k));
    diem(x-i,y-j-1,mauht,trunc(alpha*k));
    line2d(x+i,y+j,x+i,y-j);
    line2d(x-i,y+j,x-i,y-j);
    inc(i);
   end;
  m:=i;
  line2d(x+m,y,x+R,y);
  line2d(x-m,y,x-R,y);
  j:=1; i:=R;
  while j<i do
   begin
    k:=sqrt(R*R-j*j);
    i:=trunc(k);
    k:=abs(k-i);
    diem(x+i+1,y+j,mauht,trunc(alpha*k));
    diem(x+i+1,y-j,mauht,trunc(alpha*k));
    diem(x-i-1,y+j,mauht,trunc(alpha*k));
    diem(x-i-1,y-j,mauht,trunc(alpha*k));
    line2d(x+m,y+j,x+i,y+j);
    line2d(x-m,y+j,x-i,y+j);
    line2d(x+m,y-j,x+i,y-j);
    line2d(x-m,y-j,x-i,y-j);
    inc(j);
   end;

 end;

begin
 Init;
 Randomize;
 repeat
  mauht:=random($FFFFFF);
  alpha:=random(256);
  x:=random(GetMaxX);
  y:=random(GetMaxY);
  tron(x,y,20);
  UpdateGraph(2);
  Alpha:=10;
  Mauht:=0;
  bar(0,0,GetMaxX,GetMaxY);
 until keypressed;
 Closegraph;
end.
