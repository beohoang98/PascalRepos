//------------------------------------------------------------------------
//
// Author      : Maarten Kronberger
// Email       : sulacomcclaw@hotmail.com
// Website     : http://www.sulaco.co.za
// Date        : 30 October 2003
// Version     : 1.0
// Description : OpenGL Primitives
//
//------------------------------------------------------------------------
//
// Virtual Pascal 2.1 adaptation by Roland Chastain (2013)
//
//------------------------------------------------------------------------
program OpenGLApp;
{$PMTYPE PM}

uses
  Windows, GLu, gl;

//{$R GLicon} // GLicon.res is included in VP package

const
  DRAW_POINTS = 1;
  DRAW_LINES = 2;
  DRAW_LINE_STRIP = 3;
  DRAW_LINE_LOOP = 4;
  DRAW_POLYGON = 5;
  DRAW_QUADS = 6;
  DRAW_QUAD_STRIP = 7;
  DRAW_TRIANGLES = 8;
  DRAW_TRIANGLE_STRIP = 9;
  DRAW_TRIANGLE_FAN = 10;

  StateDescriptions : array[1..10]of string = (
    'Points',
    'Lines',
    'Line Strip',
    'Line Loop',
    'Polygon',
    'Quads',
    'Quad Strip',
    'Triangles',
    'Triangle Strip',
    'Triangle Fan'
  );

var
  h_Wnd: HWND;
  h_DC : HDC;
  h_RC : HGLRC;
  keys : array[0..255] of Boolean;
  CurrentDrawState: GLInt = 1;

{
procedure DrawPoints;
begin
  glBegin(GL_POINTS);
  glVertex2f(-1.0,  1.0);
  glVertex2f( 1.0,  0.5);
  glVertex2f( 5.0, 10.0);
  glVertex2f( 3.0, -4.0);
  glVertex2f(-8.0, -5.0);
  glEnd;
end;
}

procedure DrawPoints;
var
  x, y: GLfloat;
begin
  glBegin(GL_POINTS);


  glEnd;
end;

procedure DrawLines;
begin
  glBegin(GL_LINES);
  glVertex2f(-1.0,  1.0);
  glVertex2f( 1.0,  0.5);
  glVertex2f( 5.0, 10.0);
  glVertex2f( 3.0, -4.0);
  glVertex2f(-8.0, -5.0);
  glVertex2f( 9.0, -5.0);
  glEnd;
end;

procedure DrawLineStrip;
begin
  glBegin(GL_LINE_STRIP);
  glVertex2f(-1.0,  1.0);
  glVertex2f( 1.0,  0.5);
  glVertex2f( 5.0, 10.0);
  glVertex2f( 3.0, -4.0);
  glVertex2f(-8.0, -5.0);
  glVertex2f( 9.0, -5.0);
  glVertex2f(19.0, -9.0);
  glEnd;
end;

procedure DrawLineLoop;
begin
  glBegin(GL_LINE_LOOP);
  glVertex2f( -1.0,  1.0);
  glVertex2f(  1.0,  0.5);
  glVertex2f(  5.0, 10.0);
  glVertex2f(  3.0, -4.0);
  glVertex2f( -8.0, -5.0);
  glVertex2f(  9.0, -5.0);
  glVertex2f(-19.0, -9.0);
  glEnd;
end;

procedure DrawPolygon;
begin
  glBegin(GL_POLYGON);
  glVertex2f(-10.0,-10.0);
  glVertex2f( 10.0,-10.0);
  glVertex2f( 10.0, 10.0);
  glVertex2f(  0.0, 20.0);
  glVertex2f(-10.0, 10.0);
  glEnd;
end;

procedure DrawQuad;
begin
  glBegin(GL_QUADS);
  glVertex2f(-10.0,-10.0);
  glVertex2f( 10.0,-10.0);
  glVertex2f( 10.0, 10.0);
  glVertex2f(-10.0, 10.0);
  glVertex2f(-40.0,-30.0);
  glVertex2f(  0.0,-30.0);
  glVertex2f(  0.0,-15.0);
  glVertex2f(-40.0,-15.0);
  glEnd;
end;

