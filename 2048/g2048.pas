uses crt,wincrt;

const n=4;m=12;

var a : array[0..n+1,0..n+1] of integer;
    t : array[0..m] of string[4];
    c : char;
    i, j : integer;
    tr : array[0..n] of boolean;

procedure thua;
 var n,i : integer;
     note: array[1..100] of integer;
 begin
  assign(input,'asd.ms');reset(input);
  readln(n);
  for i:=1 to n do
   begin
    if i mod 10 =0 then readln;
    read(note[i]);
   end;
  close(input);
  for i:=1 to n do wincrt.sound(note[i]);
  halt;
 end;

procedure dem;
 var count,i,j : integer;
 begin
  count:=0;
  for i:=1 to n do
   for j:=1 to n do
    if a[i,j]<>0 then inc(count);
  if count=n*n then halt;
 end;

procedure ngaunhien;
 begin
  dem;
  i:=random(n)+1;
  j:=random(n)+1;
  while a[i,j]<>0 do
   begin
    i:=random(n)+1;
    j:=random(n)+1;

   end;
  a[i,j]:=random(2)+1;
 end;

procedure win;
 begin
  clrscr;
  textcolor(14);
  gotoxy(10,10);write('лл   лл   л   л    лл');
  gotoxy(10,11);write(' л л л    л   ллл   л');
  gotoxy(10,12);write('  л л     л   л лл  л');
  gotoxy(10,13);write('  л л     л   л   ллл');
  readln;
  halt;
 end;

procedure right;
 var i,j,k,t : integer;

 begin
  for j:=1 to n do
   begin
   fillchar(tr,sizeof(tr),true);
   for i:=n-1 downto 1 do
    if a[i,j]<>0 then
     for k:=i+1 to n+1 do
      begin

       if ((a[i,j]<>a[k,j]) and (a[k,j]<>0))
        or ((a[i,j]=a[k,j]) and (tr[k]=false)) then
        begin
         t:=a[i,j];
         a[i,j]:=a[k-1,j];
         a[k-1,j]:=t;
         break;
        end;
       if (a[i,j]=a[k,j]) and tr[k] then
        begin
         a[k,j]:=a[k,j]+1;
         a[i,j]:=0;
         tr[k]:=false;
         break;
        end;
      end;
    end;
   ngaunhien;
 end;

procedure left;
 var i,j,k,t : integer;
 begin
  for j:=1 to n do
   begin
   fillchar(tr,sizeof(tr),true);
   for i:=2 to n do
    if a[i,j]<>0 then
     for k:=i-1 downto 0 do
      begin
       if ((a[i,j]<>a[k,j]) and (a[k,j]<>0))
       or ((a[i,j]=a[k,j]) and (tr[k]=false)) then
        begin
         t:=a[i,j];
         a[i,j]:=a[k+1,j];
         a[k+1,j]:=t;
         break;
        end;
       if (a[i,j]=a[k,j]) and tr[k] then
        begin
         a[k,j]:=a[k,j]+1;
         a[i,j]:=0;
         tr[k]:=false;
         break;
        end;
      end;
    end;
   ngaunhien;
 end;

procedure up;
 var i,j,k,t : integer;
 begin
  for i:=1 to n do
   begin
   fillchar(tr,sizeof(tr),true);
   for j:=2 to n do
    if a[i,j]<>0 then
     for k:=j-1 downto 0 do
      begin
       if ((a[i,j]<>a[i,k]) and (a[i,k]<>0))
       or ((a[i,j]=a[i,k]) and (tr[k]=false)) then
        begin
         t:=a[i,j];
         a[i,j]:=a[i,k+1];
         a[i,k+1]:=t;
         break;
        end;
       if (a[i,j]=a[i,k]) and tr[k] then
        begin
         a[i,k]:=a[i,k]+1;

         a[i,j]:=0;
         tr[k]:=false;
         break;
        end;
      end;
    end;
   ngaunhien;
 end;

procedure down;
 var i,j,k,t : integer;
 begin
  for i:=1 to n do
   begin
   fillchar(tr,sizeof(tr),true);
   for j:=n-1 downto 1 do
    if a[i,j]<>0 then
     for k:=j+1 to n+1 do
      begin
       if ((a[i,j]<>a[i,k]) and (a[i,k]<>0))
       or ((a[i,j]=a[i,k]) and (tr[k]=false)) then
        begin
         t:=a[i,j];
         a[i,j]:=a[i,k-1];
         a[i,k-1]:=t;
         break;
        end;
       if (a[i,j]=a[i,k]) and tr[k] then
        begin
         a[i,k]:=a[i,k]+1;
         a[i,j]:=0;
         tr[k]:=false;
         break;
        end;
      end;
    end;
   ngaunhien;
 end;

begin
 randomize;
 fillchar(a,sizeof(a),0);
 for i:=1 to n do a[i,0]:=-1;
 for i:=1 to n do a[0,i]:=-1;
 for i:=1 to n do a[n+1,i]:=-1;
 for i:=1 to n do a[i,n+1]:=-1;
 a[random(n)+1,random(n)+1]:=1;
 t[0]:='    ';
 t[1]:='2   ';
 t[2]:='4   ';
 t[3]:='8   ';
 t[4]:='16  ';
 t[5]:='32  ';
 t[6]:='64  ';
 t[7]:='128 ';
 t[8]:='256 ';
 t[9]:='512 ';
 t[10]:='1024';
 t[11]:='2048';
 t[12]:='4096';
 textcolor(15);
 clrscr;
 repeat

  case c of
   #77 : right;
   #75 : left;
   #72 : up;
   #80 : down;
  end;
  clrscr;

  for i:=1 to n do
   for j:=1 to n do
    begin
     gotoxy(i*6+1,j*2);
     textcolor(8);write('|');
     textcolor(15);write(t[a[i,j]]);
     textcolor(8);write('|');
     if a[i,j]=11 then win;
    end;
  c:=crt.readkey;
 until c=#27;
end.
