
uses wincrt in 'src/wincrt.pas', wingraph in 'src/wingraph.pas', windows;

type cau=record
      m,R,Vx,Vy,x,y : real;
      q,fe : real;
     end;

     dt=record
      x,y : array[1..2] of integer;
     end;
     canh=record
      D : array[1..2] of ^cau;
      l: word;
      duong : dt;
     end;
const n =20;  g =10;ms=0.9; step=10000; bou=1; frame=5; cung=0.9;
      quay=true;

var gd,gm,i,j : smallint;
    ball : array[1..1000] of cau;

    nen1,nen2,nen3 : dt; nen4 : canh;
    time : longint;
    ch : char;

function goc(x,y : real):real;
 begin
  if x=0 then
   if y>0 then exit(pi/2)
   else exit(-pi/2);
  if x>0 then exit(arctan(y/x))
  else exit(arctan(y/x)+pi);
 end;

procedure khoitaovat(var a: cau;m,r,Vx,Vy,x,y : real);
 begin
  a.m:=m;
  a.r:=r;
  a.vx:=vx;
  a.vy:=vy;
  a.x:=x;a.y:=y;
 end;

procedure taodt(var a: dt;x1,y1,x2,y2: integer);
 begin
  a.x[1]:=x1;
  a.x[2]:=x2;
  a.y[1]:=y1;
  a.y[2]:=y2;
 end;



procedure vedt( var a : dt);
 begin
  line(a.x[1],a.y[1],a.x[2],a.y[2]);
 end;

procedure vevat(var a: cau; i: longword);

 begin
  setcolor(i);
  //putpixel(trunc(a.x),trunc(a.y),i);
  setfillstyle(1,$0000FF);
  fillellipse(trunc(a.x),trunc(a.y),trunc(a.R),trunc(a.R));
  //circle(trunc(a.x),trunc(a.y),trunc(a.R));

  if quay then line(trunc(a.x),trunc(a.y),trunc(a.x+a.R*cos(a.q)),trunc(a.y+a.R*sin(a.q)));

 end;

procedure vecanh( A : canh);
 begin
  vevat(A.d[1]^,$FFFFFF);
  vevat(A.d[2]^,$FFFFFF);
  vedt(A.duong);
 end;

procedure taocanh(var C: canh;a,b : cau;l : word);
 begin
  C.d[1]:=@a;
  C.d[2]:=@b;
  C.l:=l+20;
  with c do
   taodt(duong,trunc(d[1]^.x),trunc(d[1]^.y),trunc(d[2]^.x),trunc(d[2]^.y));
 end;

procedure trongluc(var a : cau);
 begin
  a.Vy:=a.Vy+g;
  if quay=false then a.fe:=0;
  a.q:=a.q+a.fe/step;
  a.x:=a.x+a.Vx/step;
  a.y:=a.y+a.Vy/step;
 end;



function RAA(a,b: cau): real;
 begin

  exit(sqrt(sqr(a.x-b.x)+sqr(a.y-b.y)));
 end;

function RAB(a: cau; b: dt): real;
 var ta,tb,R : real;
 begin
  if ((a.x-b.x[2])*(b.x[1]-b.x[2])+(a.y-b.y[2])*(b.y[1]-b.y[2])<=0)
  then exit(sqrt(sqr(a.x-b.x[2])+sqr(a.y-b.y[2])));

  if ((a.x-b.x[1])*(b.x[2]-b.x[1])+(a.y-b.y[1])*(b.y[2]-b.y[1])<=0)
  then exit(sqrt(sqr(a.x-b.x[1])+sqr(a.y-b.y[1])));

  ta:=b.x[1]-b.x[2];
  tb:=b.y[1]-b.y[2];
  R:=sqrt(sqr(ta)+sqr(tb));
  if R=0 then exit(sqrt(sqr(a.x-b.x[1])+sqr(a.y-b.y[1])));
  exit(abs(tb*a.x-ta*a.y-tb*b.x[1]+ta*b.y[1])/R);



 end;

procedure ttAA(var a,b : cau);
 var V,V1,V2,Vms,R,r1,q1,q2,q3 :real;
 begin

  R:=RAA(a,b);
  q1:=goc(b.x-a.x,b.y-a.y);

  if R<=a.R+b.R then
   begin

    r1:=(a.r+b.r-r);
    a.x:=a.x-r1*cos(q1)/2;
    a.y:=a.y-r1*sin(q1)/2;
    b.x:=b.x+r1*cos(q1)/2;
    b.y:=b.y+r1*sin(q1)/2;


    q2:=goc(a.Vx,a.Vy)-q1;
    q3:=goc(b.Vx,b.Vy)-q1;
    V1:=sqrt(sqr(a.Vx)+sqr(a.Vy));
    V2:=sqrt(sqr(b.Vx)+sqr(b.Vy));
    V:=V1*cos(q2)*a.m-V2*cos(q3)*b.m+r1*step;
    Vms:=(({V1*sin(q2)}-a.fe*a.R)-({V2*sin(q3)}-b.fe*b.R))*ms;
    a.Vx:=a.Vx-(V*cos(q1))/a.m;// - a.fe*a.R*sin(q1)/a.m;
    a.Vy:=a.Vy-(V*sin(q1))/a.m;// - a.fe*a.R*cos(q1)/a.m;
    a.fe:=(a.fe+Vms/a.m/(a.R));
    b.Vx:=b.Vx+(V*cos(q1))/b.m;// + b.fe*a.R*sin(q1)/b.m;
    b.Vy:=b.Vy+(V*sin(q1))/b.m;// + b.fe*a.R*cos(q1)/b.m;
    b.fe:=(b.fe-Vms/b.m/(b.R));

   end;

 end;

