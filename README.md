Nimscin is a [Nim](https://nim-lang.org/) wrapper for the [Scintilla](https://www.scintilla.org) library.

Nimscin is distributed as a [Nimble](https://github.com/nim-lang/nimble) package and depends on [nimgen](https://github.com/genotrance/nimgen) and [c2nim](https://github.com/nim-lang/c2nim/) to generate the wrappers. The Scintilla source code is downloaded using curl/powershell and extracted using unzip/powershell.

__Installation__

Nimscin is currently a work in progress. It can be installed via [Nimble](https://github.com/nim-lang/nimble):

```
> nimble install nimgen

> git clone https://github.com/genotrance/nimscin
> cd nimscin
> nimble install -y
```

This will download, wrap and install nimscin in the standard Nimble package location, typically ~/.nimble. Once installed, it can be imported into any Nim program.

__Usage__

```nim
import nimscin/[Scintilla, SciLexer]

if Scintilla_RegisterClasses(nil) == 0:
  echo "Failed to init"
  quit(1)

discard Scintilla_ReleaseResources()
```

__Credits__

Nimscin wraps the [Scintilla](https://www.scintilla.org) library and all its licensing terms apply to the usage of this package.

Credits go out to [c2nim](https://github.com/nim-lang/c2nim/) as well without which this package would be greatly limited in its abilities.

__Feedback__

Nimscin is a work in progress and any feedback or suggestions are welcome. It is hosted on [GitHub](https://github.com/genotrance/nimscin) with an MIT license so issues, forks and PRs are most appreciated.