Unit HamCoSan;

Interface
 Procedure Swap(var a, b : integer); overload;
 Procedure Swap(var a, b : longint); overload;
 Procedure Swap(var a, b : real); overload;
 Procedure Swap(var a, b : string); overload;
 Procedure Swap(var a, b : char);

 Function Min(a, b : longint): Longint; overload;
 Function Min(a, b : real): real; overload;
 Function Min(n : longword; a : array of longint): longint; overload;
 Function Min(n : longword; a : array of real): real;

 Procedure Sapxep(n : word;var a : array of integer); overload;
 Procedure Sapxep(n : word;var a : array of longint); overload;
 Procedure Sapxep(n : word;var a : array of real);


Implementation
 Uses crt, wincrt, rgba, winmouse;

 Procedure Swap(var a,b : integer);
  Var t : integer;
  Begin
   t:=a; a:=b; b:=t;
  End;
 Procedure Swap(var a,b : longint);
  Var t : longint;
  Begin
   t:=a; a:=b; b:=t;
  End;
 Procedure Swap(var a,b : real);
  Var t: real;
  Begin
   t:=a; a:=b; b:=t;
  End;
 Procedure Swap(var a,b : string);
  Var t : string;
  Begin
   t:=a; a:=b; b:=t;
  End;
 Procedure Swap(var a,b : char);
  Var t : char;
  Begin
   t:=a; a:=b; b:=t;
  End;

 Function Min(a,b : longint): longint;
  Begin
   if (a<b) then exit(a);
   exit(b);
  End;
 Function Min(a, b :real): real;
  Begin
   If (a<b) then exit(a);
   Exit(b);
  End;
 Function Min(n : longword; a : array of longint): longint;
  var i : longword;
  Begin
   Min:=a[0];
   for i:=1 to n-1 do
    if (a[i]<min) then Min:=a[i];
  End;
 Function Min(n : longword; a : array of real): real;
  var i : longword;
  Begin
   Min:=a[0];
   for i:=1 to n-1 do
    if (a[i]<min) then Min:=a[i];
  End;

 Procedure Sapxep(n : word; var a: array of integer);
  Procedure Qsort(l, r : word);
   var i, j : integer;  x: integer;
   Begin
    i:=l; j:=r;
    x:=a[(l+r) div 2];
    Repeat
     While x<a[i] do inc(i);
     While x>a[j] do dec(j);
     If Not(i>j) then
      Begin
       Swap(a[i],a[j]);
       inc(i);
       dec(j);
      end;
    Until (i>j);
    If (l<j) then Qsort(l,j);
    If (i<r) then Qsort(i,r);
   End;
 Begin
  Qsort(0, n-1);
 End;
 Procedure Sapxep(n : word; var a: array of longint);
  Procedure Qsort(l, r : word);
   var i, j : integer;  x: longint;
   Begin
    i:=l; j:=r;
    x:=a[(l+r) div 2];
    Repeat
     While x<a[i] do inc(i);
     While x>a[j] do dec(j);
     If Not(i>j) then
      Begin
       Swap(a[i],a[j]);
       inc(i);
       dec(j);
      end;
    Until (i>j);
    If (l<j) then Qsort(l,j);
    If (i<r) then Qsort(i,r);
   End;
 Begin
  Qsort(0, n-1);
 End;
 Procedure Sapxep(n : word; var a: array of real);
  Procedure Qsort(l, r : word);
   var i, j : integer;  x: real;
   Begin
    i:=l; j:=r;
    x:=a[(l+r) div 2];
    Repeat
     While x<a[i] do inc(i);
     While x>a[j] do dec(j);
     If Not(i>j) then
      Begin
       Swap(a[i],a[j]);
       inc(i);
       dec(j);
      end;
    Until (i>j);
    If (l<j) then Qsort(l,j);
    If (i<r) then Qsort(i,r);
   End;
 Begin
  Qsort(0, n-1);
 End;

End.
