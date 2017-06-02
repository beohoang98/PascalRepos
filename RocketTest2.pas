uses crt, wincrt, wingraph;

const  Tx = 500; Ty = 300 ;
       maxS = 110;
       maxP = 500;
       maxM = 10000;
       numr = 3;
       dr : array[1..numr] of integer=(-5,0,5);
       V = 5;
       DBien = 250;
       Cx1 = 200; Cx2 = 210;
       Cy1 = 200; Cy2 = 300;

type   DNA = array[1..maxS] of word;

var    G, F : array[1..maxP] of DNA;
       R : array[1..maxP] of record
                                   x,y,g : real;
                                  end;
       MP : array[0..maxM*maxM] of dword;
       i,j : word;

Procedure Ktao(var A : DNA);
 var i : word;
 begin
  for i:=1 to maxS do A[i]:=random(numr)+1;
 end;

Procedure Init;
 var gd,gm : smallint; i : word;
 begin
  gd:=d8bit; gm:=m800x600;
  InitGraph(gd,gm,'');
  randomize;
  for i:=1 to maxP do Ktao(G[i]);

 end;

Procedure KTViTri;
 var i : word;
 begin
  for i:=1 to maxP do
   begin
    R[i].g:=0;
    R[i].x:=0;
    R[i].y:=GetMaxY div 2;
   end;
 end;

Function Diem(i : word): real;
 var d : real;
 begin
  d:=sqrt(sqr(R[i].x-Tx)+sqr(R[i].y-Ty));
  if d<1 then d:=1;
  //Writeln((400/d):2:3,' ',i:2);
  exit((600/d));
 end;

Function Nhan(A,B : DNA): DNA;
 var i,k: word;
 begin
  Nhan:=A;
  k:=random(MaxS-2)+2;
  for i:=k to maxS do
   Nhan[i]:=B[i];
 end;

Procedure ChonLoc;
 var i,j : word;  d : longint;  s : double;
 begin
  FillChar(MP,sizeof(MP),0);
  s:=0;
  for i:=1 to maxP do
   s:=s+Diem(i);

  for i:=1 to maxP do
   begin
    d:=trunc(sqr(diem(i)/s)*maxM);
    for j:=1 to d do
     begin
      if MP[0]=maxM*maxM then exit;
      inc(MP[0]);
      MP[MP[0]]:=i;
     end;
   end;
 end;

Procedure SinhSan;
 var i,c1,c2 : dword;
 begin
  if MP[0]<3 then exit;
  F:=G;
  for i:=1 to maxP do
   begin
    c1:=random(MP[0])+1;
    c2:=random(Mp[0])+1;
    F[i]:=Nhan(G[MP[c1]],G[MP[c2]]);
   end;
  G:=F;
 end;

Procedure DotBien;
 var i,j : word;
 begin
  for i:=1 to maxP do
   for j:=1 to maxS do
   if random(DBien)=1 then
    G[i,j]:=random(numr)+1;
 end;

Procedure Ve;
 var i,j : word; xx,yy : real ;
 begin
  cleardevice;
  for i:=1 to maxS do
   begin
    for j:=1 to maxP do
     begin
      R[j].g:=R[j].g+dr[G[j,i]]*pi/180;
      if R[j].g>=pi then R[j].g:=-pi;
      if R[j].g<=-pi then R[j].g:=pi;
      xx:=R[j].x;
      yy:=R[j].y;
      R[j].x:=R[j].x+cos(R[j].g)*V;
      R[j].y:=R[j].y+sin(R[j].g)*V;
      if ((R[j].x-Cx1)*(R[j].x-Cx2)<0) and ((R[j].y-Cy1)*(R[j].y-Cy2)<0)
      then begin R[j].x:=xx; R[j].y:=yy; end;
      setcolor(j);
      line(trunc(R[j].x),trunc(R[j].y),trunc(xx),trunc(yy));
     end;
    setcolor(13);
    Circle(Tx,Ty,4);
    Bar(Cx1,Cy1,Cx2,Cy2);
    UpdateGraph(2);
    delay(40);
    cleardevice;
    //Writeln(i);
   end;
 end;

begin
 Init;
 UpdateGraph(0);
 repeat
  ChonLoc;
  SinhSan;
  DotBien;
  KTViTri;
  Ve;
  crt.gotoxy(1,1);
  for i:=1 to maxP do
   begin
    //for j:=1 to maxS do write(G[i,j]);
    writeln(' ',Diem(i):0:2);
   end;
 until keypressed;
 closegraph;
end.
