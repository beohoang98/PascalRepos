const fi='etf.inp';
      fo='etf.out';
var     n : array[1..1000000] of longint;
        i,a : longint;

function ngto(n: longint):boolean;
 var i: longint;
 begin
  if n<2 then exit(false);
  for i:=2 to trunc(sqrt(n)) do
   if n mod i = 0 then exit(false);
  exit(true);
 end;

function ole(n: longint): longint;
 var  s: double;i: longint;
 begin
  if n=1 then exit(1);
  s:=n;
  for i:=2 to n do
   if n mod i=0 then if ngto(i) then
        begin
         s:=s*(1-(1/i));

        end;

  exit(trunc(s));
 end;

begin
  assign(input,fi); reset(input);
  assign(output,fo); rewrite(output);
  readln(a);

  for i:=1 to a do readln(n[i]);

  for i:=1 to a do writeln(ole(n[i]));

  close(input);
  close(output);
end.