var i,n,l,r ,k: integer;
    a : array[1..100] of integer;

begin
 write('nhap n: ');readln(n);
 for i:=1 to n do
  begin
   write('nhap a[',i,'] : ');
   readln(a[i]);
  end;

 l:=1; r:=n;
 while l<r do
  begin
   while a[l] mod 2 =0 do l:=l+1;
   while a[r] mod 2 =1 do r:=r-1;
   if  l< r then
    begin
    k:=a[l];
    a[l]:=a[r];
    a[r]:=k;
    l:=l+1;r:=r-1;
    end;
  end;
 for i:=1 to n do write(a[i],', ');
 readln;
end.