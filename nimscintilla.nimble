# Package

version       = "0.1.0"
author        = "genotrance"
description   = "Scintilla wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimgen >= 0.4.0"

import distros

var cmd = ""
if detectOs(Windows):
  cmd = "cmd /c "

task setup, "Download and generate":
  exec cmd & "nimgen nimscintilla.cfg"

before install:
  setupTask()

task test, "Test nimscintilla":
  exec "nim cpp -r tests/tscin.nim"

task testfull, "Test nimscintilla":
  exec "nim cpp -r tests/tscinfull.nim"
