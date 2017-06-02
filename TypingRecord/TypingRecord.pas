Uses crt, windows;

Type Chu = record
            Ch : Char;
            Time : word;
           end;

Var  A : array[0..10000] of chu;
     GhiEnter : array[0..100] of word;
     f : file;

Procedure BatdauGhi;
 var t , offset, x, y: longword; key : char;
 begin
  Clrscr;
  FillChar(A,sizeof(A),0);
  offset:=1;
  A[0].Time:=0;
  x:=1; y:=1;
  repeat
   t:=gettickcount;
   key:=readkey;
   t:=gettickcount-t;
   Case Key of
    #13: begin
          writeln;
          GhiEnter[y]:=x;
          x:=1;
          inc(y);
         end;
    #8 : begin
          if x=1 then
           begin
            y:=y-1;
            x:=GhiEnter[y];
            gotoxy(x,y);
            write(' ',#8);
           end
          else
           begin
            gotoxy(x,y);write(#8,' ',#8);
            x:=x-1;
           end;
         end;
   else begin
         x:=x+1;
         write(Key);
        end;
   end;

   A[offset].Ch:=Key;
   A[offset].time:=t;
   inc(A[0].time);
   inc(offset);

  until key=#27;

  assign(f,'diep.yen'); rewrite(f,1);
  Blockwrite(f,A,sizeof(A));
  close(f);
 end;

Procedure PhatLai;
 var i,x,y: longword;
 begin
  assign(f,'diep.yen');
  reset(f,1); blockread(f,A,sizeof(A)); close(f);
  Clrscr;
  x:=1; y:=1;
  For i:=1 to A[0].Time do
   begin
    //If Keypressed then exit;
    Case A[i].Ch of
    #13: begin
          writeln;
          GhiEnter[y]:=x;
          x:=1;
          inc(y);
         end;
    #8 : begin
          if x=1 then
           begin
            y:=y-1;
            x:=GhiEnter[y];
            gotoxy(x,y);
            write(' ',#8);
           end
          else
           begin
            gotoxy(x,y);
            write(#8,' ',#8);
            x:=x-1;
           end;
         end;
   else begin
         x:=x+1;
         write(A[i].Ch);
        end;
   end;
    Delay(A[i].Time);
   end;

 end;

begin
 //BatDauGhi;
 PhatLai;

end.
