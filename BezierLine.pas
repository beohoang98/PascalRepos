program Bezier_Line;

uses wincrt, graph, winmouse;

type ptype = record  x,y : longint; end;
     arrayp = array[1..20] of ptype;

var gd,gm : smallint;
    a : arrayp;    X,Y : longint;
    sd,i : word;
    M1,M2: longint;
    s : string; ch: char;

function mu(a: real; n :word): real;
 var k : real;i : word;
 begin
  k:=1;
  for i:=1 to n do k:=k*a;
  exit(k);
 end;

function MouseMove(var X,Y,M  : longint) : boolean;
 var X1,Y1,i : longint;
 begin

  for i:=1 to 10 do GetMouseState(X1,Y1,M);

  if (x=x1) and (y=y1) then exit(false);
  X:=X1; Y:=Y1;
  exit(true);
 end;

procedure Bline(n: word;a : arrayp);
 var t,t1 : real; x1,y1,x2,y2 :real ;i,j : longint;
     C : array[1..100,0..100] of longword;
 begin
  if n=1 then exit;

  t:=0;  moveto(a[1].x,a[1].y);

  C[1,0]:=1;C[1,1]:=1;
  for i:=2 to n do
   begin
    C[i,0]:=1;
    C[i,i]:=1;
    for j:=1 to i-1 do
     begin
      C[i,j]:=C[i-1,j]+C[i-1,j-1];
     end;
   end;
  while t<0.5 do
   begin

    x1:=0;y1:=0;x2:=0;y2:=0;
    for i:=0 to n-1 do
     begin
      t1:=mu(t,n-1-i)*mu(1-t,i);

      x1:=x1+a[i+1].x*C[n-1,i]*t1;
      y1:=y1+a[i+1].y*C[n-1,i]*t1;
      x2:=x2+a[n-i].x*C[n-1,i]*t1;
      y2:=y2+a[n-i].y*C[n-1,i]*t1;
     end;
    //setcolor(trunc(t*10)+40);
    putpixel(trunc(x1),trunc(y1),15);
    putpixel(trunc(x2),trunc(y2),15);
    t:=t+0.1/n;
   end;

 end;

begin
 initgraph(gd,gm,'');
 InitMouse;

 repeat
 sd:=1;M1:=1;
 fillchar(a,sizeof(a),0);
 while not(keypressed) do
  begin
   delay(30);
   cleardevice;
   GetMouseState(a[sd].x,a[sd].y,M2);
   if (M2=1) and (M1<>M2) then inc(sd);
   M1:=M2;
   //a[sd].x:=x; a[sd].y:=y;
   str(sd,s);
   outtextxy(10,10,s);
   Bline(sd,a);
   moveto(a[1].x,a[1].y);
   for i:=2 to sd do lineto(a[i].x,a[i].y);
  end;
  ch:=readkey;
  if ch=#27 then exit;

 until false;
 closegraph;
end.
