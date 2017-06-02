PROGRAM GoMoku;
USES crt;
CONST
     edge=0; us=1; them=2; none=3;
     gridsize=15;
     maxmoves=200;
     alphabet=96;
     null=' ';
TYPE
    squares=edge..none;
    smallint=0..gridsize;
    BYTE=0..255;
    cardinal=0..65535;
    line=ARRAY[0..9] OF squares;
VAR
   grid: ARRAY[1..gridsize,1..gridsize] OF squares;
   name: ARRAY[squares] OF CHAR;
   icol, irow: ARRAY[1..4] OF -1..1;
   play: PACKED ARRAY[1..maxmoves] OF RECORD
                rowfield, colfield: smallint;
         END;
   v, vals: ARRAY[1..4] OF INTEGER;
   i,j,r,c: smallint;
   onboard: SET OF smallint;
   move: cardinal;
   endgame: squares;
   yourturn: BOOLEAN;
   topvalue: INTEGER;
   response: CHAR;
   px,py : word;

PROCEDURE tell;
VAR y: CHAR;
BEGIN
    writeln('Caro co dien _ code Pascal _ rebuilder by Qlam');
    writeln;
     write('Nhan Enter de vao game ');
     readln(y);
     IF y<> 'n' THEN BEGIN
            writeln;
        writeln('San sang chua ^^');

     END;
END;

PROCEDURE init;
VAR m: REAL;
BEGIN
     name[none]:='.';
     name[us]:='o';
     name[them]:='x';
     name[edge]:='-';
     irow[1]:=0; icol[1]:=-1;
     irow[2]:=-1; icol[2]:=-1;
     irow[3]:=-1; icol[3]:=0;
     irow[4]:=-1; icol[4]:=1;
     onboard:=[1..gridsize];
END;

PROCEDURE whofirst(VAR youfirst: BOOLEAN);
VAR no: CHAR;
BEGIN
     writeln;
     write('Ban muon di dau tien ko (n=ko, Enter=co) ?: ');
     readln(no);
     youfirst:=no<>'n';
END;

PROCEDURE slab(r,c,compass:smallint; VAR l: line);
VAR i,j: INTEGER; k:smallint;
BEGIN
     i:=r; j:=c;
     FOR k:=4 DOWNTO 0 DO BEGIN
         i:=i+irow[compass];
         j:=j+icol[compass];
         IF (i IN onboard) AND (j IN onboard) THEN
            l[k]:=grid[i,j]
         ELSE l[k]:=edge;
     END;
     i:=r; j:=c;
     FOR k:=5 TO 9 DO BEGIN
         i:=i-irow[compass];
         j:=j-icol[compass];
         IF (i IN onboard) AND (j IN onboard) THEN
            l[k]:=grid[i,j]
         ELSE l[k]:=edge;
     END;
END;

PROCEDURE remember(i,j: smallint);
BEGIN
     play[move].rowfield:=i;
     play[move].colfield:=j;
END;

PROCEDURE dumpgame(m: cardinal);
VAR n:cardinal;
BEGIN
     FOR n:=1 TO m DO
         WITH play[n] DO BEGIN
              write(chr(colfield+alphabet),rowfield:2);
              IF odd(n) THEN write(' ')
              ELSE writeln;
         END;
END;

FUNCTION foursome(VAR span: line; self: squares): INTEGER;
VAR best: INTEGER; nearhere: BOOLEAN;
    i,s,firstone,last,gaps: cardinal;
    friendly: SET OF squares;
BEGIN
     best:=0; friendly:=[none,self];
     FOR i:=1 TO 5 DO BEGIN
         firstone:=0; last:=0;
         gaps:=0; nearhere:=FALSE;
         s:=i;
         WHILE (gaps<4) AND(s<i+4) DO BEGIN
               IF span[s]=none THEN gaps:=gaps+1
               ELSE IF span[s]=self THEN BEGIN
                    last:=s;
                    IF firstone=0 THEN firstone:=s;
                    nearhere:=nearhere OR (s IN [4,5]);
               END
               ELSE gaps:=4;
               s:=s+1;
         END;
         s:=sqr(4-gaps);
         IF (last-firstone)<(4-gaps) THEN s:=s+1;
         IF nearhere THEN s:=s+1;
         IF [span[i-1],span[i+4]]<=friendly THEN s:=s+1;
         IF s>best THEN best:=s;
     END;
     foursome:=best;
END;

FUNCTION max(x,y: INTEGER): INTEGER;
BEGIN
     IF x>y THEN max:=x
     ELSE max:=y;
END;

FUNCTION evaluate(r,c:smallint): INTEGER;
VAR noughts,crosses,x: INTEGER; i,j,thisway: smallint;
    span: line;
BEGIN
     FOR thisway:=1 TO 4 DO BEGIN
         slab(r,c,thisway,span);
         noughts:=foursome(span,us)+2;
         crosses:=foursome(span,them);
         v[thisway]:=max(noughts,crosses)-2;
     END;
     FOR i:=1 TO 3 DO
         FOR j:=1 TO 4-i DO
             IF v[j]<v[j+1] THEN BEGIN
                x:=v[j]; v[j]:=v[j+1]; v[j+1]:=x;
             END;
     evaluate:=v[1]*64+v[2]*16+v[3]*4+v[4];
