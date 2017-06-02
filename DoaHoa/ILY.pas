var s : string; i,m: word; f: text;
begin
 Readln(s);
 assign(f,'decode.txt'); rewrite(f);
 for i:=1 to length(s) do
  begin
   m:=ord(s[i]);
   if (m mod 2 =0) then m:=m+1
   else m:=m+3;
   if m>255 then m:=m-255;
   s[i]:=char(m);
   WRite(f,s[i]);
  end;
 close(f);
end.
