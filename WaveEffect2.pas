Program Song;

uses windows, wingraph, wincrt, winmouse;

const MaxX=100; MaxY=100; step=99.5/100;  Ms=0.015; Ygiua = 300; count=5;
      chu : array[1..16*5] of word=(1,1,1,0,0,1,1,1,0,1,1,1,0,1,0,1,
                                    1,0,0,1,0,1,0,0,0,0,1,0,0,1,0,1,
                                    1,1,1,0,0,1,1,1,0,0,1,0,0,1,1,1,
                                    1,0,0,1,0,1,0,0,0,0,1,0,0,1,0,1,
                                    1,1,1,0,0,1,1,1,0,0,1,0,0,1,0,1);

Var  chdiem : array[0..MaxX,0..MaxY] of record
                                 y : real;
                                 V,a : real;
                                end;
     Chau : array[0..maxX,0..MaxY] of boolean;
     i,j,k,q : integer;   m:real;
     t : word;

Procedure Init;
 var gd,gm,k1,k2 : smallint;
 begin
  gd:=d8bit;
  gm:=m800x600;
  InitGraph(gd,gm,'');
  UpdateGraph(0);
  FillChar(Chau,sizeof(chau),true);
  for j:=1 to 5 do
   for i:=1 to 16 do
    if (chu[i+(j-1)*16]=1) then
    begin
     for k1:=0 to 3 do
      for k2:=0 to 3 do
       Chau[i*4+k1,j*4+k2]:=false;
    end;
  for i:=1 to maxX do
   for j:=1 to maxY do
    if (sqr(j-50-abs(i-50))+sqr(i-50)-135<0) then
     Chau[i,maxY-j]:=false;
  for i:=0 to maxX do
   for j:=0 to MaxY do
   begin
    chdiem[i,j].y:=Ygiua;
    chdiem[i,j].V:=0;
    chdiem[i,j].a:=0;
   end;
  for i:=0 to 255 do setRGBpalette(i,i*3 div 4,0,i);
 end;

Procedure Tinhgt(i,j: word);
 var k,t : word;
 begin
  for k:=i-1 to i+1 do
   for t:=j-1 to j+1 do if (k<>i) and (t<>j) then
     begin
      chdiem[i,j].a:=chdiem[i,j].a+(chdiem[k,t].y-chdiem[i,j].y);
      chdiem[k,t].a:=chdiem[k,t].a-(chdiem[k,t].y-chdiem[i,j].y);
     end;
 end;

Procedure Tinh(i,j : word);
 var k,t : word;
 begin
  with chdiem[i,j] do
   begin
    V:=(V+a*ms)*step; y:=y+V; a:=(Ygiua-y);
   end;
 end;

begin
 Init;
 //chdiem[10,10].V:=5;
 t:=0;
 repeat
  if GetMouseButtons=1 then
   begin
    i:=GetMouseX; j:=GetMouseY;
    if (i>1*2)and(i<MaxX*2)and(j>1*2)and(j<MaxY*2)
    then
     for k:=-2 to 2 do
      for q:=-2 to 2 do chdiem[i div 2+k,j div 2+q].V:=5;
   end;
  inc(t);
  for i:=1 to MaxX-1 do
   for j:=1 to MaxY-1 do if Chau[i,j] then Tinhgt(i,j);
  for i:=1 to MaxX-1 do
   for j:=1 to MaxY-1 do if Chau[i,j] then Tinh(i,j);
  if t>=count then
   begin
    cleardevice;
    for i:=1 to MaxX do
     for j:=1 to MaxY do
     begin
      m:=-(chdiem[i,j].y-chdiem[i-1,j-1].y);
      if abs(m)>5 then if m>0 then m:=255 else m:=0
      else m:=(m*128/5)+128;
      setFillStyle(1,trunc(m));
      bar(i*2,j*2,i*2+1,j*2+1);
     end;
    //setcolor(255);
    {for i:=1 to MaxX do
     begin
      putpixel(i,trunc(chdiem[i,10].y)-1,64);
      putpixel(i,trunc(chdiem[i,10].y),255);
      putpixel(i,trunc(chdiem[i,10].y)+1,192);
     end;             }
    UpdateGraph(2);
    t:=0;
   end;
  //delay(5);

 until keypressed;
 CloseGraph;
 repeat until messagebox(0,'Hay khong?','Warning',MB_YESNO)=IDYES;
end.
