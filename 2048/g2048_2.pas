uses wincrt in 'wingraph/wincrt.pas',
     wingraph in 'wingraph/wingraph.pas',
     docbmp in '../docbmp.pas';

const n=5;m=12; dir = 'C:/FPC/2.6.2/bin/i386-win32/2048/';


var a ,b: array[0..n+1,0..n+1] of integer;
    t : array[0..m] of string;
    diemao, diemthat : longint;
    c : char;
    i, j ,k,tp : longint;
    tr : array[0..n] of boolean;
    gd,gm : integer;
    num : array[0..11] of diempic;

function xau(n : longint): string;
 var s : string;
 begin
  str(n,s);
  exit(s);
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
         inc(diemthat);

         break;
        end;
      end;
    end;

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
         inc(diemthat);

         break;
        end;
      end;
    end;

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
         inc(diemthat);

         break;
        end;
      end;
    end;

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
         inc(diemthat);

         break;
        end;
      end;
    end;

 end;

procedure hienthi;
 begin
   diemao:=0;
   for i:=1 to n do
   for j:=1 to n do
    if a[i,j]<>b[i,j] then
    begin
     vepic(num[a[i,j]],i*60,j*60);
     b[i,j]:=a[i,j];
     inc(diemao);
     if a[i,j]=11 then exit;
    end;
   if diemao>0 then ngaunhien;
   for i:=1 to n do
   for j:=1 to n do
    if a[i,j]<>b[i,j] then
    begin
     vepic(num[a[i,j]],i*60,j*60);
     b[i,j]:=a[i,j];


    end;
 end;

begin
 gd:=nopalette;
 gm:=m800x600;
 initgraph(gd,gm,'');
 randomize;
 diemthat:=0;
 fillchar(a,sizeof(a),0);
 for i:=1 to n do a[i,0]:=-1;
 for i:=1 to n do a[0,i]:=-1;
 for i:=1 to n do a[n+1,i]:=-1;
 for i:=1 to n do a[i,n+1]:=-1;
 a[random(n)+1,random(n)+1]:=1;
 t[0]:='0';
 t[1]:='2';
 t[2]:='4';
 t[3]:='8';
 t[4]:='16';
 t[5]:='32';
 t[6]:='64';
 t[7]:='128';
 t[8]:='256';
 t[9]:='512';
 t[10]:='1024';
 t[11]:='2048';
 t[12]:='4096';
 for i:=0 to 11 do num[i]:=diemanh(dir+'num/'+t[i]+'.bmp',0,0);
 setcolor(15);
 cleardevice;

 fillchar(b,sizeof(b),3);
 repeat

  hienthi;
  UpdateGraph(2);
  UpdateGraph(0);

  c:=readkey;

   case c of
   #77 : right;
   #75 : left;
   #72 : up;
   #80 : down;
  end;

 until c=#27;
 closegraph;
end.
