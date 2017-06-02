uses crt, graph, ve3d;

type dinh = record
      x,y : longint;

     end;



var asd,dsa,al,ap : integer;
    A : array[1..10] of dinh;
    P : pointer;
    n : longint;
    diem: array[1..1000] of dinh;
    c : char;

procedure tim(n : integer ; A : array of dinh; var x1,x2: longint);
 var i: integer;
 begin
  x1:=A[1].x;x2:=A[1].x;
  for i:=2 to n do
   begin
    if A[i].x>x2 then x2:=A[i].x;
    if A[i].x<x1 then x1:=A[i].x;
   end;
 end;



procedure sapxep(var n : integer;var M : array of dinh);
 var i,j,s : integer;
     t : dinh;
 begin
  s:=n;
  for i:=1 to s-1 do
   for j:=i+1 to s do
    if M[j].y<M[i].y then
     begin
      t:=M[i];
      M[i]:=M[j];M[j]:=t;
     end;
  for i:=1 to s-1 do
   if (i mod 2=1) and (M[i].y=M[i+1].y) then
    begin
     M[i+1].y:=M[i+2].y;
    end;

 end;

procedure tomau(n : integer ;A : array of dinh; t : integer);
 var xmin,xmax : longint;
     i,j,nM,ii : integer;
     M : array[1..1000] of dinh;
     k: real;
 begin
  setcolor(t);

  tim(n,A,xmin,xmax);

  for j:=xmin to xmax do
  begin
   nM:=0;
   for i:=1 to n do
    begin
    if i=n then ii:=1 else ii:=i+1;
    if (A[i].x<>A[ii].x) then
      begin
      k:=(j-A[i].x)/(A[ii].x-A[i].x);
      if (k>=0) and (k<=1) then
       begin
       nM:=nM+1;
       M[nM].x:=j;
       M[nM].y:=trunc(k*(A[ii].y-A[i].y)+A[i].y);
       end;
      end;
    end;
   if nM<2 then exit;
   sapxep(nM,M);

   setcolor(t);
   for i:=1 to nM do
    if i mod 2 =1 then moveto(j,M[i].y)
    else lineto(j,M[i].y);
  end;
 end;

procedure ktdinh(i : integer; x,y,z : real);
 begin
  chuyen3d(x,y,z);
  A[i].x:=trunc(tinh(x,y)+500);
  A[i].y:=trunc(300-tinh(z,y));
 end;




begin
 initgraph(asd,dsa,'');
 khoitao(500,0,300,0,0,0,500);
 repeat
  xoay(al,ap);
  ktdinh(1,100,0,0);
  ktdinh(2,100,0,100);
  ktdinh(3,0,0,100);
  ktdinh(4,0,0,0);
  A[5]:=A[1];

  tomau(4,A,49);

  c:=readkey;
   if c=#75 then al:=al+10;
   if c=#77 then al:=al-10;
   if c=#72 then ap:=ap+10;
   if c=#80 then ap:=ap-10;
  cls;
 until c=#27;

 closegraph;
end.
