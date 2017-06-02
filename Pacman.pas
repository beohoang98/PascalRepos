Program Pacman;   //ayhgdfwhagwdhawgvhdw =))))

uses crt; // su dung thu vien de xa`i ban phim

const h=30; w=16; //chieu dai va rong cua map
      maptxt = 'map.txt'; //duong dan vao file du lieu map
      data = 'pacscore.pac'; //duong dan vao file highscore
      dx : array[1..4] of integer=(0,1,0,-1);
      dy : array[1..4] of integer=(-1,0,1,0);
                   {   |1|  (0,-1)
              (-1,0) |4| |2|  (1,0)
                       |3| (0,1)      }
      speed = 100;
      anh : array[1..4] of char=('V','<','A','>');
      mapchar : array[0..2] of char=(' ','X','.');
      wall_no=1; diem_no = 2;  pacno = 3;ghost_no = 4; //so hieu

      keyd = 3; //xuong
      keyu = 1; //len
      keyr = 2; //phai
      keyl = 4; //trai
      enter_no=5;

      level = 5;
      soghost : array[1..level] of word=(1,2,3,4,5);   //so con ma moi level
      max_diem_level : array[1..level] of word=(100,200,500,1000,2000);

      pac_mau = 14;
      wall_mau = 4;
      ghost_mau = 13;  //so hieu mau cua

      Play_no=1;
      Exit_no=3;
      HScore_no=2;
      thoat_no=0;
      pause_no=-2;

      huongdan : array[1..5] of string=('bam ENTER de chon, ESC de thoat',
                                        'w-len',
                                        's-xuong',
                                        'd-phai',
                                        'a-trai'   );

type ma = record
           x,y : word;
           hg : byte;
          end;

var  map : array[0..h+1,0..w+1] of byte;
     pac : record
            x,y : word;
            hg : byte;
            time : byte;
           end;
     ghost : array[1..100] of ma;
     keyexit : integer;
     diem : word;
     score : array[1..10] of record
                               nem : string[10];
                               diem: longword;
                             end;
     LevelHt : byte;


procedure readmap;
 var f : text;
     i,j : word;
     s: char;
 begin
  fillchar(map,sizeof(map),1);
  assign(f,maptxt);reset(f);
  for j:=1 to w do
   begin
    for i:=1 to h do
     begin
      read(f,s);
      map[i,j]:=ord(s)-48;
      if map[i,j]=0 then map[i,j]:=2;
     end;
    readln(f);
   end;
  close(f);

  for j:=0 to w+1 do
   begin
    for i:=0 to h+1 do
     begin
      if map[i,j]=diem_no then textcolor(1) else textcolor(wall_mau);
      Write(mapchar[map[i,j]]);
     end;
    writeln;
   end;

 end;

Procedure ChuThich;
 var i : byte;
 begin
  textcolor(15);
  for i:=1 to 5 do
   begin
    gotoxy(35,i+1);write(huongdan[i]);
   end;
  gotoxy(35,7); textcolor(pac_mau); write('O - you');
  gotoxy(35,8); textcolor(ghost_mau); write('@ - con ma');

 end;

Procedure KhoitaoGhost;
 var i,x,y : word;
 begin
  for i:=1 to soghost[levelHt] do
   begin
    repeat
     x:=random(h);
     y:=random(w);
    until (map[x,y]<>wall_no) and (map[x,y]<>ghost_no);
    map[x,y]:=ghost_no;
    ghost[i].x:=x;
    ghost[i].y:=y;
    ghost[i].hg:=random(4)+1;
   end;

 end;

procedure docscore;
  var j : byte;  f : file;
  begin
   {$I-}
   assign(f,data);reset(f,1);
   {$I+}
   if IOResult<>0 then
    for j:=1 to 10 do
      begin
       score[j].nem:='Lord';
       score[j].diem:=700;
      end
   else blockread(f,score,sizeof(score));
   close(f);
  end;
Procedure ghi;
  var f: file; a: string[10]; i,j : word; t : longword;
  begin
   clrscr;
   Write('Nhap ten cua ban(max 10 chu cai): ');readln(a);
   score[10].nem:=a;
   score[10].diem:=diem;
   for i:=1 to 10-2 do
    for j:=i+1 to 10 do
     if score[i].diem<score[j].diem then
      begin
       t:=score[i].diem; score[i].diem:=score[j].diem; score[j].diem:=t;
       a:=score[i].nem; score[i].nem:=score[j].nem; score[j].nem:=a;
      end;
   assign(f,data);rewrite(f,1);
   blockwrite(f,score,sizeof(score));
   close(f);
  end;

Procedure Init;
 begin
  randomize;
  clrscr;
  docscore;
 end;

procedure Key;
 var k : char;
 begin
  keyexit:=-1;
  if keypressed then
   begin
    k:=readkey;
    case k of
     #27 : keyexit:=pause_no;
     #75 : keyexit:=keyl;
     #72 : keyexit:=keyu;
     #77 : keyexit:=keyr;
     #80 : keyexit:=keyd;
     #13 : keyexit:=enter_no
    end;

   end;
 end;

