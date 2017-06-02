uses winGraph
     , wincrt in 'src/wincrt.pas'
     , windows ;

var gd,gm : smallint;
    i,j : integer;
    p1, p2 : array[0..800,0..600] of boolean;
    X,Y,Len,Hig : word;  kq : longint;

procedure VietChu(s : string);
 var i,j : Word;
 begin
  Cleardevice;
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
    p1[i,j]:=WinGraph.Getpixel(i,j) <> 1;

  Cleardevice;

 end;

procedure HieuUng;
 const  Max=600;
 var m : array[1..Max] of record
                            x,y : integer;
                           end;
     i,j,t : word;  tm : boolean;
 begin
  fillchar(p2,sizeof(p2),false);
  for i:=1 to Max do
   begin
    m[i].x:=random(GetMaxX)+1;
    m[i].y:=-random(Max);
   end;
  t:=1;
  repeat
   delay(15);
   Cleardevice;


   for i:=1 to Max do
    begin
     tm:=false;
     if random(100)=1 then t:=random(3);
     m[i].y:=m[i].y+random(3);
     m[i].x:=m[i].x+random(3)-t;
     if (m[i].x>0) and (m[i].x<GetMaxX) and (m[i].y >0) and (m[i].y<GetMaxY) then
      if (p1[m[i].x,m[i].y]) and not(p2[m[i].x,m[i].y]) then
       begin p2[m[i].x,m[i].y]:=true;  tm:=true; end;

     PutPixel(m[i].x,m[i].y,13);
     if (m[i].y>=GetMaxY) or tm then
      begin
       m[i].x:=random(GetMaxX);
       m[i].y:=0;
      end;
    end;
   for i:=0 to GetMaxX do
    for j:=0 to GetMaxY do
     if p1[i,j] then
      if p2[i,j] then Putpixel(i,j,13);

   UpdateGraph(2);
  until keypressed or CloseGraphRequest;

 end;

begin
 gd:=d8bit; gm:=m320x200;
 InitGraph(gd,gm,'');
 UpdateGraph(0);
 WinGraph.SetBkColor(1);
 SetColor(13);
 gd:=InstallUserFont('VNI-Kun-Bold');
 SetTextStyle(gd,5,75);
 Cleardevice;
 Randomize;
 VietChu('Bethany');
 HieuUng;



 closegraph;
 repeat
  kq:=windows.messageBox(0,'Hay ko?','',MB_YesNo);
 until kq=IDYES ;
 windows.messageBox(0,'phai hay thoi =))','',0);
end.
