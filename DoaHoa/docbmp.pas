unit docbmp;

interface
 var co : array[0..256] of integer;
 type diempic = record
       dai,rong : word;
       r,g,b : array[0..1000000] of byte;
      end;
      ppic = ^diempic;

 procedure docmau;
 procedure kichthuoc(path:string;var n,dai,rong : longint);
 function diemanh(path: string; sizex,sizey: integer): diempic;
 //function GetAnh(path : string; sizex, sizey : integer) : pointer;
 procedure veanh(path: string; x,y : integer);
 procedure vepic(pic : diempic; x,y : integer);
 //procedure VeImg(var pic : ppic; x,y : integer);
implementation

uses crt,wingraph in 'C:/FPC/2.6.2/bin/i386-win32/src/wingraph.pas',math;


var f : text;
    i,j : integer;
    s : char; s1 : string[4];



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
  for i:=1 to 255 do
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
  //if rong <>0 then dai:=size div rong;
  close(f);
 end;

function diemanh(path: string; sizex,sizey : integer): diempic;
 var start, dai, rong,size : longint;
     f,f1 :text;
     r,g,b : word;
     k,ii : word;
 begin

  assign(f,path);reset(f);

  //assign(f1,path+'file.txt');rewrite(f1);
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

  for i:=27 to start do read(f,s);
  //writeln(f1,dai*rong);
  if sizex=0 then sizex:=dai;
  if sizey=0 then sizey:=rong;
  diemanh.dai:=sizex;
  diemanh.rong:=sizey;

  for i:=1 to rong do
   for j:=1 to dai do
    begin
     read(f,s);b:=ord(s);
     read(f,s);g:=ord(s);
     read(f,s);r:=ord(s);
     ii:=(max(i*sizey div rong-1,0))*sizex+j*sizex div dai;

     //writeln(f1,i,' ',j,' ',k);

     diemanh.r[ii]:=r;
     diemanh.g[ii]:=g;
     diemanh.b[ii]:=b;
    end;
  //close(f1);
  close(f);
 end;

procedure veanh(path : string;x,y : integer);
 var start, dai, rong, size, n : longint;
     f : text;
     k : word;
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
  if rong=0 then exit;

  for i:=27 to start do read(f,s);


  for i:=1 to rong do
   for j:=1 to dai do
    begin
     read(f,s);
     n:=ord(s);
     //setpalette(1,n*2 mod 16+16);
     putpixel(j+x,-(i)+rong+y,n);
    end;
  close(f);
 end;

procedure vepic(pic : diempic; x,y : integer);
 var i,j : integer;m : dword;
 begin

  with pic do
  for j:=1 to rong do
   for i:=1 to dai do
    begin
     m:=(j-1)*dai+i;
     //setRGBpalette(1,b[m],g[m],r[m]);
     putpixel(i+x,-(j)+y+rong,b[m]*65536+g[m]*256+r[m]);
    end;
 end;

begin

end.