procedure DrawQuadStrip;
begin
  glBegin(GL_QUAD_STRIP);
  glColor3f(1.0, 0.0, 0.0);
  glVertex2f(-10.0,-10.0);
  glVertex2f(-10.0, 10.0);
  glVertex2f( 10.0,-10.0);
  glVertex2f( 10.0, 10.0);
  glColor3f(0.0, 1.0, 0.0);
  glVertex2f( 20.0,-10.0);
  glVertex2f( 20.0, 10.0);
  glColor3f(0.0, 0.0, 1.0);
  glVertex2f( 30.0,-12.0);
  glVertex2f( 30.0, 12.0);
  glEnd;
end;

procedure DrawTriangles;
begin
  glBegin(GL_TRIANGLES);
  glVertex2f(-10.0,-10.0);
  glVertex2f( 10.0,-10.0);
  glVertex2f(  0.0, 10.0);
  glVertex2f(-40.0,-20.0);
  glVertex2f(  0.0,-20.0);
  glVertex2f(-40.0, 10.0);
  glEnd;
end;

procedure DrawTriangleStrip;
begin
  glBegin(GL_TRIANGLE_STRIP);
  glColor3f(1.0, 0.0, 0.0);
  glVertex2f(-10.0,-10.0);
  glVertex2f( 10.0,-10.0);
  glVertex2f(  0.0, 10.0);
  glColor3f(0.0, 1.0, 0.0);
  glVertex2f( 20.0, -5.0);
  glColor3f(0.0, 0.0, 1.0);
  glVertex2f( 20.0, 30.0);
  glEnd;
end;

procedure DrawTriangleFan;
var
  CirclePoints, i: GLint;
  Angle: GLfloat;
begin
  CirclePoints := 10;
  glBegin(GL_TRIANGLE_FAN);
  for i := 0 to CirclePoints-1 do
  begin
    Angle := 2 * PI * i / CirclePoints;
    glVertex2f(Cos(angle) * 20, Sin(angle) * 20);
  end;
  glEnd;
end;

procedure glDraw;
begin
  SetWindowText(h_Wnd, @StateDescriptions[CurrentDrawState][1]);
  glClearColor(0.0, 0.0, 0.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glLoadIdentity;
  glColor3f(0.0, 0.0, 1.0);
  case CurrentDrawState of
    DRAW_POINTS: DrawPoints;
    DRAW_LINES: DrawLines;
    DRAW_LINE_STRIP: DrawLineStrip;
    DRAW_LINE_LOOP : DrawLineLoop;
    DRAW_POLYGON: DrawPolygon;
    DRAW_QUADS : DrawQuad;
    DRAW_QUAD_STRIP : DrawQuadStrip;
    DRAW_TRIANGLES: DrawTriangles;
    DRAW_TRIANGLE_STRIP: DrawTriangleStrip;
    DRAW_TRIANGLE_FAN: DrawTriangleFan;
  end;
  glFlush;
end;

procedure glInit;
begin
  glClearColor(0.0, 0.0, 0.0, 1.0);
  glColor4f(1.0, 1.0, 1.0, 0.5);
  glShadeModel(GL_FLAT);
  glEnable(GL_DEPTH_TEST);
  glPointSize(2.0);
  glLineWidth(2.0);
end;

procedure glResizeWnd(w, h: Integer);
var
  a, b: GLdouble;
begin
  glViewport(0, 0, w, h);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  if w <= h then
  begin
    a := 1.0;
    b := h / w;
  end else
  begin
    a := w / h;
    b := 1.0;
  end;
  glOrtho (-50.0 * a, +50.0 * a, -50.0 * b, +50.0 * b, -1.0, +1.0);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;

procedure ProcessKeys;
begin
  if keys[VK_SPACE] then
  begin
    CurrentDrawState := CurrentDrawState + 1;
    if CurrentDrawState > 10 then
      CurrentDrawState := 1;
    keys[VK_SPACE] := FALSE;
  end;
end;

function WndProc(hWnd: HWND; Msg: UINT;  wParam: WPARAM;  lParam: LPARAM): LRESULT; stdcall;
var result : Lresult;
begin
  case Msg of
    WM_CLOSE:
      begin
        PostQuitMessage(0);
        result:=0
      end;
    WM_KEYDOWN:
      begin
        keys[wParam] := True;
        result :=0;
      end;
    WM_KEYUP:
      begin
        keys[wParam] := False;
        result:=0;
      end;
    WM_SIZE:
      begin
        glResizeWnd(LOWORD(lParam), HIWORD(lParam));
        Result := 0;
      end;
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam);
  end;
  exit(result);
