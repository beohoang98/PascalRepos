uses crt, wincrt, wingraph;

const  //Tx = 770; Ty = 320 ; Tr = 10;
       maxS = 10;   {Trai,GTrai,GPhai,Phai,Vantoc}
       maxP = 500;
       maxM = 10000;
       numr = 3;
       dr : array[1..numr] of integer=(-5,0,5);
       sopx = 7;
       phanxa : array[0..sopx-1] of integer=(-10,-5,-2,0,2,5,10);
       V = 10;
       DBien = 100;
       Cx1 = 50; Cx2 = 750;
       Cy1 = 50; Cy2 = 550;
       DV = 20;
       Phi = 90;

type   DNA = array[0..maxS*2] of integer;
       An = record
             Gen : DNA;
             x,y,g : real;
             Vt : word;
             song : dword;
             die : boolean;
            end;

var    F : array[1..maxP] of DNA;
       Me : array[1..maxP] of An;
       MP : array[0..maxM*maxM] of dword;
       i,j : word;
       DiDuoc : array[-10..810,-10..610] of boolean;
       Tx,Ty,Tr : word;

Procedure Ktao(var A : An);
 begin
  for i:=1 to maxS*2 do
  A.Gen[i]:=phanxa[random(sopx)];

  A.Gen[0]:=random(V)+1;
  A.die:=false;
  A.song:=0;
  A.Vt:=A.Gen[0];
 end;

Procedure Init;
 var gd,gm : smallint; i : word;
 begin
  gd:=d8bit; gm:=m800x600;
  InitGraph(gd,gm,'');
  randomize;
  for i:=1 to maxP do Ktao(Me[i]);
  FillChar(DiDuoc,Sizeof(diDuoc),False);
  For i:=0 to 800 do
   for j:=0 to 600 do
    DiDuoc[i,j]:=true;
  for i:=Cx1 to Cx2 do
   for j:=Cy1 to Cy2 do
    if (i mod 100 <70) and (j mod 100 <70) then DiDuoc[i,j]:=false;

 end;

Procedure KTViTri;
 var i : word;
 begin
  for i:=1 to maxP do
   begin
    Me[i].g:=random(360)*pi/180;
    Me[i].x:=0;
    Me[i].y:=GetMaxY div 2;
    Me[i].die:=false;
    Me[i].song:=0;
    Me[i].Vt:=Me[i].Gen[0];
   end;
 end;

Function Diem(A : An): dword;
 begin
  exit(A.song*A.Vt);
 end;

Function Nhan(A,B : DNA): DNA;
 var i,k: word;
 begin
  Nhan:=A;
  k:=random(MaxS);
  for i:=k to maxS*2 do
   Nhan[i]:=B[i];
 end;

Procedure ChonLoc;
 var i,j : word;  d : dword;  s : dword;
 begin
  FillChar(MP,sizeof(MP),0);
  s:=0;
  for i:=1 to maxP do
   s:=s+Diem(Me[i]);

  for i:=1 to maxP do
   begin
    d:=trunc(sqr((diem(Me[i])+1)/(s+1))*maxM);
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
  for i:=1 to maxP do F[i]:=Me[i].Gen;
  for i:=1 to maxP do
   begin
    c1:=random(MP[0])+1;
    c2:=random(Mp[0])+1;
    F[i]:=Nhan(Me[MP[c1]].Gen,Me[MP[c2]].Gen);
   end;
  for i:=1 to maxP do Me[i].Gen:=F[i];
 end;

Procedure DotBien;
 var i,j : word;
 begin
  for i:=1 to maxP do
   for j:=1 to maxS*2 do
   if random(DBien)=1 then
    begin
     Me[i].Gen[j]:=phanxa[random(sopx)];
    end;
 end;

Function XuLi(A : An; goc: integer): boolean;
 var xx,yy,r : real; i : byte;
 begin
  r:=A.g+goc*pi/180;
  for i:=1 to DV do
   begin
    xx:=A.x+i*cos(r);
    yy:=A.y+i*sin(r);
    //if (xx<0) or (xx>GetMaxX) or (yy<0) or (yy>GetMaxY)
    if DiDuoc[trunc(xx),trunc(yy)]=false then exit(true);
   end;
  exit(false);
 end;


Procedure Ve;
 var i,j,count,time,k : word; xx,yy : real ;
 begin
  cleardevice;
  count:=maxP;
  time:=0;
  for i:=Cx1 to Cx2 do
   for j:=Cy1 to Cy2 do
    if DiDuoc[i,j]=false then putpixel(i,j,15);
  Tx:=random(700)+100;
  Ty:=random(600)+1;
  Tr:=20;
  repeat
  for j:=1 to maxP do
   if Me[j].die=false then
    with Me[j] do
     begin
      for k:=1 to maxS do
       if Xuli(Me[j],k*Phi div maxS) then g:=g+Gen[k]*pi/180;
      for k:=maxS+1 to maxS*2 do
       if Xuli(Me[j],-((k-MaxS)*Phi div maxS)) then g:=g+Gen[k]*pi/180;
      xx:=x;
      yy:=y;
      x:=x+cos(g)*Vt;
      y:=y+sin(g)*Vt;
      {if (x*(x-GetMaxX)>0) or (y*(y-GetMaxY)>0) then
       begin
        die:=true;
        dec(count);
        continue;
       end; }
      if DiDuoc[trunc(x),trunc(y)]=false then
       begin
        die:=true;
        dec(count);
        continue;
       end;
      if (sqr(Me[j].x-Tx)+sqr(Me[j].y-Ty) <= Tr*Tr) then
       begin
        song:=20*(1000-song);
        die:=true;
        continue;
       end;
      setcolor(0);
      circle(trunc(xx),trunc(yy),2);
      setcolor(j);
      circle(trunc(x),trunc(y),2);

      inc(song);
     end;
  //Bar(Cx1,Cy1,Cx2,Cy2);
  setcolor(12);
  Circle(Tx,Ty,Tr);
  UpdateGraph(2);
  delay(5);
  //cleardevice;
  inc(time);
  gotoxy(10,1);
  writeln(time);
  writeln(count);
  until (count<=0) or (time>1000);
  clrscr;
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
    //for j:=0 to maxS*2 do write(Me[i].Gen[j]);
    writeln(' ',Diem(Me[i]):2);
   end;
 until keypressed;
 closegraph;
end.
