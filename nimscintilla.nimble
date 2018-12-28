# Package

version       = "0.2.0"
author        = "genotrance"
description   = "Scintilla wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimgen >= 0.4.0"

var
  name = "nimscintilla"
  cmd = when defined(Windows): "cmd /c " else: ""

if fileExists(name & ".nimble"):
  mkDir(name)

task setup, "Checkout and generate":
  if gorgeEx(cmd & "nimgen").exitCode != 0:
    withDir(".."):
      exec "nimble install nimgen -y"
  exec cmd & "nimgen " & name & ".cfg"

before install:
  setupTask()

task test, "Test nimscintilla":
  exec "nim cpp -r tests/tscin.nim"

task testfull, "Test nimscintilla":
  exec "nim cpp -r tests/tscinfull.nim"

