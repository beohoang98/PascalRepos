program Visual;

uses wingraph in 'src/wingraph.pas',
     wincrt in 'src/wincrt.pas';

var gd,gm : smallint;
    pixel, pixel2 : array[0..320,0..200] of record
       R,G,B : byte;
     end;

procedure tron(x,y,R : word);
 var i,j: integer;     mau : longword;
 begin
  mau:=getcolor;
  for i:=-R to R do
   begin
    j:=trunc(sqrt(R*R-i*i));
    pixel[i+x,y+j].R:=mau mod 256;
    pixel[i+x,y+j].G:=mau div 256 mod 256;
    pixel[i+x,y+j].B:=mau div 65536 mod 256;

    pixel[i+x,y-j].R:=mau mod 256;
    pixel[i+x,y-j].G:=mau div 256 mod 256;
    pixel[i+x,y-j].B:=mau div 65536 mod 256;
   end;
 end;

procedure inra;
 var i,j,mr,mg,mb : word;
 begin

  for i:=1 to 200 do
   for j:=1 to 320 do
    begin
     mr:=(pixel[i-1,j].R+pixel[i,j-1].R+pixel[i-1,j-1].R) div 3;
     mg:=(pixel[i-1,j].G+pixel[i,j-1].G+pixel[i-1,j-1].G) div 3;
     mb:=(pixel[i-1,j].B+pixel[i,j-1].B+pixel[i-1,j-1].B) div 3;
     pixel2[i,j].R:=mr;
     pixel2[i,j].g:=mg;
     pixel2[i,j].b:=mb;
     with pixel[i,j] do
      putpixel(i,j,mR+mG*256+mB*65536);
    end;
  pixel:=pixel2;
  UpdateGraph(2);

 end;



 begin
 gd:=nopalette; gm:=m320x200; UpdateGraph(0);
 initgraph(gd,gm,' ');
 repeat
  tron(100,100,50);
  inra;
  delay(20);
 until keypressed;
 closegraph;
end.
