uses crt, graph;

type td2d = record
       x,y : longint;
     end;

var gd,gm : integer;
    A : array[1..1000] of td2d;


procedure doicho(var A,B : real);
 var t : real;
 begin
  t:=A;
  A:=B;
  B:=t;
 end;




procedure ktdinh(var A : td2d; x,y : integer);
 begin
  A.x:=x;
  A.y:=y;
 end;

procedure todagiac(n: word;A: array of td2d);
 var min, max, x : integer;
     soM, i, j : word;
     M : array[1..100] of real;
     Dx, Dy, k  : real;
 begin
  max:=A[0].x;
  min:=A[0].x;
  for i:=0 to n-1 do
   begin
    if min>A[i].x then min:=A[i].x;
    if max<A[i].x then max:=A[i].x;
   end;
      { Tim gioi han hai ben cua da giac }

  { Tim giao diem cac canh roi noi voi nhau }
  For x:=min to max do
   begin
    soM:=0;
    {Tim giao diem}
    for i:=0 to n-1 do
     begin
      Dx:=A[(i+1) mod n].x-A[i].x;
      Dy:=A[(i+1) mod n].y-A[i].y;
      if Dx=0 then k:=0 else k:=Dy/Dx;
      if (x-A[i].x)*(x-A[(i+1) mod n].x)<=0 then
       {tao thanh giao diem nam trong canh}
       begin
        inc(soM);
        M[soM]:= (x-A[i].x)*k + A[i].y;

       end;
     end;
    {Bay gio phai sap xep theo thu tu}
    for i:=1 to soM-1 do
     for j:=i+1 to soM do
      if M[j]<M[i] then doicho(M[j],M[i]);
    {Bay gio moi noi cac giao diem lai}
    i:=2;j:=1;
    for i:=1 to SoM do
     if i mod 2=0 then
      begin
        putpixel(x,trunc(M[i-1]),31-trunc((M[i-1]-trunc(M[i-1]))*15));
        line(x,trunc(M[i-1]+1),x,trunc(M[i]-1));
        putpixel(x,trunc(M[i]),16+trunc((M[i]-trunc(M[i]))*15));
      end;

   end;

 end;


begin
 initgraph(gd,gm,'');
 ktdinh(A[1],300,10);
 ktdinh(A[2],200,200);
 ktdinh(A[3],500,300);
 ktdinh(A[4],600,100);
 repeat
  cleardevice;
  ktdinh(A[1],random(200)+100,random(50));
  todagiac(4,[A[1],A[2],A[3],A[4]]);
  delay(40);
 until keypressed;
 readln;
 closegraph;

end.
