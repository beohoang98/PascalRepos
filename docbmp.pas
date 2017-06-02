unit docbmp;

interface
type image = record
      n : dword;
      x,y,c : array[1..2000000] of integer;
     end;


 procedure docmau;
 procedure kichthuoc(path:string;var n,dai,rong : longint);
 function diemanh(path: string): image;
 procedure veanh(path: string; x,y : integer);
implementation

uses crt,graph;



var
    f : text;
    i,j : integer;
    s : char; s1 : string[4];
    co : array[0..256] of integer;

procedure docmau;
 var i,n: integer;f: text;
 begin
  assign(f,'mau256.txt');reset(f);

  for i:=1 to 256 do
  begin
   readln(f,n);

   co[n]:=i;
  end;
  co[0]:=0;
  for i:=1 to 256 do
   if co[i]=0 then co[i]:=co[i-1];
  close(f);
 end;

procedure kichthuoc(path: string;var n,dai,rong : longint);
 var size : longint; f :text;
 begin
  assign(f,path);reset(f);
  for i:=1 to 2 do read(f,s);
  read(f,s1);
  size:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  for i:=7 to 10 do read(f,s);
  read(f,s1);
  n:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  size:=size-n;

  for i:=15 to 18 do read(f,s);
  read(f,s1);
  dai:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  read(f,s1);
  rong:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  if rong <>0 then dai:=size div rong;
  close(f);
 end;

function diemanh(path: string):image;
 var start, dai, rong,size, k : longint;
     f :text;
 begin
  docmau;
  assign(f,path);reset(f);
  for i:=1 to 2 do read(f,s);
  read(f,s1);
  size:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  for i:=7 to 10 do read(f,s);
  read(f,s1);
  start:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  size:=size-start;
  reset(f);
  for i:=1 to 18 do read(f,s);
  read(f,s1);
  dai:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  read(f,s1);
  rong:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  if rong<>0 then dai:=size div rong;
  for i:=27 to start do read(f,s);
  diemanh.n:=0;
  for i:=1 to rong do
   for j:=1 to dai do
    begin
     read(f,s);

     k:=ord(s);
     if k<>0 then
      begin
       inc(diemanh.n);
       diemanh.x[diemanh.n]:=-j+dai;
       diemanh.y[diemanh.n]:=-i+rong;
       diemanh.c[diemanh.n]:=co[k];
      end;
    end;
  close(f);
 end;

procedure veanh(path : string;x,y : integer);
 var start, dai, rong, size, n : longint;
     f : text;
 begin
  assign(f,path);reset(f);
  for i:=1 to 2 do read(f,s);
  read(f,s1);
  size:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  for i:=7 to 10 do read(f,s);
  read(f,s1);
  start:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  size:=size-start;
  reset(f);
  for i:=1 to 18 do read(f,s);
  read(f,s1);
  dai:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  read(f,s1);
  rong:=ord(s1[1])+ord(s1[2])*256+ord(s1[3])*256*256+ord(s1[4])*256*256*256;
  if rong<>0 then dai:=size div rong;
  for i:=27 to start do read(f,s);
  for i:=1 to rong do
   for j:=1 to dai do
    begin
     read(f,s);
     n:=ord(s);
     putpixel(j+x,-i+rong+y,co[n]);
    end;
  close(f);
 end;

begin

end.
