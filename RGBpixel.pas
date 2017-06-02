Program PixelRGB;

uses wincrt, graph;

var gd,gm : integer;
    i,j : integer; f :file;
    Image : packed  record
     Magic : integer;
     Size : longword;
     asd : longword;
     Offset : longword;
     sizeheader : longword;
     dai, rong : longword;
     plane,bit : word;
    end;
    RGB : packed record
     R,G,B : byte;
    end;


procedure pixel(x,y : integer; R,G,B : byte);
 var W : word;
 begin
  W:=(r+g+b) div 12;
  R:=R div 4; G:=G div 4; B:=B div 4;
  if G>0 then G:=G+63;
  if B>0 then B:=B+126;
  if W>0 then W:=W+189;
  x:=x*2;y:=y*2;

   begin
   putpixel(x,y,R);
   putpixel(x+1,y,G);
   putpixel(x,y+1,B);
   putpixel(x+1,y+1,W);

   end;

 end;

procedure tron(x,y: integer;bk,R,G,B : word);
 var i,j : integer;
 begin
  for i:=0 to +bk do
   begin
    j:=trunc(sqrt(bk*bk-i*i));
    pixel(i+x,y+j,R,G,B);pixel(x-i,y+j,R,G,B);
    pixel(i+x,y-j,R,G,B);pixel(x-i,y-j,R,G,B);
   end;
 end;

begin
 initgraph(gd,gm,'');
 for i:=1 to 63 do
  begin
   setRGBpalette(i,i*4+3,0,0);
   setRGBpalette(i+63,0,i*4+3,0);
   setRGBpalette(i+126,0,0,i*4+3);
   setRGBpalette(i+189,i*4+3,i*4+3,i*4+3);
  end;  setRGBpalette(255,255,255,255);
 assign(f,'10a1_3.bmp');reset(f,1);
 blockread(f,image,sizeof(image));
 seek(f,image.offset);
 for i:=1 to image.rong do
  for j:=1 to image.dai do
   begin
    blockread(f,RGB,sizeof(RGB));
    //if (i+j) mod 2=0 then
    with RGB do pixel(j,(image.rong-i),B,G,R);
   end;
 close(f);
 repeat until keypressed;
 closegraph;
end.
