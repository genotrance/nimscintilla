import os, osproc, sequtils, strformat, strutils, tables

proc buildSciTable*(): Table[string, int] =
  result = initTable[string, int]()

  let
    scifile = "nimscintilla"/"Scintilla.nim"
    scilexfile = "nimscintilla"/"SciLexer.nim"

  if not scifile.fileExists() and not scilexfile.fileExists():
    raise newException(Exception, "Failed to find nimscintilla nim files")

  let
    data = scifile.readFile().splitLines().concat(
      scilexfile.readFile().splitLines())

  for line in data:
    let
      spl = line.split(" = ", 1)

    if spl.len == 2:
      let
        name = spl[0].strip(chars={' ', '*'})
        val = spl[1].strip()

      try:
        result[name] = parseInt(val)
      except:
        discard

proc writeSciTable*() =
  var
    output = "import tables\n\nconst SciVars* = {\n"

  for key, val in buildSciTable().pairs():
    output &= &"  \"{key}\": {$val},\n"

  output &= "}.toTable()"

  writeFile("nimscintilla"/"Scitable.nim", output)

when isMainModule:
  writeSciTable()