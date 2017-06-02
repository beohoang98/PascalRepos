uses crt, graph,ve3d, windows;
var x,y,z : array[1..100] of integer; b1,fps:string;
    i,k,q,xfood,yfood,gd,gg: integer; bien1,bien2: char; a,b:integer;
    h,h1,h2,h3,h4,t,t1,rz,kq : longint;



       {*************TAO CAC HAM DE LAP TRINH**************}
procedure hoandoi(i,j : integer);
 var t : longint;
 begin
  t:=x[1];
  x[1]:=i*y[1];
  y[1]:=j*t;
 end;

procedure food(n : byte);

 begin
  if n <> 0 then begin
  if (xfood<=x[1]+10) and (xfood>=x[1]-10)
  and(yfood<=y[1]+10) and (yfood>=y[1]-10) then
  begin
  xfood:=random(h2)+h1;yfood:=random(h4)+h3;
  B:=b+1;

  end;
  end;
  color(n);cau(xfood-x[1],yfood-y[1],0-z[1],5);
 end;

procedure veran(n : byte);
 begin


  if n <> 0 then
  begin
  for i:=b downto 2 do
   begin
   x[i]:=x[i-1];
   y[i]:=y[i-1];
   z[i]:=z[i-1];
   end;
  x[1]:=x[1]-k;
  y[1]:=y[1]-q;
  z[1]:=z[1]-kq;
  end;
  for i:=b downto 2 do begin
   color(n); cau(x[i]-x[1],y[i]-y[1],z[i]-z[1],5);
   color(8);
   line3d(x[i]-x[1],y[i]-y[1],z[i]-z[1]-5,x[i]-x[1]-10,y[i]-y[1],z[i]-z[1]-5);
   line3d(x[i]-x[1],y[i]-y[1]+2,z[i]-z[1]-5,x[i]-x[1]-10,y[i]-y[1]+2,z[i]-z[1]-5);
   line3d(x[i]-x[1],y[i]-y[1]-2,z[i]-z[1]-5,x[i]-x[1]-10,y[i]-y[1]-2,z[i]-z[1]-5);
   end;
 end;


procedure gioihan(n : byte);
 begin
 color(n);
 box(h1-x[1],h3-y[1],0-z[1],h2-h1,h4-h3,10);
 end;

procedure cham;
 begin
  if (x[1]<=h1) or (x[1]>=h2) then
   begin
    h:=(360-h);
    xoay(h+180,40);
   end;

  if (y[1]<=h3) or (y[1]>=h4) then
   begin
    h:=180-h;
    xoay(h+180,40);
   end;
 end;

procedure thang;
 begin
  if b=100 then bien1:='0';
 end;

procedure thua;
 begin
  for i:=2 to b do
  begin
   if ((x[1]<=x[i]+2) and (x[1]>=x[i]-2))
    and ((y[1]>=y[i]-2) and (y[1]<=y[i]+2))
    and ((z[i]>=z[1]-2) and (z[1]<=z[i]+2))
   then bien2:='t';
  end;
 end;

procedure kthuc;
 begin
  delay(500);
  for i:=1 to 10 do
   begin
   setcolor(i);
   outtextxy(150,100,'       Üß              ÜßßÜ    ');
   outtextxy(150,110,' Ü   Ü Ü    Ü   Ü Ü  Ü  ÜÜ  Ü  ');
   outtextxy(150,120,'  ßÜß  Û    ÛßÜßÛ Û  Û Û  Û Û  ');
   outtextxy(150,130,' Üß ßÜ Û    Û   Û ÛÜÜÛ ßÜÜß Û  ');
   outtextxy(150,140,'                         Ü     ');
   delay(200);
   end;
 end;

{************************BAT DAU CHUONG TRINH*******************}

begin
 h:=0;
 h1:=-200;h2:=200;
 h3:=-200;h4:=200;
 randomize;b:=2;gd:=0;gg:=0;
 clrscr;
 x[1]:=0;y[1]:=0;z[1]:=0;
 k:=0;q:=1;xfood:=100;yfood:=100;
 khoitao(500,300,200,0,0,0,600);
 initgraph(gd,gg,'');
 graph.setbkcolor(15);
 repeat
  repeat
  delay(20);
  cls;

  k:=trunc(15*sin(h*pi/180)*cos(rz*pi/180));
  q:=trunc(15*cos(h*pi/180)*cos(rz*pi/180));
  kq:=trunc(15*sin(rz*pi/180));
  str(b,b1);
  setcolor(16);
  outtextxy(50,350,' Bam so 0 de BO CUOC , so diem cua ban la: '+b1+' fps:'+fps);
  outtext('FPS:'+fps);
  color(10);cau(0,0,0,5);
  veran(2);food(14);
  gioihan(16);
  cham;
  thua;

  if t<>0 then str(trunc(1000/t),fps);
  t:=(gettickcount-t1);
  t1:=gettickcount;
  until crt.keypressed or (bien2='t');

  if crt.keypressed then bien1:=crt.readkey;
  thang;
  case bien1 of
   #75 : h:=h-10;
   #77 : h:=h+10;
  end;

  xoay(h+180,40);
  until (bien1='0') or (bien2='t') ;

 if b<100 then kthuc else write('   WIN ---- ',b,' diem');
 readln;
 closegraph;
end.


