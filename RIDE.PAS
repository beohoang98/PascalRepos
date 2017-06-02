program ride;

uses crt,graph;
var a,b,xt,yt:integer; xs,ys: array[1..5] of integer;
                   ks,qs: integer;c,d:boolean;
                   xc,yc: array[1..4] of integer;
    bien: char;diem: byte;
    s:string;

procedure gioihan;
 begin
  line(1,3,500,3);
  line(1,300,500,300);
 end;

procedure nhanvat;
 begin
  ks:=ks+qs;delay(10);
  ys[1]:=ys[1]+ks;
  xs[2]:=xs[1]+20;ys[2]:=ys[1];
  xs[3]:=xs[2]-10;ys[3]:=ys[2]-5;
  xs[4]:=xs[1];ys[4]:=ys[3]-10;
  xs[5]:=xs[3];ys[5]:=ys[4]-4;
  line(xs[1],ys[1],xs[2],ys[2]);
  line(xs[1],ys[1],xs[4],ys[4]);
  line(xs[2],ys[2],xs[4],ys[4]);
  line(xs[3],ys[3],xs[5],ys[5]);
  circle(xs[1],ys[1],4);circle(xs[2],ys[2],4);
  circle(xs[5],ys[5],4);
 end;

procedure cham;
 begin
  if ys[1]>=294 then begin
   ys[1]:=293;qs:=-ks;
   c:=true;
   end
  else
   begin
    qs:=1; c:=true;
   end;
  while ys[1]<=26 do
   begin
    c:=false;ys[1]:=27;qs:=-ks;
   end;

 end;

procedure vatcan(i:integer);
 begin
  yc[i+1]:=yc[i]+100;
  xc[i]:=xc[i]-10;xc[i+1]:=xc[i];
  line(xc[i],yc[i],xc[i+1],yc[i+1]);
   if xc[i]<=1 then
   begin
   xc[i]:=500;
   yc[i]:=random(297)+3;
   end;
  if ((ys[5]<yc[i+1]) and (ys[1]>yc[i])) and ((xs[1]=xc[i])
  or (xs[2]=xc[i])) then halt;
  if xs[2]=xc[i] then diem:=diem+1;
 end;

procedure tien;
 begin
   yt:=trunc(sin(xt)*50)+150;
   circle(xt*5,yt,5);xt:=xt+1;
   if xt>=500 then xt:=-50;
   if (xs[5]<=xt*5) and (xs[1]>=xt*5)
   and ((ys[1] or ys[2]) = yt) then diem:=diem*2;
 end;



begin
 randomize;d:=false;xt:=0;diem:=0;
 a:=0;b:=0;xs[1]:=100;ys[1]:=100;ks:=1;qs:=1;yc[1]:=3;xc[1]:=500;
 initgraph(a,b,'D:\TP\BGI');textcolor(0);
 repeat
  repeat
  nhanvat;vatcan(1);cham;tien;
  if xc[1]=200 then d:=true;
  if d then vatcan(3);
  gioihan;str(diem,s);
  outtextxy(200,350,'DIEM: ');
  outtextxy(250,350,s);
  delay(40);
  cleardevice;
  until keypressed;
  bien:=readkey;
  if (bien=#72) and c then qs:=-10;
 until bien='0';
 closegraph;
end.
