uses crt, graph;
var x,y : array[1..50] of integer; b1:string;
    i,k,q,xfood,yfood,gd,gg: integer; bien1,bien2: char; a,b:integer;

       {*************TAO CAC HAM DE LAP TRINH**************}
procedure food;
 begin
  setcolor(yellow);
  if (xfood<=x[1]+5) and (xfood>=x[1]-5)
  and(yfood<=y[1]+5) and (yfood>=y[1]-5) then
  begin
  xfood:=random(494)+5;
  yfood:=random(294)+5;
  B:=b+1;
  end;
  circle(xfood,yfood,3);
 end;

procedure gioihan;
 begin
 setcolor(white);
 for a:=3 to 500 do begin

  circle(a,3,1);
  circle(a,300,1);
  end;
 for a:=3 to 300 do begin
  circle(3,a,1);
  circle(500,a,1);
  end;
 end;

procedure cham;
 begin
  if x[1]<=3 then x[1]:=499;
  if x[1]>=500 then x[1]:=4;
  if y[1]<=3 then y[1]:=299;
  if y[1]>=300 then y[1]:=4;
 end;
procedure thang;
 begin
  if b=28 then bien1:='0';
 end;

procedure thua;
 begin
  for i:=2 to b do
  begin
   if (x[1]=x[i]) and (y[1]=y[i]) then bien2:='t';
  end;
 end;

procedure kthuc;
 begin
  clrscr;delay(500);
  for i:=1 to 10 do
   begin
   textcolor(i);sound(i*100);
   gotoxy(15,10);write('       ‹ﬂ              ‹ﬂﬂ‹    ');
   gotoxy(15,11);write(' ‹   ‹ ‹    ‹   ‹ ‹  ‹  ‹‹  ‹  ');
   gotoxy(15,12);write('  ﬂ‹ﬂ  €    €ﬂ‹ﬂ€ €  € €  € €  ');
   gotoxy(15,13);write(' ‹ﬂ ﬂ‹ €    €   € €‹‹€ ﬂ‹‹ﬂ €  ');
   gotoxy(15,14);write('                         ‹     ');
   delay(200);nosound;
   end;
 end;

{************************BAT DAU CHUONG TRINH*******************}

begin
 randomize;b:=2;gd:=0;gg:=0;
 clrscr;initgraph(gd,gg,'D:\TP\BGI');
 x[1]:=100;y[1]:=100;k:=1;q:=0;xfood:=100;yfood:=100;
 repeat
  repeat
  str(b,b1);
  outtextxy(50,350,' Bam so 0 de BO CUOC , so diem cua ban la: '+b1);
  gioihan;
  for i:=b downto 2 do
   begin
   x[i]:=x[i-1];
   y[i]:=y[i-1];
   end;
  x[1]:=x[1]+k;
  y[1]:=y[1]+q;
  cham;food;thua;
  setcolor(blue);
  for i:=1 to 5 do circle(x[1],y[1],i);
  setcolor(green);
  circle(x[1],y[1],i);
  for i:=2 to b do begin

   circle(x[i],y[i],5);
   end;
  delay(50);cleardevice;
  until keypressed or (bien2='t');
  if keypressed then bien1:=readkey;thang;
  if (bien1=#77) and (k=0) then begin k:=10;q:=0; end;
  if (bien1=#75) and (k=0) then begin k:=-10;q:=0; end;
  if (bien1=#80) and (q=0) then begin k:=0;q:=10; end;
  if (bien1=#72) and (q=0) then begin k:=0;q:=-10; end;
 until (bien1='0') or (bien2='t') ;
 closegraph;
 if b<28 then kthuc else write('   WIN ---- ',b,' diem');
 readln;
end.