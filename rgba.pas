unit RGBA;

interface
 {graphics drivers}
 const    Detect = smallint(0);
          D1bit = smallint(1);
          D4bit = smallint(2);
          D8bit = smallint(3);
      NoPalette = smallint(9);
       HercMono = D1bit;
            VGA = D4bit;
           SVGA = D8bit;
 {graphics modes}
 const   m320x200 = smallint( 1);
        m640x200 = smallint( 2);
        m640x350 = smallint( 3);
        m640x480 = smallint( 4);
        m720x350 = smallint( 5);
        m800x600 = smallint( 6);
       m1024x768 = smallint( 7);
      m1280x1024 = smallint( 8);
        mDefault = smallint(10);
      mMaximized = smallint(11);
        mFullScr = smallint(12);
         mCustom = smallint(13);
      HercMonoHi = m720x350;
           VGALo = m640x200;
          VGAMed = m640x350;
           VGAHi = m640x480;
 {update constants}
 const UpdateOff = word(0);
       UpdateOn = word(1);
      UpdateNow = word(2);
 { ^ Consts up that was copied from WinGraph }

 Procedure KhoiTao(gd,gm : smallint);

 Procedure Tat;
 Procedure Screen;
 Procedure UpOn;
 Procedure UpOff;
 Procedure AAOn;
 Procedure AAOff;
 Procedure MauNen(R,G,B : byte); overload;
 Procedure MauNen(Mau : longword);
 Procedure Xoa;
 procedure ChonMau(R,G,B,A : byte); overload;
 procedure ChonMau(Mau : longword; A : byte);
 Function MauHT : longword; overload;
 Procedure MauHT(var R,G,B,A : byte);
 Function AlphaHT : byte;
 Function GetPixel(x,y: longint) : longword;  overload;
 Procedure GetPixel(x,y : longint;var R,G,B: byte);
 Procedure Diem(x,y : longint; R,G,B,A : byte); overload;
 Procedure Diem(x,y : longint; m : longword; A: byte);
 Procedure Line(x0,y0,x1,y1 : longint);
 Procedure AALine(x0,y0,x1,y1 : longint);
 Procedure Tron(x0,y0 : longint ; R : word);
 Procedure AATron(x0,y0 : longint; R : word);
 Procedure FillTron(x0,y0 : longint; R :word);

implementation
Uses WinGraph in 'C:/FPC/2.6.2/bin/i386-win32/src/wingraph.pas' ;

Const MaxX=1366; MaxY=768;

Var  currentMau : longword; { R,G,B }
     CurrentAlpha : byte;
     currentMau32 : record R,G,B : byte; end;
     Pixel, Opixel : array[0..MaxX,0..MaxY]
                      of record R,G,B : byte; end;
     MauSan : array[0..255,0..255,0..255] of byte;
     ChedoAA : boolean;
     NenR,NenG,NenB : longword;

Procedure KhoiTao(gd,gm : smallint);
 var i,j,a : byte;
 begin
  gd:=nopalette;
  if gm=0 then gm:=1;
  WinGraph.InitGraph(gd,gm,'');
  NenR:=0; NenB:=0; NenG:=0;
  FillChar(Pixel,Sizeof(Pixel),0);
  FillChar(OPixel,Sizeof(OPixel),0);
  CurrentMau:=$FFFFFF;
  CurrentAlpha:=$FF;
  with CurrentMau32 do
   begin
    R:=255; G:=255; B:=255;
   end;
  for i:=0 to 255 do
   for j:=0 to 255 do
    for a:=0 to 255 do
     begin
      MauSan[i,j,a]:=(i*a+j*(255-a)) shr 8;
     end;
 end;

Procedure Tat;
 begin
  WinGraph.CloseGraph;
 end;

Procedure Screen;
 begin
  WinGraph.UpdateGraph(2);
 end;

Procedure UpOn;
 begin
  WinGraph.UpdateGraph(1);
 end;
Procedure UpOff;
 begin
  WinGraph.UpdateGraph(0);
 end;

Procedure AAOn;
 begin
  ChedoAA:=true;
 end;

Procedure AAOff;
 begin
  ChedoAA:=false;
 end;

Procedure MauNen(R,G,B : byte);
 begin
  SetRGBpalette(0,R,G,B);
  NenR:=R; NenG:=G; NenB:=B;
 end;

Procedure MauNen(Mau : longword);
 var R,G,B : byte;
 begin
  R:=Lo(Lo(Mau));
  G:=Hi(Lo(Mau));
  B:=Hi(Hi(Mau));
  NenR:=R; NenG:=G; NenB:=B;
  setRGBpalette(0,R,G,B);
 end;

Procedure Xoa;
 begin
  Opixel:=Pixel;
  FillChar(Pixel,Sizeof(Pixel),0);

  WinGraph.ClearDevice;
 end;

