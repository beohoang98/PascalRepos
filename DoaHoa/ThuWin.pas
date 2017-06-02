Program Thu_Win;

uses windows;

{$apptype gui}
{$mode objfpc}

var  Wc : Wndclass;
     Hwin : Handle;
     Msg : Tmsg;

function WinProc(win : handle; mes : UINT; wparam : WPARAM; Lparam: lparam)
         :LRESULT ; stdcall;
 begin
  WinProc:=0;
  case mes of
   WM_destroy : begin
                 PostQuitMessage(0);
                 exit;
                end;
   WM_Command :
    begin

    end
  else
   WinProc:= DefWindowProc(win, mes, wparam, lparam);
  end;
 end;

procedure DangKy;
 begin
    wc.style:= CS_HREDRAW OR CS_VREDRAW; // Thu?c t¡nh style l… HreDraw v… VreDraw t?c l… ReDraw theo chi?u d?c v… ngang
    wc.lpfnWndProc := @WinProc; // Tr? d?n h…m Call Back ch?u tr ch nhi?m x? ly message t? Windows
    wc.hinstance := hinstance; // Hinstance l… handle Instance
    wc.hCursor := LoadCursor(0, IDC_ARROW); // C…i d?t con tr? chu?t
    wc.hbrBackGround := GetStockObject(WHITE_BRUSH); // Ch?n m…u n?n form
    wc.lpszClassName := 'asdasd'; // Class Name
    {if RegisterClass(wc)=0 then  // RegisterClass(wc) dang ky l?p v?i windows, n?u ok tr? v? kh c 0
      begin
        Exception.Create('Cannot reg class'); // Th“ng b o n?u dang ky kh“ng th…nh c“ng
        exit; // Tho t sau khi th“ng b o
      end;}

 end;

begin
  hwin := CreateWindow('asdasd', 'Hello World', WS_OVERLAPPEDWINDOW, 100, 100, 600, 400, 0, 0, HINSTANCE, nil);
  if longint(hwin)=0 then halt(-1);
  { begin
    raise Exception.create('Cannot create Window');
    exit;
   end;}

  CreateWindow('button', 'OK', WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON, 100, 100, 80, 30, hwin, HMENU(100), HINSTANCE, nil);
  ShowWindow(hwin, SW_SHOW);
  UpdateWindow(hwin);
  while getMessage(msg, 0, 0, 0) do
    begin
     TranslateMessage(msg);
     DispatchMessage(msg);
    end;
  Halt(msg.wparam);

end.
