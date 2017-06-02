uses wingraph in 'src/wingraph.pas'
     , wincrt in 'src/wincrt.pas'
     ,windows ;

var gd,gm : smallint;
    i,j : integer;
    p1, p2 : array[0..800,0..600] of boolean;
    X,Y,Len,Hig : word;  kq : longint;

procedure VietChu(s : string);
 var i,j : Word;
 begin
  cleardevice;
  fillchar(p1,sizeof(p1),false);
  Len:=TextWidth(s);
  HIG:=TextHeight(s);
  if Len>GetMaxX then Len:=GetMaxX;
  X:=(GetMaxX-Len) div 2;
  Y:=(GetMaxY-hig) div 2;
  MoveTo(X,Y);
  OutText(S);

  for i:=0 to GetMaxX do
   for j:=0 to GetMaxY do
    p1[i,j]:=wingraph.getpixel(i,j)<>1;

  cleardevice;

 end;

procedure HieuUng;
 const  Max=600;
 var  i,j,t : word;  tm : boolean;
 begin
  fillchar(p2,sizeof(p2),false);
  t:=32;
  repeat
   inc(t);
   if t>72 then t:=32;
   delay(50);
   cleardevice;
   for i:=0 to 800 do
    for j:=0 to 600 do
     if p1[i,j] then
      putpixel(i,j,(j-x)*32 div hig+t);
   UpdateGraph(2);
  until keypressed or CloseGraphRequest;

 end;

begin
 gd:=d8bit; gm:=m320x200;
 initgraph(gd,gm,''); UpdateGraph(0);
 wingraph.setbkcolor(1);
 setRGBpalette(13,128,0,255);
 setcolor(13);
 InstallUserFont('VNI-Kun');
 SetTextStyle(4,5,72);
 cleardevice;
 Randomize;
 VietChu('Bethany');
 HieuUng;



 closegraph;
 repeat
  kq:=windows.messageBox(0,'Hay ko?','',MB_YesNo);
 until kq=IDYES ;
 windows.messageBox(0,'phai hay thoi =))','',0);
end.