procedure ChonMau(R,G,B,A : byte); overload;
 begin
  CurrentMau:=R + G shl 8 + R shl 16;
  CurrentMau32.R:=R;
  CurrentMau32.G:=G;
  CurrentMau32.B:=B;
  CurrentAlpha:=A;
 end;

procedure ChonMau(Mau : longword; A : byte);
 begin
  CurrentMau:=Mau;
  CurrentMau32.R:=Lo(Lo(Mau));
  CurrentMau32.G:=Hi(Lo(Mau));
  CurrentMau32.B:=Hi(mau);
  CurrentAlpha:=A;
 end;
Function MauHT : longword;    overload;
 begin
  exit(CurrentMau);
 end;
Procedure MauHT(var R,G,B,A : byte);
 begin
  R:=CurrentMau32.R;
  G:=CurrentMau32.G;
  B:=CurrentMau32.B;
  A:=CurrentAlpha;
 end;
Function AlphaHt: byte;
 Begin
  Exit(CurrentAlpha);
 End;
Function GetPixel(x,y: longint) : longword;overload;
 begin
  if (x<0) or (x>GetMaxX) or (x>MaxX) or
  (y<0) or (y>GetMaxY) or (y>MaxY) then exit(0);
  exit(WinGraph.GetPixel(X,Y));
 end;
Procedure GetPixel(x,y : longint;var R,G,B: byte);
 begin
  if (x<0) or (x>GetMaxX) or (x>MaxX) or
   (y<0) or (y>GetMaxY) or (y>MaxY) then
    begin
     R:=0;
     B:=0;
     G:=0;
     exit;
    end;
  R:=pixel[x,y].R;
  G:=pixel[x,y].G;
  B:=pixel[x,y].B;
 end;
Procedure Diem(x,y : longint; R,G,B,A : byte);overload;
 var A1 : byte;
 begin
  if (x<0) or (x>GetMaxX) or (x>MaxX) then exit;
  if (y<0) or (y>GetMaxY) or (y>MaxY) then exit;
  A1:=255-A;
  //pixel[x,y].R:=MauSan[R,pixel[x,y].R,A];
  //pixel[x,y].G:=MauSan[G,pixel[x,y].G,A];
  //pixel[x,y].B:=MauSan[B,pixel[x,y].B,A];
  pixel[x,y].R:=(pixel[x,y].R*A1 + R*A) shr 8;
  pixel[x,y].G:=(pixel[x,y].G*A1 + G*A) shr 8;
  pixel[x,y].B:=(pixel[x,y].B*A1 + B*A) shr 8;
  with pixel[x,y] do
   begin
    WinGraph.Putpixel(x,y,R+G shl 8+ B shl 16);
   end;
 end;
Procedure Diem(x,y : longint; m : longword; A: byte);
 var R,G,B : byte;
 begin
  if (x<0) or (x>GetMaxX) or (x>MaxX) then exit;
  if (y<0) or (y>GetMaxY) or (y>MaxY) then exit;
  R:=Lo(Lo(m));
  G:=Hi(Lo(m));
  B:=Hi(m);
  Diem(x,y,R,G,B,A);
 end;

Procedure Swap(var a,b : longint);
 var tmp : longint;
 begin
  tmp:=a;
  a:=b;
  b:=tmp;
 end;

Procedure Plot(x,y : longint);
 begin
  with CurrentMau32 do
   Diem(x,y,R,G,B,CurrentAlpha);
 end;

procedure BresLine(x0,y0,x1,y1 : longint);
 var dx,dy, err, x , y : longint; step: smallint;
 begin

  if x0>x1 then    { doi nguoc lai thanh TH dac biet }
   begin
    swap(x0,x1);
    Swap(y0,y1);
   end;
  if y0>y1 then step:=-1 else step:=1;   { step=1  khi y tang }

  dx:=x1-x0;
  dy:=abs(y1-y0);

  err:=0; { err la sai so khoang cach cua diem toi dt}

  x:=x0; { cho x va y bat dau tai (x0,y0) }
  y:=y0;
  while (x<=x1) do
   begin
    plot(x,y);

    if err>0 then  { khi sai so <0 thi diem nam duoi dt }
     begin
      err:=err-dx;
      y:=y+step;   {tang y len de diem nam tren dt}
     end
    else
                   {khi err<0 thi diem thoa man cao hon dt}
     begin
      x:=x+1;       { nen tang x len tiep }
      err:=err+dy;
     end;

   end;

 end;

