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
var ldpath = ""
var ext = ""
if detectOs(Windows):
    cmd = "cmd /c "
    ext = ".exe"

task setup, "Download and generate":
    exec cmd & "nimgen nimscin.cfg"

before install:
    setupTask()

task test, "Test nimscin":
    exec "nim cpp -r tests/tscin.nim"

task testfull, "Test nimscin":
    exec "nim cpp -r tests/tscinfull.nim"