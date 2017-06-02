{
    $Id: gplunit.pt,v 1.2 2002/09/07 15:40:47 peter Exp 2015/07/25 09:31:22 peter Exp $
    This file is part of FlappyPascal
    Copyright (c) 2015 by Beo

    Doc cac file du lieu

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
unit FlapRead;

interface




procedure DocBkg;
procedure DocBird;
Procedure DocCot;
Procedure DocDulieu;


implementation

uses FlapGraph ;

const  fbird : array[1..SoFrame] of string= ('bird1.bmp','bird2.bmp','bird3.bmp');
       data_dir = 'dulieu/';
       fcot = 'cot.bmp';
       fBkGround = 'hinhnen.bmp';

Procedure DocBird;
Procedure DocCot;
 Var f : file;
 Begin
  assign(f,fcot);reset(f,1);
  blockread(f,size,sizeof(size));
  seek
 End;
Procedure DocBkg;
 begin
  Assign(f,fBkGround);reset(f,1);
  size:=sizeof(f);
  GetMem(BackGround,size);
  blockread(f,BackGround^,size);
  close(f);
 end;

Procedure DocDulieu;
 begin
  DocBird;
  DocCot;
  DoocBkg;
 end;

end.


