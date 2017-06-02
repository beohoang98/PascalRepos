{
    $Id: gplunit.pt,v 1.2 2002/09/07 15:40:47 peter Exp 2016/10/15 17:35:36 peter Exp $
    This file is part of Snake360
    Copyright (c) 2016 by Beo

    Menu for Snake360

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
unit Snake360_Menu;

interface

 const  DaiCB = 200; RongCB = 100;
        SoNutTD = 10;

 type  NutType = record
                  TieuDe : string;
                  //Dai, Rong : word;
                  XNut, YNut : word;
                  MauHT, MauBT, MauNhan : longword;
                  MauChu : Longword;
                  OnMove, OnClick : Boolean;
                 end;
       MenuType = record
                   TenMenu : string;
                   SoNut : word;
                   Nut : array[1..SoNutTD] of NutType;
                   XM, YM, KCach : word;
                   NutHt : word;
                  end;

 Function KhoiTaoMenu(Ten: string): MenuType;
 Procedure AddNut(Ten: string; Var A: MenuType; So: Word);



implementation
 uses wingraph in 'src/wingraph.pas',
     winmouse in 'src/winmouse.pas',
     RGBA in 'src/rgba.pas';


 var   Menu : MenuType;
      XM,YM,BM : longint;

 Function KhoiTaoMenu(ten : string): MenuType;
  Var W,H : Word;
  begin
   W:=TextWidth(ten);
   H:=TextHeight(ten);
   with KhoiTaoMenu do begin
        TenMenu:=ten;
        Sonut:=0;
        FillCHar(Nut, sizeof(nut), 0);
        X:=(GetMaxX-W) div 2;
        Y:=10;
        KCach:=5;
        NutHt:=0;
   end;
  end;
 Procedure AddNut(Ten: string; Var A: MenuType; So: word);
  begin
   With A do begin
        Inc(SoNut);
        With Nut[SoNut] do begin
                TieuDe:=Ten;

        end;
   end;
  end;

end.