procedure AALine(x0,y0,x1,y1 : longint);
 var dx,dy, x,y : longint; yy,m :real; px,py : ^longint;
     step : integer;
 begin
  px:=@x; py:=@y;
  if abs(x1-x0)<abs(y1-y0) then
   begin
    swap(x1,y1);
    swap(x0,y0);
    px:=@y;
    py:=@x;
   end;
   if x0>x1 then    { doi nguoc lai thanh TH dac biet }
    begin
     swap(x0,x1);
     swap(y0,y1);
    end;
  dx:=x1-x0;
  dy:=y1-y0;
  if dy>=0 then step:=1 else step:=-1;
  dy:=abs(dy);

  //x:=x0;
  //y:=y0;

  for x:=x0 to x1 do
   begin
    yy:=dy*(x-x0)/dx;
    m:=(1-yy+trunc(yy));

    y:=trunc(yy)*step+y0;
    diem(px^,py^,mauht,trunc(CurrentAlpha*m));
    y:=y+step;
    diem(px^,py^,mauht,trunc(CurrentAlpha*(1-m)));
   end;

 end;

Procedure Line(x0,y0,x1,y1 : longint);
 var i , x , y : longint;
 begin
  if (x0=x1) then
   begin
    if y0>y1 then Swap(y0,y1);
    for i:=y0 to y1 do Plot(x0,i);
    exit;
   end;
  if (y0=y1) then
   begin
    if x0>x1 then Swap(x0,x1);
    for i:=x0 to x1 do
     Plot(i,y0);
    exit;
   end;
  if ChedoAA then AALine(x0,y0,x1,y1) else BresLine(x0,y0,x1,y1);
 end;
Procedure Tron(x0,y0 : longint ; R : word);
 var x,y , err : longint;
 begin
  if ChedoAA then begin AATron(x0,y0,R); exit; end;
  x:=R;
  y:=0;
  err:=(5-x*4) div 4;
  while x>=y do
   begin
    plot(x0+x,y0+y);
    plot(x0+x,y0-y);
    plot(x0-x,y0+y);
    plot(x0-x,y0-y);
    plot(x0+y,y0+x);
    plot(x0+y,y0-x);
    plot(x0-y,y0+x);
    plot(x0-y,y0-x);
    if err<0 then err:=err+2*y+1
    else
     begin
      err:=err+2*(y-x)+1;
      dec(x);
     end;
    inc(y);
   end;
 end;

Procedure AAtron(x0,y0: longint; R : word);
 var x: integer; y: real; m: real;
 Function asd(a : real): real;
  begin
   if a>=0 then exit(a-trunc(a))
   else exit(trunc(a)-a);
  end;
 Procedure Plot2(x,y: integer; a: byte);
  var c: longword;
  begin
   c:=mauht;
   diem(x0+x,y0+y,c,a);
   diem(x0-x,y0+y,c,a);
   diem(x0-x,y0-y,c,a);
   diem(x0+x,y0-y,c,a);
   diem(x0+y,y0+x,c,a);
   diem(x0-y,y0+x,c,a);
   diem(x0-y,y0-x,c,a);
   diem(x0+y,y0-x,c,a);
  end;
 begin
  x:=0;
  y:=R;
  while x<=y do
   begin
    m:=asd(y)*CurrentAlpha;
    plot2(x,trunc(y)+1,trunc(m));
    //plot2(x,trunc(y),CurrentAlpha);
    plot2(x,trunc(y),trunc(CurrentAlpha-m));
    inc(x);
    y:=sqrt(R*R-x*x);
   end;
 end;

Procedure FillTron(x0,y0 : longint; R : word);
 var x,y : longint; midx: longint; m: byte;
     yy : real;
 begin
  line(x0,y0-R,x0,y0+R);
  midx:=trunc(R/Sqrt(2));
  Line(x0+midx+1,y0,x0+R,y0);
  Line(x0-midx-1,y0,x0-R,y0);
  for x:=1 to midx do
   begin
    yy:=Sqrt(R*R-x*x);
    y:=trunc(yy);

    if ChedoAA Then Begin
     m:=Trunc( CurrentAlpha*(( yy-trunc(yy) ) ) );
     Diem(x0+x,y0+y+1,MauHt,m);
     Diem(x0+x,y0-y-1,MauHt,m);
     Diem(x0-x,y0+y+1,MauHt,m);
     Diem(x0-x,y0-y-1,MauHt,m);
     End;

    Line(x0+x,y0-y,x0+x,y0+y);
    Line(x0-x,y0-y,x0-x,y0+y);
   end;
  For x:=1 to midx do
   Begin
    yy:=Sqrt(R*R-x*x);
    y:=trunc(yy);

    if ChedoAA Then Begin
     m:=Trunc( CurrentAlpha*(( yy-trunc(yy) ) ) );
     Diem(x0+y+1,y0+x,MauHt,m);
     Diem(x0+y+1,y0-x,MauHt,m);
     Diem(x0-y-1,y0+x,MauHt,m);
     Diem(x0-y-1,y0-x,MauHt,m);
     End;

    Line(x0+midx+1,y0+x,x0+y,y0+x);
    Line(x0-midx-1,y0+x,x0-y,y0+x);
    Line(x0+midx+1,y0-x,x0+y,y0-x);
    Line(x0-midx-1,y0-x,x0-y,y0-x);
   End;
 end;


end.
