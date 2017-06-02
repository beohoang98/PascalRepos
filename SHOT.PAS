uses crt, graph ;

var      a,b,k,q ,e,i:integer; c:char; s,r:string;
         x,y,x1,y1,x2,y2: longint;
         lucban:real; u,u1 : integer;

procedure ball;
  var i : integer;
  begin
   setcolor(0);for i:=1 to 5 do circle(x,y,i);
   x:=x+k;q:=q+1;y:=y+q;
   if y>=405 then
   if (x<>x1) then
    begin
    for i:=1 to 20 do begin
     if i<10 then setcolor(yellow) else setcolor(red);
     circle(x,y,i);delay(5);
     end;
    for i:=1 to 20 do begin
     setcolor(0);circle(x,y,i);delay(5);
     end;
    begin q:=0;x:=x1;y:=401;k:=0; end;
    end else begin q:=0;x:=x1;y:=401;k:=0; end;

   setcolor(7);for i:=1 to 5 do circle(x,y,i);
  end;


procedure ban;
  begin
   if u<=100 then u1:=5;
   if u>=400 then u1:=-5;

   line(100,450,400,450);
     setcolor(0);
     circle(u,450,3);

     u:=u+u1;
     setcolor(yellow);
     circle(u,450,3);

   lucban:=u/200;
   str(u,s);setcolor(0);
   outtextxy(150,100,'лллллллллл');
   setcolor(7);
   outtextxy(150,100,s+'  '+r);
  end;

procedure sung(x1,y1 :integer);
  begin
   setcolor(0);line(x1,y1,x2,y2+y1);
   x2:=x1+e;

   if (e>20) or (e<-20) then y2:=400 else
   y2:=-round(sqrt(400-e*e));
   setcolor(7); line(x1,y1,x2,y2+y1);
   if e<>0 then str(trunc(arctan(-y2/e)*180/3.1415926),r)
   else r:='90';
   if (c='5') and (y=401) then
   begin c:='z';k:=trunc(e*lucban);q:=trunc(y2*lucban); end;
  end;


begin
  a:=0;b:=0;initgraph(a,b,'D:\TP\BGI');
  x:=100;y:=300;e:=19;x1:=100;u:=100;
  for i:=405 to 500 do line(1,i,600,i);
  repeat
   repeat

   ball;sung(x1,400);ban;

   delay(40);

   until keypressed;
   c:=readkey;
   if (c=#72) and (e>=0) then e:=e-1;
   if (c=#80) and (e>=0) then e:=e+1;
   if (c=#72) and (e<0) then e:=e+1;
   if (c=#80) and (e<0) then e:=e-1;
   if c=#77 then x1:=x1+1;
   if c=#75 then x1:=x1-1;
  until c='0';
  closegraph;
end.
