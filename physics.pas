uses wincrt, graph;

type cau=record
      m,R,Vx,Vy,x,y : real;
      q,fe : real;
     end;
     hcn=record
      x,y : array[1..4] of real;
      d,r : real;
     end;
     dt=record
      x,y : array[1..2] of integer;
     end;

const n =10;  g =10;ms=0.01; step=5000; bou=7; frame=15;

var gd,gm,i,j : integer;
    ball : array[1..1000] of cau;
    free : array[1..1000] of boolean;
    nen1,nen2,nen3 : dt;
    time : longint;

function goc(x,y : real):real;
 begin
  if x=0 then
   if y>0 then exit(pi/2)
   else exit(-pi/2);
  if x>0 then exit(arctan(y/x))
  else exit(arctan(y/x)+pi);
 end;

procedure vevat(var a: cau; i: byte);
 begin
  setcolor(i);
  {putpixel(trunc(a.x),trunc(a.y),i);  }
  circle(trunc(a.x),trunc(a.y),trunc(a.R));
  line(trunc(a.x),trunc(a.y),trunc(a.x+a.R*cos(a.q)),trunc(a.y+a.R*sin(a.q)));
 end;

procedure trongluc(var a : cau);
 begin
  a.Vy:=a.Vy+g;
  a.q:=a.q+a.fe;
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
    V:=-V1*a.m*cos(q2)+V2*b.m*cos(q3)-bou*r1;
    Vms:=V1*a.m*sin(q2)-V2*b.m*sin(q3);
    a.Vx:=a.Vx+(V)*cos(q1)/a.m + a.fe*a.R*sin(q1)/a.m;
    a.Vy:=a.Vy+(V)*sin(q1)/a.m + a.fe*a.R*cos(q1)/a.m;
    a.fe:=(a.fe-Vms/a.m/(a.R)-b.fe)/step;
    b.Vx:=b.Vx-(V)*cos(q1)/b.m - b.fe*a.R*sin(q1)/b.m;
    b.Vy:=b.Vy-(V)*sin(q1)/b.m - b.fe*a.R*cos(q1)/b.m;
    b.fe:=(b.fe+Vms/b.m/(b.R)-a.fe)/step;
   end;

 end;

procedure ttAB(var a : cau; var b : dt);
 var v1,V,R,q1,q2,q3 :real;
 begin

  R:=RAB(a,b);

  if (R<=a.R) then
   begin
    q1:=goc(-(b.x[1]-b.x[2]),-(b.y[1]-b.y[2]));
    q2:=goc(a.Vx,a.Vy);
    V1:=sqrt(sqr(a.Vx)+sqr(a.Vy));
    V:=-V1*sin(q2-q1)*bou-(a.r-r);
    q3:=pi/2+q1;
    a.x:=a.x-(a.r-r)*cos(q3)/2;
    a.y:=a.y-(a.r-r)*sin(q3)/2;
    a.Vx:=a.Vx+(V*cos(q3)-V1*ms*cos(q2-q1)*cos(q1))/a.m- a.fe*a.R*sin(q3)*bou;
    a.Vy:=a.Vy+(V*sin(q3)-V1*ms*cos(q2-q1)*sin(q1))/a.m- a.fe*a.R*cos(q3)*bou;
    V:=sqrt(sqr(a.Vx)+sqr(a.Vy));
    a.fe:=V*cos(q2-q1)/a.R/step;
   end;


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

procedure lai(i,k: integer);
 var j,maxi : integer;
     max : real;
 begin
  if k>=n then exit;
  if k=1 then moveto(trunc(ball[i].x),trunc(ball[i].y));
  max:=10000;maxi:=i+1;
  for j:=1 to n do
   if (i<>j) and free[j] then
    if RAA(ball[i],ball[j])<max then
     begin
      max:=RAA(ball[i],ball[j]);
      maxi:=j;
     end;
  free[i]:=false;
  j:=maxi;
  lineto(trunc(ball[j].x),trunc(ball[j].y));
  lai(j,k+1);
 end;

begin
 initgraph(gd,gm,'');
 for i:=1 to n do
   khoitaovat(ball[i],5,10,12,0,(i mod trunc(sqrt(n)))*27+50,(i div trunc(sqrt(n)))*27-150);
 taodt(nen1,0,200,400,480);
 taodt(nen2,410,500,650,200);
 taodt(nen3,400,480,410,600);
 setbkcolor(1);
 randomize;
 ball[n-1].fe:=20; ball[n-1].x:=350;
 repeat
  if time>=frame then
   begin
    delay(40);
    cleardevice;
    for i:=1 to n do vevat(ball[i],14);
    vedt(nen1);
    vedt(nen2);
    vedt(nen3);

    time:=0;
   end;

  for i:=1 to n-1 do
   for j:=i+1 to n do
    if i<>j then
    begin
     ttAA(ball[i],ball[j]);
    end;

  for i:=1 to n do
   begin
    trongluc(ball[i]);
    ttAB(ball[i],nen1);
    ttAB(ball[i],nen2);
    ttAB(ball[i],nen3);
    if (ball[i].y>=650) or (ball[i].x>=1000) then
     khoitaovat(ball[i],ball[i].m,ball[i].R,0,-10,random(50)*10,0);
   end;
  {fillchar(free,sizeof(free),true);
  lai(1,1);}
  inc(time);

 until keypressed;
 closegraph;

end.
