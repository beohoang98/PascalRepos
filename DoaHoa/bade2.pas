{$G+}

uses crt,graph,dos;
const
numstar=200;
type
star = record
x,y,z:integer;
end;
var
a,b,i,x,y:integer;
W:Word;
p:pointer;
m:array[1..numstar] of star;


procedure pixel(x,y:integer;c:byte);
 begin
  asm
  mov ax,w
  mov es,ax
  mov bx,y
  mov dx,y
  shl bx,8
  shl dx,6
  add bx,dx
  mov dx,x
  add bx,dx
  mov al,c
  mov di,bx
  stosb

 end;
 end;



procedure cls;assembler;
 asm
  push es
  mov ax,w
  mov es,ax
  xor di,di
  xor ax,ax
  mov cx,32000
  rep stosw
  pop es
 end;

procedure screen;assembler;
asm
push ds
mov ax,$A000
mov es,ax
mov ax,w
mov ds,ax
xor di,di
xor si,si
mov cx,32000
rep movsw
pop ds
end;

begin

 GetMem(p,64000);
 W:=Seg(p^);
 asm
  mov ah,$00
  mov al,$13
  int $10
 end;

 for i:=1 to numstar do
 begin
  m[i].x:=random(400)-200;
  m[i].y:=random(400)-200;
  m[i].z:=random(400);
  x:=round(160+m[i].x*500/(500-m[i].z));
  y:=round(100+m[i].y*500/(500-m[i].z));
  pixel(x,y,15);
 end;
 repeat
 cls;
 for i:=1 to numstar do
 begin
  m[i].z:=m[i].z+2;
  x:=round(160+m[i].x*500/(500-m[i].z));
  y:=round(100+m[i].y*500/(500-m[i].z));
  if (x>0)and(x<320)and(y>0)and(y<200) then
  pixel(x,y,m[i].z div 8)
  else begin ;
  m[i].x:=random(200)-100;
  m[i].y:=random(200)-100;
  m[i].z:=random(200);
 end;
 end;
 screen;
 delay(10) ;
 until keypressed;
 FreeMem(p,64000);
end.
