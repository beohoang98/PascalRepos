Program GIF;
uses CRT,GRAPH,DEGIF;

var  InFileName:string;   BlockType:char;
     I,NewBottom,NewLeft,NewRight,NewTop,
     OffLeft,OffTop,Pass,XCord,YCord:integer;
     InFile:File;
     Buffer:array[0..32767] of byte;
     BufIndx,Count:word;
     Done,EOFin,SkipIt,Smash,Squeeze:Boolean;

procedure quit;
 begin
  close(output);textmode(co80);halt
 end;

procedure Abort;
 begin
  close(InFile);Quit
 end;

{$F+}
function GetByte: byte;
begin
 if not Done
  then begin
        if BufIndx >= Count
         then begin
               Done:=EOFIn;BlockRead(InFile,Buffer,SizeOf(Buffer),Count);
               EOFIn:=Count < sizeof(Buffer); BufIndx:=0
              end;
        GetByte:=Buffer[BufIndx]; Inc(BufIndx)
       end
  else GetByte:=0
end;
{$F-}

{$F+}
procedure PutByte(Pix: integer);
const YInc:array [1..5] of integer=(8,8,4,2,1);
      YLin:array [1..5] of integer=(0,4,2,1,0);
var x,y:integer;
begin
 if Squeeze then x:=XCord shr 1 else x:=XCord;
 if Smash   then y:=YCord shr 1 else y:=YCord;
 if SkipIt  then {nop}
            else Plot(X,Y,Color[CurMap,Pix]);
 Inc(XCord);
 if XCord = NewRight
  then begin XCord:=NewLeft;
             if KeyPressed then Abort;
             Inc(YCord,YInc[Pass]);
             SkipIt:=Smash and ((YCord and 1)=1);
             if YCord >= NewBottom
              then begin Inc(Pass); YCord:=YLin[Pass]+NewTop end
       end
end;
{$F-}

procedure DoMapping;
 var I:integer;
 begin
  for I:=0 to NumberOfColors[CurMap]-1 do Color[CurMap,I]:=I mod 4
 end;

procedure AdjustImage;
 begin
  NewLeft  := ImageLeft + OffLeft;
  NewTop   := ImageTop + OffTop;
  NewRight := ImageWidth + NewLeft;
  NewBottom:= ImageHeight + NewTop;
  XCord:=NewLeft;   YCord:=NewTop;
  if Interlaced then Pass:=1 else Pass:=5;
 end;

procedure DisplayScrDes;
var I:integer;
    AnsCh:char;
begin
 Writeln('Screen width =',ScreenWidth:5, '  Screen height   =',ScreenHeight:5);
 Writeln('Bits of color=',BitsOfColorPerPrimary:5,
         '  Number of colors=',NumberOfColors[Global]:5);
 OffLeft:=0; OffTop:=0;
 Smash:=false; Squeeze:=false;
 if ScreenHeight>200 then
  begin
   write('Screen Height is ',ScreenHeight:5,' do you want to Smash it? [Y]  ');
   AnsCh:=ReadKey;
   Smash:=AnsCh in [#13,'Y','y'];
   if Smash then begin writeln('Smashing'); I:=ScreenHeight div 2 end
            else I:=ScreenHeight;
   if I > 200
    then
     begin
      write('Screen too tall.  What line should I begin with? ');Readln(OffTop);
      OffTop:=-OffTop
     end
  end;
 if ScreenWidth > 320
  then
   begin
    write('Screen width ',ScreenWidth:5,' do you want to squeeze it? [Y]  ');
    AnsCh:=ReadKey;
    Squeeze:=AnsCh in [#13,'Y','y'];
    if Squeeze then begin writeln('Squeezing'); I:=ScreenWidth div 2 end
               else I:=ScreenWidth;
    if I > 200
     then
      begin
       write('Screen too wide.  What column should I begin with? ');Readln(OffLeft);
       OffLeft:=-OffLeft
      end
   end;
 end;

begin
 AddrGetByte:=@GetByte;
 AddrPutByte:=@PutByte;
 AssignCrt(output);Rewrite(OUTPUT);
 writeln('DeGIFer version 0.1 demo for DEGIF Turbo Pascal Unit');
 writeln('  Copyright (c) 1988 Cyborg Software Systems, Inc.');writeln;
 writeln('     GIF and "Graphics Interchange Format" are');
 writeln('    trademarks (tm) of CompuServe Incorporated');
 writeln('           an H&R Block Company.');writeln;writeln;
 if paramcount=0
  then begin
        write('Enter GIF file name:  '); readln(infilename);
       end
  else InFileName:=paramstr(1);
 if length(InFileName)>0 then
  begin
   assign(InFile,InFileName);
   {$I-}
   reset(InFile,1);
   if ioresult<>0
    then begin writeln('GIF datafile could not be found.'); Quit end;
   SkipIt:=false;
   EOFin:=false;
   Done:=false;
   BufIndx:=999;Count:=0;
   CurMap:=Global;
   GetGIFSig;
   if GIFSig<>'GIF87a' then begin writeln('Invalid GIF ID'); Abort end;
   GetScrDes;
   DisplayScrDes;
   if MapExists[Global] then GetColorMap;
   DoMapping;
   writeln('Press <Enter> to display');  readln;
   GraphColorMode;
   while not Done Do
    begin
     BlockType:=chr(GetByte);
     case BlockType of
      ',':begin
           GetImageDescription;
           AdjustImage;
           if MapExists[Local]
            then begin CurMap:=Local; GetColorMap; DoMapping end
            else CurMap:=Global;
           if ExpandGIF <>0 then Halt
          end;
      '!':SkipExtendBlock;
     end;
    end;
  end;
 Sound(440);Delay(100);NoSound;Readln;Abort;
end.

