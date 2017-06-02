uses windows
   , wincrt in 'src/wincrt.pas'
   , wingraph in 'src/wingraph.pas'
   , RGBA in 'src/rgba.pas'
   //, Snake360_Menu
   , MMSystem;

Const {Ran Mode} dodaimax = 1000;
                 speed = 8;
                 R=5;
                 pi=3.1415;

      {Game Mode} RFood = 3; SoFood = 20; FoodMau = 40;
                  treBd = 200;
                  FrameChuan = 25;
                  AAMode = True;
                  TranMode = True;
                  FontMode = True;
                  SoundMode = True;

      {Sound} Am : array[1..4] of Pchar=('Sound/C.wav','Sound/Am.wav',
                                        'Sound/F.wav','Sound/G.wav');
              Bien = 'SOund/Bien.wav';
              Music = 'Sound/Song.wav';

      {Khung Mode} MinXView = 10; MaxXView = 600;
                   MinYView = 20; MaxYView = 590;

      {Life} LIFEMax = 5;
             LIFEString : Array[1..5] of STring=('O',
                                                'O O',
                                                'O O O',
                                                'O O O O',
                                                'O O O O O');


Var Ran: array[1..dodaimax] of record
                             x,y : real;
                            end;
    Food : array[1..sofood] of record
                                x, y : longint;
                                b : word;
                               end;
    Key : Char; // Key
    {Ran} g : integer;// Goc
          dodai: word; // do dai ran
          Point, bonus : longword; // Diem
          LIFE : Word;
    {Sound} soam: word; // So tep am
    {Frame} dem : word;                //  FRAME
            Frame: real; t: longword;  //  FRAME
            Tre, doi : word;
    {TieuDeBen} Status : record
                          Diem, bonus : string;
                          Frame : string;
                          Mark : string;
                         end;
    {Font} FontNum, FontNum2 :Word;
    {TranVar}  TranAlpha : byte;

// --------------------VE---------------------//

Procedure VeRan;
 var i: word;
 begin
  CHonMau($FFFF00,TranAlpha);
  //SetColor(14);SetFillStyle(1,4);
  For i:=1 to dodai do
   with Ran[i] do FillTron(trunc(x),trunc(y),R);
 end;
Procedure VeFood;
 var i :word;
 Begin
  //ChonMau($FF00FF,$FF);
  for i:=1 to sofood do begin
   if TranMode then
    ChonMau($00FFFF,$FF*abs(food[i].b-FoodMau) div (FoodMau*2))
   else ChonMau($00FFFF,$FF);
   FillTron(food[i].x,food[i].y,RFood);
  end;
 End;
Procedure VeKhung;
 Begin
  ChonMau($FF0000,$FF);
  Line(MinXView,MinYView,MinXView,MaxYVIew);
  Line(MaxXView,MinYView,MaxXView,MaxYVIew);
  Line(MinXView,MinYView,MaxXView,MinYVIew);
  Line(MinXView,MaxYView,MaxXView,MaxYVIew);
 ENd;
Procedure CapNhatStatus;
 begin
  SetTextStyle(1,0,15);
   SetColor($FFFFFF);
    OutTextXy(MaxXView+1,1,Status.Frame+' fr/s');
  SetTextStyle(FontNum2,0,26);
   SetColor($FFFFFF);
    Outtextxy(MaxXVIew+1,10,'DIEM  : '+Status.Diem);
    OuttextXY(MaxXView+1,30,'BONUS : x'+Status.bonus);
   SetColor($0000FF);
    OutTextXY(MaxXView+1,50,LIFEString[LIFE]);
  SetTextStyle(FontNum2,0,35);
   SetCOlor($00FFFF);
    OuttextXY(MaxXVIew+1,70,Status.Mark);
 end;
Procedure VeHuong;
 Var xh,yh : word;
 Begin
  SetTextStyle(3,0,18);
  CHonMau($FFFFFF,$FF);
  xh:=GetMaxX-100;
  yh:=GetMaxY-100;
  OuttextXy(MaxXView+5,yh-100,'Trai<<      Huong       >>Phai');
  Tron(xh,yh,50);
  Line(xh,yh,trunc(xh+50*cos(g*pi/180)),trunc(yh+50*sin(g*pi/180)));
 End;
Procedure CapNhat ;
 Begin
  VeRan;
  VeFood;
  VeKhung;
  CapNhatStatus;
  VeHUong;
 End;
//==========================THUA============================//

PRocedure VietChu(S : STring; size,y : word);
 Var W : word;
 Begin
  SetTextStyle(4,0,size);
  W:=TextWidth(S);
  OutTextXY(GetMaxX div 2-W div 2,y,S);
 end;

Procedure Thua;
 Var S: String; W: Word;c : char;
 Begin
   SndPlaySound('Sound/Song.wav',Snd_Async);
   Xoa;
   VietChu('BAN THUA ROI',60,100);
   VietChu('So diem ket thuc la: '+Status.Diem,40,150);
   VietChu('Bam ESC de thoat',10,10);
   Screen;
   Repeat
    if keypressed then c:=readkey;
   Until c=#27;
   Halt;
 ENd;