end;

procedure glKillWnd;
begin
  wglMakeCurrent(h_DC, 0);
  wglDeleteContext(h_RC);
  h_RC := 0;
  ReleaseDC(h_Wnd, h_DC);
  DestroyWindow(h_Wnd);
  UnRegisterClass('OpenGL', hInstance);
end;

function glCreateWnd(Width, Height: Integer): Boolean;
var
  wndClass : TWndClass;
  PixelFormat : GLuint;
  h_Instance : HINST;
  pfd : TPIXELFORMATDESCRIPTOR;
  result : boolean;

begin
  h_Instance := GetModuleHandle(nil);
  ZeroMemory(@wndClass, SizeOf(wndClass));
  with wndClass do
  begin
    style := CS_HREDRAW or CS_VREDRAW or CS_OWNDC;
    lpfnWndProc := @WndProc;
    hInstance := h_Instance;
    hIcon := LoadIcon(hInstance, 'MainIcon');
    hCursor := LoadCursor(0, IDC_ARROW);
    lpszClassName := 'OpenGL';
  end;
  RegisterClass(wndClass);

  h_Wnd := CreateWindowEx(
    WS_EX_APPWINDOW or WS_EX_WINDOWEDGE,
    'OpenGL',
    '',
    WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN or WS_CLIPSIBLINGS,
    0,
    0,
    Width,
    Height,
    0,
    0,
    h_Instance,
    nil
  );

  h_DC := GetDC(h_Wnd);

  with pfd do
  begin
    nSize:= SizeOf(TPIXELFORMATDESCRIPTOR);
    nVersion := 1;
    dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
    iPixelType := PFD_TYPE_RGBA;
    cColorBits := 32;
    cRedBits := 0;
    cRedShift := 0;
    cGreenBits := 0;
    cGreenShift := 0;
    cBlueBits := 0;
    cBlueShift := 0;
    cAlphaBits := 0;
    cAlphaShift := 0;
    cAccumBits := 0;
    cAccumRedBits := 0;
    cAccumGreenBits := 0;
    cAccumBlueBits := 0;
    cAccumAlphaBits := 0;
    cDepthBits := 16;
    cStencilBits := 0;
    cAuxBuffers := 0;
    iLayerType := PFD_MAIN_PLANE;
    bReserved := 0;
    dwLayerMask := 0;
    dwVisibleMask := 0;
    dwDamageMask := 0;
  end;
  PixelFormat := ChoosePixelFormat(h_DC, @pfd);
  SetPixelFormat(h_DC, PixelFormat, @pfd);
  h_RC := wglCreateContext(h_DC);
  wglMakeCurrent(h_DC, h_RC);
  ShowWindow(h_Wnd, SW_SHOW);
  SetForegroundWindow(h_Wnd);
  SetFocus(h_Wnd);
  glResizeWnd(Width, Height);
  glInit;
  Result := True;
end;

function WinMain(hInstance : HINST; hPrevInstance : HINST;
  lpCmdLine : PChar; nCmdShow : Integer) : Integer; stdcall;
var
  msg : tMsg;
  finished : Boolean;
  result : integer;
begin
  finished := False;
  if not glCreateWnd(800, 600) then
  begin
    Result := 0;
    Exit;
  end;
  while not finished do
  begin
    if PeekMessage(msg, 0, 0, 0, PM_REMOVE) then
    begin
      if msg.message = WM_QUIT then
        finished := True
      else
      begin
        TranslateMessage(msg);
        DispatchMessage(msg);
      end;
    end
    else
    begin
      glDraw;
      SwapBuffers(h_DC);
      if (keys[VK_ESCAPE]) then
        finished := True
      else
        ProcessKeys;
    end;
  end;
  glKillWnd;
  Result := msg.wParam;
end;

begin
  WinMain(hInstance, hPrevInst, CmdLine, CmdShow);
end.
