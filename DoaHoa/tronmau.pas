uses graph,crt;

type maurgb=record
      R,G,B : byte;
     end;


var gd,gm : integer;
    n,i,j,x,y : longint;
    f : text;
    dai, rong,size: dword;
    s : char; s1 : string[4];

    s2,s3 :string;
    diem : array[0..1366,0..760] of maurgb;
    bit : byte;


function min(a,b : word): word;
 begin
  if a<b then exit(a) else exit(b);
 end;

function max(a,b: word): word;
 begin
  if a>b then exit(a) else exit(b);
 end;



function mau(x,y: integer; c,n : word): word;
 const q : array[0..3] of integer=(-1,1,-2,3);
 var k: integer;  t : word;
 begin
  if c mod 4=0 then exit(c div 4);
  if c mod 4=2 then
   if (abs(x)+abs(y)) mod 2=0 then exit(max(c div 4,0))
   else exit(min(c div 4+1,15));

  if c mod 4=3 then
   if (abs(x+2*y) mod 3=0) then exit(max(c div 4,0))
    else exit(min(c div 4+1,15));
  if c mod 4=1 then
   if (abs(x+y) mod 3<>0) {or (abs(y) mod 2<>0)} then exit(max(c div 4,0))
    else exit(min(c div 4+1,15));
 end;

procedure point(x,y : integer; R,G,B,A : byte);
 var i,j,k : byte;q: real;
 begin
  q:=A/255;
  i:=(trunc(R*q+diem[x,y].R*(1-q)));
  j:=(trunc(G*q+diem[x,y].G*(1-q)));
  k:=(trunc(B*q+diem[x,y].B*(1-q)));
  diem[x,y].R:=i;
  diem[x,y].G:=j;
  diem[x,y].B:=k;
  setRGBpalette(1,k,j,i);
  putpixel(x,y,1);
 end;

procedure doc(n : word);
 var i : word;
 begin
  for i:=1 to 256 do
   putpixel((i mod 20)*j div 10 +x,(i div 20)*j div 10+y,n);
 end;

procedure veanh(path: string; x,y : integer;A1 : byte);
 var i,j,n,start,k : dword;

     x1,y1 : integer;
     R,G,B,A : byte;
 begin
  assign(f,path);reset(f);
  for i:=1 to 2 do read(f,s);
  read(f,s1);
  size:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  for i:=7 to 10 do read(f,s);
  read(f,s1);
  start:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  if size<start then begin size:=0;start:=54;end ;
  //else size:=size-start;

  read(f,s1);

  read(f,s1);
  dai:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  read(f,s1);
  rong:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  //if (rong<>0) and (size>rong) then dai:=size div (rong*3);
  for i:=27 to 28 do read(f,s);
  read(f,s);bit:=ord(s);
  read(f,s);//bit:=bit+ord(s)*256;
  for i:=31 to start do read(f,s);

  for i:=1 to rong do
   for j:=1 to dai do

    begin
     if bit>=24 then
      begin
       read(f,s);R:=ord(s);
       read(f,s);G:=ord(s);
       read(f,s);B:=ord(s);
       if bit=32 then
        begin
         read(f,s);A:=ord(s);
        end else A:=A1;

      end
     else
      begin
       read(f,s);n:=ord(s);
       R:=n;
       g:=R;
       B:=g;
       //setpalette(1,n);
      end;
     x1:=x+trunc(j*1);
     y1:=rong-trunc(i*1)+y;


     //diem[x1,y1]:=n;
     point(x1,y1,R,G,B,A);
    end;
  close(f);
 end;



begin
 initgraph(gd,gm,'');
 //docmau;
 veanh('map2.bmp',0,0,255);
 veanh('asd2.bmp',0,0,255);
 str(dai,s2);
 str(rong,s3);
 outtextxy(10,20,s2+'x'+s3);
 str(size,s2);outtextxy(10,30,'size: '+s2+' bytes');
{ repeat
  setcolor(15);
  str(diem[x,y],s2);
  outtextxy(100,700,s2);
  i:=getpixel(x,y);
  putpixel(x,y,40);
  doc(15);
  s:=readkey;
  putpixel(x,y,i);
  setcolor(0);
  doc(0);
  outtextxy(100,700,'лллл');
  case s of
   #75 : if x>1 then dec(x);
   #77 : if x<1361 then inc(x);
   #72 : if y>1 then dec(y);
   #80 : if y<755 then inc(y);
   's' : inc(j);
   'w' : dec(j);
   'a' : docd;
  end;
 until s=#27; }
 readln;
 closegraph;
end.
