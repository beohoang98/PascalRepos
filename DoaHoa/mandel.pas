{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1993-98 by Gernot Tenchio

    Mandelbrot Example using the Graph unit

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
program mandel;
{$goto on}
{
  Mandelbrot example using the graph unit.

  Note: For linux you need to run this program as root !!
}

{$ifdef mswindows}
 {$apptype GUI}
{$endif}

uses
{$ifdef mswindows}
  WinCrt in 'src/wincrt.pas',
  Windows ,

{$endif}

  dos,winGraph in 'src/wingraph.pas', color2;


const
  shift:byte=12;
  j=10;
  xx=1;
  yy=0.9;

type pointtype1=record
      x,y : longint;
     end;

var
  SearchPoint,ActualPoint,NextPoint       : PointType1;
  LastColor                              : longint;
  Gd,Gm                                  : smallint;
  Max_Color,Max_X_Width,
  Max_Y_Width,Y_Width                    : dword;
  Y1,Y2,X1,X2,Dy,Dx                      : Real;
  Zm                                     : longint;
  SymetricCase                                   : boolean;
  LineY                                  : array [0..600*j*2] OF word;
  LineX                                  : array [0..100*j*2,0..600*j*2] OF INTEGER;
  //diem                                   : array[-10000..10000,-10000..10000] of byte;
  mau                                    : word;
  zoom                                   : word;
const
    SX : array [0..7] OF SHORTINT=(-1, 0, 1, 1, 1, 0,-1,-1);
    SY : array [0..7] OF SHORTINT=(-1,-1,-1, 0, 1, 1, 1, 0);


type
    arrayType = array[1..50*j*2] of longint;

{------------------------------------------------------------------------------}
  function ColorsEqual(c1, c2 : longint) : boolean;
    begin
       ColorsEqual:=((GetMaxColor=$FF) and ((c1 and $FF)=(c2 and $FF))) or
         ((GetMaxColor=$7FFF) and ((c1 and $F8F8F8)=(c2 and $F8F8F8))) or
         ((GetMaxColor=$FFFF) and ((c1 and $F8FCF8)=(c2 and $F8FCF8))) or
         ((GetMaxColor>$10000) and ((c1 and $FFFFFF)=(c2 and $FFFFFF)));
    end;

{------------------------------------------------------------------------------}




procedure setcolor1(n : word);
 begin
  setcolor(n);
  mau:=n;
 end;


procedure putpixel1(x,y : longint; c : longword);
 begin

  if not((x*(x-1300)<=0) and (y*(y-700)<=0)) then exit;

  //diem[x,y]:=c;
  putpixel(x,y,c);
 end;

function getpixel1(x,y: longint): longword;
 begin
  if (x*(x-1300)<=0) and (y*(y-700)<=0) then
  exit(getpixel(x,y))
  else exit(1);
 end;

procedure line1(x1,y1,x2,y2 : longint);
 var step,dx,dy,i : longint;
 begin
  line(x1,y1,x2,y2);
  {putpixel1(x1,y1,mau);
  dx:=x2-x1;
  dy:=y2-y1;
  if (dx=0) and (dy=0) then exit;
  if abs(dx)>=abs(dy) then step:=abs(dx) else step:=abs(dy);
  dx:=dx div step;
  dy:=dy div step;
  for i:=1 to step do
   begin
    putpixel1(dx*i+x1,dy*i+y1,mau);
   end;  }
 end;

function CalcMandel(Point:PointType1; z:longint) : Longint ;
var
  x,y,xq,yq,Cx,Cy : real ;a : longint;
begin
  Cy:=y2 + dy*Point.y ;
  Cx:=x2 + dx*Point.x ;
  X:=-Cx ; Y:=-Cy ;
  a:=trunc(ln(j)/ln(2));
  if a=0 then a:=1;
  z:=z*a;
  repeat
    xq:=x * x;
    yq:=y * y  ;
    y :=x * y;
    y :=y + y - cy;
    x :=xq - yq - cx ;
    z :=z -1;
  until (Z=0) or (Xq + Yq > 4 );
  if Z=0 Then
    CalcMandel:=(blue and $FFFFFF)
  else
    CalcMandel:={DefaultColors[}(z div a mod Max_Color) + 1 {]};
end;

{-----------------------------------------------------------------------------}
procedure Partition(var A : arrayType; First, Last : Byte);
var
  Right,Left : byte ;
  V,Temp     : longint;
begin
    V := A[(First + Last) SHR 1];
    Right := First;
    Left := Last;
    repeat
      while (A[Right] < V) do
        inc(Right);
      while (A[Left] > V) do
        Dec(Left);
      if (Right <= Left) then
        begin
          Temp:=A[Left];
          A[Left]:=A[Right];
          A[Right]:=Temp;
          Right:=Right+1;
          Left:=Left-1;
        end;
    until Right > Left;
    if (First < Left) then
      Partition(A, First, Left);
    if (Right < Last) then
      Partition(A, Right, Last)
end;

{-----------------------------------------------------------------------------}
function BlackScan(var NextPoint:PointType1) : boolean;
begin
  BlackScan:=true;
  repeat
    if NextPoint.X=Max_X_Width then
      begin
        if NextPoint.Y < Y_Width then
          begin
            NextPoint.X:=0 ;
            NextPoint.Y:=NextPoint.Y+1;
          end
        else
          begin
            BlackScan:=false;
            exit;
          end ; { IF }
      end ; { IF }
    NextPoint.X:=NextPoint.X+1;
  until getpixel1(NextPoint.X,NextPoint.Y)=0;
end ;

{------------------------------------------------------------------------------}
procedure Fill(Ymin,Ymax,LastColor:longint);
var
 P1,P3,P4,P    : longint ;
 Len,P2        : dword ;
 Darray        : arraytype;
begin
  setcolor(LastColor);
  for P1:=Ymin+1 to Ymax-1 do
   begin
     Len:=LineY[P1] ;
     if Len >= 2 then
      begin
        for P2:=1 to Len do
          Darray[P2]:=LineX[P2,P1] ;
        if Len > 2 then
          Partition(Darray,1,len);
        P2:=1;
        repeat
          P3:= Darray[P2] ; P4:= Darray[P2 + 1];
          if P3 <> P4 then
           begin
             line1 ( P3 , P1 , P4 , P1) ;
             if SymetricCase then
              begin
                P:=Max_Y_Width-P1;
                line1 ( P3 , P , P4 , P ) ;
              end;
           end; { IF }
          P2:=P2+2;
        until P2 >= Len ;
      end; { IF }
   end; { FOR }
end;

{-----------------------------------------------------------------------------}
Function NewPosition(Last:Byte):Byte;
begin
  newposition:=(((last+1) and 254)+6) and 7;
end;

{-----------------------------------------------------------------------------}
procedure CalcBounds;
var
  lastOperation,KK,
  Position                     : integer ;
  foundcolor                   : longint;
  Start,Found,NotFound         : boolean ;
  MerkY,Ymax                   : longint ;
label
  L;
begin
  repeat
    FillChar(LineY,SizeOf(LineY),0) ;
    ActualPoint:=NextPoint;
    LastColor:=CalcMandel(NextPoint,Zm) ;
    putpixel1 (ActualPoint.X,ActualPoint.Y,LastColor);
    if SymetricCase then
      putpixel1 (ActualPoint.X,Max_Y_Width-ActualPoint.Y,LastColor) ;
    Ymax:=NextPoint.Y ;
    MerkY:=NextPoint.Y ;
    NotFound:=false ;
    Start:=false ;
    LastOperation:=4 ;
    repeat
      Found:=false ;
      KK:=0 ;
      Position:=NewPosition(LastOperation);
      repeat
        LastOperation:=(Position+KK) and 7 ;
        SearchPoint.X:=ActualPoint.X+Sx[LastOperation];
        SearchPoint.Y:=ActualPoint.Y+Sy[LastOperation];
        if ((SearchPoint.X < 0) or
            (SearchPoint.X > Max_X_Width) or
            (SearchPoint.Y < NextPoint.Y) or
            (SearchPoint.Y > Y_Width)) then
          goto L;
        if (SearchPoint.X=NextPoint.X) and (SearchPoint.Y=NextPoint.Y) then
          begin
            Start:=true ;
            Found:=true ;
          end
        else
          begin
            FoundColor:=getpixel1(SearchPoint.X,SearchPoint.Y) ;
            if FoundColor = 0 then
              begin
                FoundColor:= CalcMandel (SearchPoint,Zm) ;
                putpixel1 (SearchPoint.X,SearchPoint.Y,FoundColor) ;
                if SymetricCase then
                  putpixel1 (SearchPoint.X,Max_Y_Width-SearchPoint.Y,FoundColor) ;
              end ;
            if ColorsEqual(FoundColor,LastColor) then
              begin
                if ActualPoint.Y <> SearchPoint.Y then
                  begin
                    if SearchPoint.Y = MerkY then
                      LineY[ActualPoint.Y]:=LineY[ActualPoint.Y]-1;
                    MerkY:= ActualPoint.Y ;
                    LineY[SearchPoint.Y]:=LineY[SearchPoint.Y]+1;
                  end ;
                LineX[LineY[SearchPoint.Y],SearchPoint.Y]:=SearchPoint.X ;
                if SearchPoint.Y > Ymax then Ymax:= SearchPoint.Y ;
                  Found:=true ;
                ActualPoint:=SearchPoint ;
              end;
L:
            KK:=KK+1;
            if KK > 8 then
              begin
                Start:=true ;
                NotFound:=true ;
              end;
          end;
      until Found or (KK > 8);
    until Start ;
    if not NotFound then
      Fill(NextPoint.Y,Ymax,LastColor) ;
  until not BlackScan(NextPoint);
end ;


{------------------------------------------------------------------------------
                              MAINROUTINE
------------------------------------------------------------------------------}
  var
     error,dummy : smallint;

var i,neededtime,starttime : longint;
  hour, minute, second, sec100 : word;

const
  count : longint = 1;
  gmdefault = m640x480;

begin
  (*gm:=-1;
  if paramcount>0 then
    begin
       val(paramstr(1),gm,error);
       if error<>0 then
         gm:=gmdefault;
{$ifdef go32v2}
       if paramcount>1 then
         begin
           Val(paramstr(2),count,error);
           if error<>0 then
             count:=1;
         end;
       if paramcount>2 then
         UseLFB:=true;
       if paramcount>3 then
         UseNoSelector:=true;
{$endif go32v2}
    end;
  gd:=d8bit;
  if gm=-1 then
    GetModeRange(gd,dummy,gm);
  GetTime(hour, minute, second, sec100);
  starttime:=((hour*60+minute)*60+second)*100+sec100;
  {$ifdef mswindows}
   ShowWindow(GetActiveWindow,0);
  {$endif}                  *)
  gd:=d8bit;
  gm :=11;
  InitGraph(gd,gm,'');

  if GraphResult <> grOk then
    begin
      Writeln('Graph driver ',gd,' graph mode ',gm,' not supported');
      Halt(1);
    end;
   //fillchar(diem,sizeof(diem),0);
  for i:=j to j do
    begin

      Max_X_Width:=GetMaxX*i;
      Max_y_Width:=GetMaxY*i;
      Max_Color:=GetMaxColor-1;
      if Max_Color>255 then
        Max_Color:=255;
      ClearViewPort;

      x1:=-0.9-xx;
      x2:= 2.2-xx;
      y1:= 1.25+yy;
      y2:=-1.25+yy;
      zm:=90;
      dx:=(x1 - x2) / Max_X_Width ;
      dy:=(y1 - y2) / Max_Y_Width ;
      if abs(y1) = abs(y2) then
       begin
         SymetricCase:=true;
         Y_Width:=Max_Y_Width shr 1
       end
      else
       begin
         SymetricCase:=false;
         Y_Width:=Max_Y_Width;
       end;
      NextPoint.X:=0;
      NextPoint.Y:=0;
      LastColor:=CalcMandel(SearchPoint,zm);
      CalcBounds ;
      //copy(chr(i+48)+'.bmp');

    end;

  GetTime(hour, minute, second, sec100);
  neededtime:=((hour*60+minute)*60+second)*100+sec100-starttime;
{$ifndef fpc_profile}
  {$ifndef mswindows}
  readln;
  {$else: mswindows}
  repeat
  until keypressed;
  {$endif}
{$endif fpc_profile}
  CloseGraph;
  {$ifndef mswindows}
   Writeln('Mandel took ',Real(neededtime)/100/count:0:3,' secs to generate mandel graph');
   Writeln('With graph driver ',gd,' and graph mode ',gm);
  {$endif}
end.
