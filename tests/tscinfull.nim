const
  WS_OVERLAPPED* = 0x00000000
  WS_CAPTION* = 0x00C00000
  WS_SYSMENU* = 0x00080000
  WS_THICKFRAME* = 0x00040000
  WS_MINIMIZEBOX* = 0x00020000
  WS_MAXIMIZEBOX* = 0x00010000
  WS_OVERLAPPEDWINDOW* = WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_THICKFRAME or WS_MINIMIZEBOX or WS_MAXIMIZEBOX
  WM_QUIT* = 0x0012
  SW_SHOW* = 5

type
  HANDLE* = int
  HWND* = HANDLE
  HINSTANCE* = HANDLE
  HMENU* = HANDLE
  LPVOID* = pointer
  WINBOOL* = int32
  HMODULE* = HINSTANCE
  DWORD* = int32
  uint_PTR* = int64
  LONG_PTR* = int64
  WPARAM* = uint_PTR
  LPARAM* = LONG_PTR
  WCHAR* = uint16
  LPCWSTR* = ptr WCHAR
  LRESULT* = LONG_PTR
  LPCSTR* = cstring

  POINT* {.pure.} = object
    x*: clong
    y*: clong

  MSG* {.pure.} = object
    hwnd*: HWND
    message*: uint
    wParam*: WPARAM
    lParam*: LPARAM
    time*: DWORD
    pt*: POINT

  LPMSG* = ptr MSG

proc GetModuleHandleW*(lpModuleName: LPCWSTR): HMODULE {.stdcall, dynlib: "kernel32", importc.}

proc GetLastError*(): DWORD {.stdcall, dynlib: "kernel32", importc.}

proc CreateWindowExW*(dwExStyle: DWORD, lpClassName: LPCWSTR, lpWindowName: LPCWSTR, dwStyle: DWORD,
  X: int32, Y: int32, nWidth: int32, nHeight: int32, hWndParent: HWND, hMenu: HMENU,
  hInstance: HINSTANCE, lpParam: LPVOID): HWND {.stdcall, dynlib: "user32", importc.}

proc CreateWindowExA*(dwExStyle: DWORD, lpClassName: LPCSTR, lpWindowName: LPCSTR, dwStyle: DWORD, X: int32, Y: int32, nWidth: int32,
  nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.stdcall, dynlib: "user32", importc.}

proc CreateWindow*(lpClassName: LPCSTR, lpWindowName: LPCSTR, dwStyle: DWORD, x: int32, y: int32, nWidth: int32,
  nHeight: int32, hWndParent: HWND, hMenu: HMENU, hInstance: HINSTANCE, lpParam: LPVOID): HWND {.inline.} =
  CreateWindowExA(0, lpClassName, lpWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam)

proc IsWindow*(hWnd: HWND): WINBOOL {.stdcall, dynlib: "user32", importc.}

proc ShowWindow*(hWnd: HWND, nCmdShow: int32): WINBOOL {.stdcall, dynlib: "user32", importc.}

proc UpdateWindow*(hWnd: HWND): WINBOOL {.stdcall, dynlib: "user32", importc.}

proc GetMessageW*(lpMsg: LPMSG, hWnd: HWND, wMsgFilterMin: uint, wMsgFilterMax: uint): WINBOOL {.stdcall, dynlib: "user32", importc.}

proc TranslateMessage*(lpMsg: ptr MSG): WINBOOL {.stdcall, dynlib: "user32", importc.}

proc DispatchMessageW*(lpMsg: ptr MSG): LRESULT {.stdcall, dynlib: "user32", importc.}

import nimscintilla/[Scintilla, SciLexer]

if Scintilla_RegisterClasses(nil) == 0:
  echo "Failed to init"
  quit(1)

var
  msg: MSG
  window = CreateWindow("Scintilla".LPCSTR, "".LPCSTR, WS_OVERLAPPEDWINDOW, 10, 10, 500, 400, 0, 0, GetModuleHandleW(nil), nil)

if IsWindow(window) == 0:
  echo GetLastError()
  quit(1)

echo window.ShowWindow(SW_SHOW)
echo window.UpdateWindow()

while GetMessageW(cast[LPMSG](addr msg), 0, 0, 0) != 0:
  discard TranslateMessage(addr msg)
  if msg.message == WM_QUIT:
    break
  discard DispatchMessageW(addr msg)

echo Scintilla_ReleaseResources()