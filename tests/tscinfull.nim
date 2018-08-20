const
  WS_VISIBLE* = 0x10000000
  WS_TABSTOP* = 0x00010000
  WS_CLIPCHILDREN* = 0x02000000

  SW_SHOW* = 5

type
  MSG* = object

proc GetModuleHandleW*(lpModuleName: WideCString): pointer {.stdcall, dynlib: "kernel32", importc.}

proc GetLastError*(): int {.stdcall, dynlib: "kernel32", importc.}

proc CreateWindowExW*(dwExStyle: int32, lpClassName: WideCString,
  lpWindowName: WideCString, dwStyle: int32, X: int32, Y: int32,
  nWidth: int32, nHeight: int32, hWndParent: int, hMenu: int,
  hInstance: pointer, lpParam: pointer): pointer {.stdcall, dynlib: "user32", importc.}

proc IsWindow*(hWnd: pointer): bool {.stdcall, dynlib: "user32", importc.}

proc ShowWindow*(hWnd: pointer, nCmdShow: int): int {.stdcall, dynlib: "user32", importc.}

proc UpdateWindow*(hWnd: pointer): int {.stdcall, dynlib: "user32", importc.}

proc GetMessageW*(lpMsg: pointer, hWnd: pointer, wMsgFilterMin: uint, wMsgFilterMax: uint): int {.stdcall, dynlib: "user32", importc.}

proc TranslateMessage*(lpMsg: pointer): int {.stdcall, dynlib: "user32", importc.}

proc DispatchMessageW*(lpMsg: pointer): pointer {.stdcall, dynlib: "user32", importc.}

import nimscin/[Scintilla, SciLexer]

if Scintilla_RegisterClasses(nil) == 0:
  echo "Failed to init"
  quit(1)

var
  msg: MSG
  window = CreateWindowExW(0, newWideCString("Scintilla"), newWideCString(""), WS_VISIBLE or WS_TABSTOP or WS_CLIPCHILDREN, 10, 10, 500, 400, 0, 0, GetModuleHandleW(nil), nil)

if not IsWindow(window):
  echo GetLastError()
  quit(1)

echo window.ShowWindow(SW_SHOW)
echo window.UpdateWindow()

while GetMessageW(addr msg, nil, 0, 0) != 0:
  echo TranslateMessage(addr msg)
  discard DispatchMessageW(addr msg)

echo Scintilla_ReleaseResources()