uses crt, RGBA;

const
 pale : array[1..36] of
  longword=($FF0000,$FF2000,$FF4000,$FF8000,$FFC400,$FFE400,
            $FFFF00,$E4FF00,$C4FF00,$80FF00,$40FF00,$20FF00,
            $00FF00,$00FF20,$00FF40,$00FF80,$00FFC4,$00FFE4,
            $00FFFF,$00E4FF,$00C4FF,$0080FF,$0040FF,$0020FF,
            $0000FF,$2000FF,$4000FF,$8000FF,$C400FF,$E400FF,
            $FF00FF,$FF00E4,$FF00C4,$FF0080,$FF0040,$FF0020);

var asd,dsa,max : integer;

procedure frac(x,y,l,g : real;n : integer);
 var x1,y1 : real; m: integer;
 begin
  if l<=1 then exit;
  if n>max then max:=n;

  x1:=x+cos(g*pi/180)*l;
  y1:=y+sin(g*pi/180)*l;

  frac(x1,y1,l*3/4,g+10,n+2);
  frac(x1,y1,l*2/3,g+30,n+3);
  frac(x1,y1,l*2/3,g-45,n+2);

  m:=trunc(n*35/max)+1;

  ChonMau(pale[m],(36-m)*5);
  line(trunc(x),trunc(y),trunc(x1),trunc(y1));
 end;

begin
 asd:=1; dsa:=m800x600;
 KhoiTao(asd,dsa);
 UpOn;
 AAOn;
 randomize;
 max:=1;
 frac(300,600,150,-90,1);
 readln;
 Tat;
end.