END;

PROCEDURE makemove(VAR r,c: smallint);
VAR bestcol, bestrow, tr, tc: smallint; e:INTEGER;
BEGIN
     topvalue:=0;
     bestrow:=0; bestcol:=0;
     IF move=1 THEN BEGIN
        bestrow:=gridsize DIV 2 +1;
        bestcol:=bestrow;
     END
     ELSE
         FOR tr:=1 TO gridsize DO
             FOR tc:=1 TO gridsize DO
                 IF grid[tr,tc]=none THEN BEGIN
                    e:=evaluate(tr,tc);
                    IF (e>topvalue) OR (bestrow=0) THEN BEGIN
                       topvalue:=e; bestrow:=tr;
                       bestcol:=tc; vals:=v;
                    END;
                 END;
     r:=bestrow; c:=bestcol;
END;

PROCEDURE getmove(VAR i,j: smallint);
VAR c,s: CHAR; ok: BOOLEAN; x,y: INTEGER;
BEGIN
     writeln;
     {REPEAT
           write('Ban muon di o nao ? (vd: e6 )');
           read(c); readln(i);
           cols:=ord(c)-alphabet;
           ok:=(i IN onboard) AND (cols IN onboard);
           writeln;
           IF NOT ok THEN writeln('Ko co vi tri tai ',c,i:2)
           ELSE IF grid[i,cols]<>none THEN BEGIN
                ok:=FALSE;

                writeln('o ',c,i:2,' da co!');
           END;
     UNTIL ok;
     j:=cols;}
     x:=px;y:=py;
     repeat
      ok:=false;
      s:=name[grid[y,x]];
      gotoxy(x*2+4,y+2);write('A');
      c:=readkey;
      gotoxy(x*2+4,y+2);Write(s);
      case c of
       #75 : if x>1 then dec(x);
       #77 : if x<gridsize  then inc(x);
       #72 : if y>1 then dec(y);
       #80 : if y<gridsize  then inc(y);
       #13 : if grid[y,x]=none then ok:=true;
       #27 : halt;
      end;
     until ok;
     i:=y;
     j:=x;
END;

FUNCTION test(r,c: smallint): squares;
VAR l: line; stop: BOOLEAN;
    d,k,p: smallint; mine: squares;
BEGIN
     mine:=grid[r,c];
     d:=1;
     REPEAT
           slab(r,c,d,l);
           k:=1;
           stop:=FALSE;
           FOR p:=5 TO 8 DO
               IF NOT stop AND (l[p]=mine) THEN k:=k+1
               ELSE stop:=TRUE;
           stop:=FALSE;
           FOR p:=4 DOWNTO 1 DO
               IF NOT stop AND (l[p]=mine) THEN k:=k+1
               ELSE stop:=TRUE;
           d:=succ(d);
     UNTIL (d>4) OR (k>4);
     IF k<5 THEN test:=none
     ELSE test:=mine;
END;

PROCEDURE show(i,j,r,c: smallint);
VAR n, rows: smallint;
BEGIN
     clrscr;

     writeln('So buoc da choi ',move:4,' Di chuyen:');
     write(null:4);
     FOR n:=1 TO gridsize DO write(chr(alphabet+n):2);
     writeln;
     FOR rows:=1 TO gridsize DO BEGIN
         write(rows:2,null:2);
         FOR n:=1 TO gridsize DO write(null,name[grid[rows,n]]);
         writeln;
     END;
     IF move >1 THEN writeln('Di chuyen truoc cua ban: ',chr(j+alphabet),i:2);
     writeln('Di chuyen truoc cua PC: ',chr(c+alphabet),i:2);
     FOR n:=1 TO 4 DO write(vals[n]:8); {?????}
     writeln(topvalue:8);
     writeln;
END;

PROCEDURE message(wins: squares);
BEGIN
     IF wins=us THEN writeln('May tinh thang roi ^&^!')
     ELSE IF wins=them THEN writeln('Woa, ban thang roi!')
     ELSE IF wins=none THEN writeln('Thu vi qua, Hoa roi!');
END;

BEGIN {main}
      clrscr;        px:=1;py:=1;
      init;
      tell;
      REPEAT
            FOR r:=1 TO gridsize DO
                FOR c:=1 TO gridsize DO
                    grid[r,c]:=none;
            whofirst(yourturn);
            move:=0; endgame:=none;
            show(i,j,r,c);
            REPEAT
                  IF yourturn THEN BEGIN
                     move:=move+1;
                     getmove(i,j);
                     grid[i,j]:=them;
                     remember(i,j);
                     endgame:=test(i,j);
                  END
                  ELSE yourturn:=TRUE;
                  IF endgame=none THEN BEGIN
                     move:=move+1;
                     makemove(r,c);
                     grid[r,c]:=us;
                     px:=c;py:=r;
                     remember(r,c);
                     endgame:=test(r,c);
                  END;
                  show(i,j,r,c);
            UNTIL (endgame<>none) OR (move>maxmoves);
            message(endgame);
            writeln;
            write('Ban muon xem phim da bam? (y=co, Enter=ko)');
            readln(response);
            IF response='y' THEN dumpgame(move);
            write('Choi lai (n=Tat game ,enter=Choi lai)?:');
            readln(response);
      UNTIL response='n';
END.