Procedure Thua;
 begin
  keyexit:=thoat_no;
  delay(1000);
 end;

Procedure TinhPac;
 var xx,yy: integer;
 begin

  with pac do
   begin
    if map[x,y]=ghost_no then thua;
    if keyexit>0 then hg:=keyexit;
    xx:=x+dx[hg];
    yy:=y+dy[hg];
    if map[xx,yy]<>1 then
     begin
      x:=x+dx[hg];
      y:=y+dy[hg];
     end;
    if map[x,y]=diem_no then inc(diem,levelHt);
    if map[x,y]=ghost_no then thua;
    map[x,y]:=0;
   end;
  inc(pac.time);
  if pac.time>5 then pac.time:=1;
 end;

Procedure TinhGhost;
 var n, hg2: word;
 begin
  for n:=1 to SoGhost[levelHt] do
   with ghost[n] do
    begin
     hg2:=random(4)+1;
     if (map[x+dx[hg2],y+dy[hg2]]<>wall_no) and (abs(hg2-hg)<>2) then
      begin hg:=hg2; end;
     while (map[x+dx[hg],y+dy[hg]]=wall_no) do hg:=random(4)+1;

     map[x,y]:=diem_no;
     x:=x+dx[hg];
     y:=y+dy[hg];
     map[x,y]:=ghost_no;
    end;
 end;

Procedure VeGhost(n,k : word);
 begin
  Textcolor(ghost_mau);
  with Ghost[n] do
   begin
    gotoxy(x+1,y+1);
    if k=1 then begin textcolor(ghost_mau);Write('@'); end
    else begin textcolor(1);Write('.'); end;
   end;
 end;



Procedure VePac(n : word);
 begin
  textcolor(pac_mau);
  if n=0 then
   begin
    Gotoxy(pac.x+1,pac.y+1);
    Write(' ');
    exit;
   end;
  Gotoxy(pac.x+1,pac.y+1);
  if pac.time>3 then Write('O')
  else write(anh[pac.hg]);
 end;

Procedure Xoa;
 var i: word;
 begin
  for i:=1 to SoGhost[levelHt] do VeGhost(i,0);
  VePac(0);
 end;

Procedure Ve;
 var i,j : word;
 begin
  //gotoxy(1,1);
  {for j:=0 to w+1 do
   begin
    for i:=0 to h+1 do Write(mapchar[map[i,j]]);
    writeln;
   end;       }
  VePac(1);
  for i:=1 to SoGhost[levelHt] do VeGhost(i,1);
  gotoxy(2,w+3);write('so diem: ',diem);
  delay(speed);
 end;

procedure play;
 procedure Init;
  begin
   pac.x:=1;
   pac.y:=1;   // khoi tao ban dau tai vi tri (1,1)
   pac.hg:=2;
   pac.time:=1;
   clrscr;
   Write('Level ',levelHT);
   delay(2000);
   clrscr;
   readmap;
   KhoitaoGhost;
   keyexit:=keyr ;
   Chuthich;
  end;
 Procedure Pause;
  var c : char;
  begin
   gotoxy(h,w+3);
   Write('enter-Tiep tuc; Esc-Thoat');
   repeat
    c:=readkey;
    if c=#27 then keyexit:=thoat_no;
   until (c=#27) or (c=#13);
   gotoxy(h,w+3);
   Write('                         ');
  end;

 begin
  levelHT:=1;
  Init; diem:=0;
  repeat
   Xoa;
   Key;
   TinhGhost;
   TinhPac;
   gotoxy(1,w+5);write('LEVEL: ',levelHT);
   Ve;
   if levelHT<level then
    if diem>=max_diem_level[levelHt] then
     begin
      inc(levelHt);
      Init;
     end;
   if keyexit=pause_no then Pause;
  until keyexit=thoat_no;
  Ghi;
 end;

function Menu: word;
 const num = 3;
 var n : word;c: char;
 begin
  clrscr;
  textcolor(15);
  n:=1;
  ChuThich;
  repeat
   gotoxy(5,n*5);write(' ');
   case c of
    #72 : if n>1 then dec(n);
    #80 : if n<num then inc(n);
   end;
   gotoxy(10,5);write('Play');
   gotoxy(10,10);Write('High Score');
   gotoxy(10,15);WRite('Thoat');
   gotoxy(5,n*5);Write('X');
   c:=readkey;
  until c=#13;
  exit(n);
 end;

Procedure HighScore;
 var f : file;
     j : byte;
     c : char;
 begin
  clrscr;
  ChuThich;
  textcolor(15);
  gotoxy(1,1);
  write('name______|','__score___|');
  for j:=1 to 10 do
   begin
    gotoxy(1,j+1);write(score[j].nem:10,'|',score[j].diem:10,'|');
   end;
  repeat
   c:=readkey;
  until c=#27;
 end;

begin
 Init;
 WRITE(' PAC-MAN  ');readln;
 repeat
  case Menu of
   play_no : play;
   hscore_no : highscore;
   exit_no: exit;
  end;
 until false;
 clrscr;

end.
