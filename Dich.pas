unit Dich;
{===========}
interface
{////////////////////////////////////////////////}
 const  maxL  =200; maxXT =100; maxMB = 50; SoLv=5;
        RLinh = 10; Rtank = 50; RMB   = 10;
        MauL0 =  5; Dtank =100; DMB   =100;
                    Dsung = 90; MauMB0=  5;
                    MauXT0= 10;

        LevelSpeed : array[1..solv] of word=(1  ,2  ,3  ,4  ,5  );
        LevelXMau  : array[1..solv] of real=(1.0,1.5,2.0,2.5,3.0);
 {---------------------------------------------------}
 type LinhType = record
                 x, y   : integer;
                 level  : word;
                 mau    : word;
                 speed  : word;
                 Xt, Yt : integer;
                end;
     TankType = record
                 x, y   : integer;
                 Xt, Yt : integer;
                 Gsung  : integer;
                 level  : word;
                 mau    : word;
                 speed  : word;
                end;
     MBType = record
               x, y   : integer;
               xt, yt : integer;
               level  : word;
               mau    : word;
               speed  : word;
              end;
 {----------------------------------------------------}
 Var Linh : Array[1..maxL]  of LinhType; SoLinh : word;
     Tank : Array[1..maxXT] of TankType; SoXT   : word;
     MB   : Array[1..MaxMB] of MBType;   SoMB   : word;

 {/////////////////////////////////////////////////////}
{=================================================}
 {--------------------------------------}
 Procedure ThemLinh(x0, y0 : integer; level0: word);
 Procedure LammoiLinh;
 Procedure KtLinh(var A: LinhType; x0, y0 : integer; level0 : word);
 Procedure UpdateLinh(var A: LinhType);

 {--------------------------------------}

{=================================================}
implementation


end.