//==========================TINH============================//
Procedure TinhRan;
 var i : word; dungbien : boolean;
 begin
  dungbien:=false;
  for i:=dodai downto 2 do
   with Ran[i] do
    begin
     x:=Ran[i-1].x;
     y:=Ran[i-1].y;
    end;
  Ran[1].x:=Ran[1].x+Speed*cos(g*pi/180);
  Ran[1].y:=Ran[1].y+Speed*sin(g*pi/180);
  with Ran[1] do
   begin
    if (x<MinXView) or (x>MaxXView) then dungbien:=true;
    if (y<MinYView) or (y>MaxYView) then dungbien:=true;
    if dungbien then
     begin
      Bonus:=1;
      If SoundMode then SNDPlaySound(Bien,snd_Async);
      x:=abs(MaxXView-x)+MinXView;
      y:=abs(MaxYView-y)+MinYVIew;
      Status.Mark:='MAT BONUS :(';
      DEC(LIFE);
      IF (LIFE<=0) Then Thua;
     end;
   end;
 end;
Procedure NgauNhienFood(j : word);
 Begin
  with food[j] do begin
   x:=Random(MaxXView-MinXView-R)+MinXView;
   y:=Random(MaxYView-MinYView-R)+MinYView;
   b:=random(FoodMau)+1;
  end;
 ENd;
Procedure TinhFood;
 var i : word;
 begin
  for i:=1 to sofood do with food[i] do begin
   if (x-R<Ran[1].x+RFood) and (x+R>Ran[1].x-RFood)
   and(y-R<Ran[1].y+RFood) and (y+R>Ran[1].y-RFood) then
    begin
     NgauNhienFood(i);
     Point:=Point+Bonus;
     Inc(Bonus);
     inc(dodai);
     if SoundMode then SndPlaySound(Am[soam],snd_Async);
     inc(soam); if soam>4 then soam:=1;
    end;
   inc(b); if b>=FoodMau*2 then b:=0;
  end;
 end;
Procedure TinhStatus;
 Begin
  str(Point,Status.DIem);
  str(Bonus,Status.bonus);
  if bonus>=20 then Status.Mark:='<< INCREDIBLE >>';
  if bonus<20 then Status.Mark:='< EXCELLENT >';
  if bonus<10 then Status.Mark:=' Good ';
  if bonus<5 then Status.Mark:=' ';
  str(trunc(Frame),Status.Frame);

 ENd;
Procedure Tinh;
 Begin
  TinhFood;
  TinhStatus;
  if dem >=tre then begin TinhRan; dem:=0; end;
  inc(dem);

 End;

//>>>>>>>>>>>>>>>>>>>>>>>>>>>KHOI TAO<<<<<<<<<<<<<<<<<<<<<<<<//
Procedure KhoiTaoGame;
 var i : word;
 Begin
  {1.Khoi Tao Ran} dodai:=5; g:=0;
                   For i:=1 to dodai do begin
                    Ran[i].x:=MinXView+R;
                    Ran[i].y:=GetMaxY/2;
                   end;
  {2.Ngau Nhien Thuc An} for i:=1 to sofood do NgauNhienFood(i);
  {3.Khoi Tao DIem} Point:=0; Bonus:=1;
                    soam:=1;
  {4.Life} LIFE:=LIFEMax;
 End;
Procedure KhoiTaoCHung;
 begin
  {1.Random} Randomize;
  {2.Khoi Tao Do Hoa} KhoiTao(d8bit, m800x600);
                      If AAMode then AAOn else AAOff;
                      If TranMode then TranAlpha:=$8F else TranAlpha:=$FF;
                      UPOff;
  {3.FONT}If FontMode then begin
           FontNum:=InstallUserFont('VNI-Lithos');
           FontNum2:=InstallUserFont('VNI-Dom');
          end else begin
           FontNum:=1;FontNum2:=1;
          end;
  {4.Frame} Frame:=1; tre:=treBd; t:=gettickcount;doi:=5;
 end;

// ............................GAME.................................//
Procedure GAME;
 begin
  KhoitaoGame;
  Xoa;
    Repeat
      repeat
         XOa;
         CapNhat; Screen;
         Tinh; Delay(doi);
         {Tinh Frame}
                t:=gettickcount-t;
                if t=0 then t:=1;
                Frame:=(1000/(t*tre));
                if Frame>FrameChuan then inc(tre) else dec(tre);
                t:=gettickcount;
      until keypressed;
      if keypressed then key:=readkey;
      case key of
        #75 : g:=g-10;
        #77 : g:=g+10;
        #27 : Thua;
      end;
      if g>360 then g:=g-360;
      if g<0 then g:=g+360;
    Until key=#27;
 end;

 //-------=========>>>>>>>>>>>>>>BAT DAU<<<<<<<<<<========----------//
begin
 KhoiTaoChung;
 Xoa;
 if SoundMode then SndPlaySound(Music, Snd_Async);
 VietChu('AN PHIM BAT KY DE BAT DAU',40,300);Screen;
 repeat until keypressed;
 SndPlaySound('SOund/C.wav', Snd_Async);
 GAME;
 Tat;
end.
