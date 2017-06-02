uses crt, graph;

type HsbRec = record
      H,S,B : smallint;
     end;
     RgbRec = record
      R,G,B : smallint;
     end;

var asd,dsa : integer;
    f : text;
    ngang,doc : longint;
    i,j,n,x,y : longint;
    s1 : char; s2 : string[4];
    s3 : char;
    mx,my : array[0..260] of integer;
    co : array[-1..255] of integer;
    diem : array[0..1500,0..768] of integer;

procedure diem1(x,y,n : longint);
 begin
  x:=x;
  y:=y;
  putpixel(x,y,n);
  putpixel(x+1,y,n);
  putpixel(x+1,y+1,n);
  putpixel(x,y+1,n);
 end;




procedure docd;
 var i,n : integer;
 begin
  for i:=1 to 256 do
   begin
    n:=getpixel(mx[i],my[i]);
    writeln(f,n);
   end;
 end;

procedure timmau;
 var c : char;
     x,y,n : integer;
     s1,s2 : string;
 begin

  {assign(f,'mau256.txt');rewrite(f);}
  x:=10; y:=10;
  for i:=0 to 256 do
   begin
    mx[i]:=(i mod 20)*50+35;
    my[i]:=(i div 20)*45+105;
    {putpixel(mx[i],my[i],15);}
   end;
  i:=0;
  repeat

   n:=getpixel(x,y);
   str(diem[x,y],s1);
   str(i,s2);
   setcolor(15);outtextxy(5,10,s1+' '+s2);
   putpixel(x,y,15);
   c:=readkey;
   putpixel(x,y,n);
   setcolor(0);outtextxy(5,10,s1+' '+s2);
   case c of
    #75 : x:=x-5;
    #77 : x:=x+5;
    #72 : y:=y-5;
    #80 : y:=y+5;
    {'a' : docd;}
   end;
  until c=#27;
  writeln(-1);
  {close(f);}
 end;

procedure docanh;
 begin
  for j:=1 to ngang*doc do
     begin
      read(f,s1);

      n:=ord(s1) ;

      x:=(j+350) mod 1368;
      y:=768-(j div 2) div doc;
      if (x>0) and (x<1500) and (y>0) and (y<768) then diem[x,y]:=n;
      putpixel(x,y,n);
     end;

 end;

procedure docmau;
 var a,i : integer;
 begin
  assign(f,'mau256.txt');reset(f);
  i:=1;
  repeat
   readln(f,a);
   co[a]:=i;
   i:=i+1;
  until a=-1;
  co[0]:=0;
  close(f);
 end;

begin
 clrscr;
 initgraph(asd,dsa,'');
 docmau;
 assign(f,'mau.bmp');reset(f);
 {co[0]:=0;
 co[1]:=4; co[2]:=2;
 co[3]:=6; co[4]:=1;
 co[5]:=5; co[6]:=3;
 co[7]:=8; co[8]:=7;
 co[9]:=12; co[10]:=10;
 co[11]:=11; co[12]:=9;
 co[13]:=13; co[14]:=14;
 co[15]:=15; co[16]:=16;}
 for i:=1 to 17 do read(f,s1);
 read(f,s2);
 ngang:=ord(s2[1])+ord(s2[2])*16+ord(s2[3])*256+ord(s2[4])*65536;
 read(f,s2);
 doc:=ord(s2[1])+ord(s2[2])*16+ord(s2[3])*256+ord(s2[4])*65536;
 for i:=26 to 53 do read(f,s1);

  docanh;
 close(f);
 timmau;
 closegraph;
end.
