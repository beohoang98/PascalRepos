program TryRGBA;

uses wincrt, RGBA;

var x,y : integer;

begin
 KhoiTao(d4bit,m640x480);
 UpOff;
 AAOn;
 randomize;
 repeat
  ChonMau(random($80)*(2 shl 16+ 1),$8F);
  x:=random(640);
  y:=random(480);
  Line(0,0,x,y);
  FillTron(x,y,100);
  Screen;
  //Delay(100);
 until Keypressed;
end.
