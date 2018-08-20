import nimscintilla/[Scintilla, SciLexer]

if Scintilla_RegisterClasses(nil) == 0:
  echo "Failed to init"
  quit(1)

if Scintilla_ReleaseResources() == 0:
  echo "Failed to unload"
  quit(1)