procedure ttAB(var a : cau; var b : dt);
 var v1,V,R,q1,q2,q3,Fms :real;
 begin

  R:=RAB(a,b);

  if (R<a.R) then
   begin
    q1:=goc(-(b.x[1]-b.x[2]),-(b.y[1]-b.y[2]));
    q2:=goc(a.Vx,a.Vy);
    V1:=sqrt(sqr(a.Vx)+sqr(a.Vy));
    V:=-V1*sin(q2-q1)*a.m-(a.r-r)*step;
    q3:=pi/2+q1;
    a.x:=a.x-(a.r-r)*cos(q3);
    a.y:=a.y-(a.r-r)*sin(q3);
    Fms:=(V1*cos(q2-q1)-a.fe*a.R)*ms*a.m;

    a.Vx:=a.Vx+(V)*cos(q3)/a.m-Fms*cos(q1)/a.m;
    a.Vy:=a.Vy+(V)*sin(q3)/a.m-Fms*sin(q1)/a.m;

    a.fe:=a.fe+Fms/a.R/a.m;
   end;


 end;

procedure ttXX(var a,b : cau; l : real);
 var R,q3,V1,V2,q1,q2,V : real;
 begin

  if RAA(a,b)<>l then
   begin
    R:=RAA(a,b)-l;
    q1:=goc(b.x-a.x,b.y-a.y);
    a.x:=a.x+r*cos(q1)*cung/2;
    a.y:=a.y+r*sin(q1)*cung/2;
    b.x:=b.x-r*cos(q1)*cung/2;
    b.y:=b.y-r*sin(q1)*cung/2;


    a.Vx:=a.Vx+r*cos(q1)*step/a.m;
    a.Vy:=a.Vy+r*sin(q1)*step/a.m;
    b.Vx:=b.Vx-r*cos(q1)*step/b.m;
    b.Vy:=b.Vy-r*sin(q1)*step/b.m;

   end;

 end;

Procedure ttAC(var a: cau; var b: canh);
 begin
  //ttAB(a,b.duong);
  ttAA(a,b.d[1]^);
  ttAA(a,b.d[2]^);

  ttXX(b.d[1]^,b.d[2]^,b.l);
  with b do
  //taodt(duong,trunc(d[1]^.x),trunc(d[1]^.y),trunc(d[2]^.x),trunc(d[2]^.y));
 end;


begin
 initgraph(gd,gm,'');
 khoitaovat(ball[1],10,15,1,0,+50,+50);
 for i:=2 to n do
  khoitaovat(ball[i],10,15,1,0,
             cos(i*(pi/(n-1)))*(n+1)*5/pi+50,
             sin(i*(pi/(n-1)))*(n+1)*5/pi+50);

 taodt(nen1,0,400,400,490);
 taodt(nen2,400,500,650,200);
 taodt(nen3,400,490,410,600);
 //taocanh(nen4,ball[1],ball[2],5);
 wingraph.setbkcolor($8F0000);
 randomize;
 UpdateGraph(0);
 repeat
 repeat
  if time>=frame then
   begin

    cleardevice;
    for i:=1 to n do vevat(ball[i],$00FFFF);
    vedt(nen1);
    vedt(nen2);
    vedt(nen3);
    //vecanh(nen4);

    UpdateGraph(2);


    time:=0;
   end;

  for i:=1 to n-1 do
   for j:=i+1 to n do
    if i<>j then
    begin
     ttAA(ball[i],ball[j]);
    end;
  {for i:=2 to n-1 do

   begin
    ttXX(ball[1],ball[i],n*5/pi);
    ttXX(ball[1],ball[i-1],n*5/pi);
    //ttXX(ball[i-1],ball[i],11);
    ttXX(ball[i],ball[i+1],11);
    //ttXX(ball[i-1],ball[i+1],22);
   end;
    ttXX(ball[n],ball[2],10);}

  for i:=1 to n do
   begin
    trongluc(ball[i]);

    ttAB(ball[i],nen1);
    ttAB(ball[i],nen2);
    ttAB(ball[i],nen3);
    //if (i-1)*(i-2)<>0 then ttAC(ball[i],nen4);
    //ttBC(nen1,nen4);ttBC(nen2,nen4);ttBC(nen3,nen4);
    if (ball[i].y>=650) or (ball[i].x>=1000) then
     khoitaovat(ball[i],ball[i].m,ball[i].R,0,-10,random(50)*10,0);
   end;
  {fillchar(free,sizeof(free),true);
  lai(1,1);}
  inc(time);

 until keypressed;
  ch:=readkey;
   case ch of
    #75 : ball[1].fe:=ball[1].fe-10*pi*frame;
    #77 : ball[1].fe:=ball[1].fe+10*pi*frame;
    #72 : ball[1].Vy:=ball[1].Vy-step;
    #80 : ball[1].fe:=0;
   end;
 until ch=#27;
 closegraph;

end.
