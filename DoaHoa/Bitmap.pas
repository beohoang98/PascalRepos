uses graph,wincrt ;

type info = packed record
             num : array[1..2] of char;
             size : longword;
             asd : longint;
             start : longint;
             dsa : longint;
             dai,rong : longword;
             plane,bit : word;
            end;
     RGB = packed record
            R,G,B : byte;
           end;

var gd,gm : smallint;
    f : file;
    header : info;
    mau : RGB;
    i,j,x,y : longint;
    pixel: array[0..2000,0..1000] of RGB;
    R,G,B : byte;


procedure plot(x,y,n : integer);
 var R,G,B : byte; i,j : integer;
 begin
  for i:=0 to n-1 do
   for j:=0 to n-1 do
    begin
     R:=trunc((pixel[x+1,y+1].R*i*j
              + pixel[x+1,y].R*(n-i)*j
              + pixel[x,y+1].R*i*(n-j)
              + pixel[x,y].R*(n-i)*(n-j))/n/n);
     G:=trunc((pixel[x+1,y+1].G*i*j
              + pixel[x+1,y].G*(n-i)*j
              + pixel[x,y+1].G*i*(n-j)
              + pixel[x,y].G*(n-i)*(n-j))/n/n);
     B:=trunc((pixel[x+1,y+1].B*i*j
              + pixel[x+1,y].B*(n-i)*j
              + pixel[x,y+1].B*i*(n-j)
              + pixel[x,y].B*(n-i)*(n-j))/n/n);
     setRGBpalette(1,B,G,R);
     putpixel(x*n+j-500,(header.rong-y)*n+i-500,1);
    end;
 end;


begin
 initgraph(gd,gm,'');
 x:=500; y:=500;
 assign(f,'10a1_3.bmp');reset(f,1);
  blockread(f,header,sizeof(header));
  seek(f,header.start);

  for i:=0 to header.rong-1 do
   for j:=0 to header.dai-1 do
    begin
     blockread(f,mau,sizeof(mau));
     pixel[j,i]:=mau;
    end;
 close(f);
 for i:=0 to header.rong-1 do
  for j:=0 to header.dai-1 do
   begin
    plot(j,i,2);
   end;

 readln;
 closegraph;
end.
