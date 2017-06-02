{$MODE OBJFPC}

uses math;

var f: array[1..20,1..(1 shl 21)] of boolean;
    a: array[1..20,1..20] of boolean;
    b, trace: array[1..20] of longint;
    n, m, T, iT, iTest, err: longint;
    path: string;

procedure Init;
var i, j, u, v: longint;
begin
  readln(n, m);
  fillchar(a, sizeof(a), false);
  for i:=1 to m do
    begin
      readln(u, v);
      a[u, v]:=true;
      a[v, u]:=true;
    end;
end;

procedure find(u, d: longint);
var v, i, count: longint;
begin
  if f[u, d] then exit;
  f[u, d]:=true;
  if u = n then
    begin
      count:=1;
      b[count]:=n;
      while b[count] > 1 do
        begin
          inc(count);
          b[count]:=trace[b[count-1]];
        end;
      if (count = n) then
        begin
          for i:=n downto 1 do write(b[i],' ');
          count:=0;
          i:=1 div count;
        end;
    end;

  for v:=1 to n do
    if (d and (1 shl (v-1)) = 0) and a[u,v] then
      begin
        trace[v]:=u;
        find(v, d or (1 shl (v-1)));
      end;
end;

function num2str(i: integer): string;
begin
  exit(chr(i div 100 + 48)+chr((i mod 100) div 10 + 48)+chr(i mod 10 + 48));
end;

begin
      Init;
      fillchar(f, sizeof(f), false);
      err:=0;
      try
        find(1, 1);
      except
        err:=1;
      end;

      if err = 0 then writeln(-1);

      close(input); close(output);
end.
