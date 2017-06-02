program Burning_Fire_Effect;

uses wincrt in 'src/wincrt.pas', wingraph in 'src/wingraph.pas', docbmp,
     winmouse in 'src/winmouse.pas';

type diem= record
      x,y,c : integer;
     end;

var gd,gm : smallint;
    n , i , j: longint;
    p,pp : array[0..1000,0..800] of word;
    f : file; p1: pointer;



procedure Taochay;
 var i,j,z : integer; m : longword;
 begin

  for i:=0 to 1000 do
   for j:=0 to 800 do p[i,j]:=getpixel(i,j);
   pp:=p;
  for z:=1 to 15 do
  begin
  for i:=1 to 1000-1 do
   for j:=1 to 800-1 do
    begin
     m:=(p[i-1,j]+p[i,j-1]+p[i,j+1]
         +p[i+1,j]) div 4;
     pp[i,j]:=m;
    end;
   p:=pp;
   end;
 end;

Procedure chay(x,y : integer);
 var i,j : longint;
 begin
  for i:=x to x+400 do
   for j:=y to y+400 do
    putpixel(i,j,p[i,j]);
 end;

begin

 gd:=d8bit; gm:=m800x600;
 InitGraph(gd,gm,'');

 UpdateGraph(0);
 for i:=0 to 255 do setRGBpalette(i,i,i,i);


 assign(f,'10a1_3.bmp');reset(f,1);
 i:=filesize(f);
 getmem(p1,i);
 blockread(f,p1^,i);
 close(f);
 putimage(-10,0,p1^,0);
 taochay;
 setcolor(255);outtextxy(100,100,'asdasd 12123');


 repeat
  //setcolor(255);

  putimage(-10,0,p1^,0);
  chay(GetMouseX,GetMouseY);
  updategraph(2);
  delay(10);

 until keypressed;
 CloseGraph;
end.
