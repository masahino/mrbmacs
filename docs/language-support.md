# Language support

mrbmacs selects a language mode from the file extension or filename and uses
that mode for syntax highlighting, editing behavior, and optional integrations
such as LSP.

| Language or format | Files | Syntax highlighting | Notes |
| --- | --- | --- | --- |
| Bash | `.sh` | Supported | |
| C and C++ | `.c`, `.h`, `.cpp`, `.cxx` | Supported | |
| CSS | `.css` | Supported | |
| Diff | `.diff` | Supported | `.patch` is not detected yet. |
| Go | `.go` | Supported | |
| Haskell | `.hs` | Supported | |
| HTML and ERB | `.html`, `.htm`, `.erb` | Supported | |
| Java | `.java` | Supported | |
| JavaScript | `.js` | Supported | JSX is not detected yet. |
| JSON | `.json` | Supported | JSONC and JSON5 are not detected yet. |
| LaTeX | `.tex` | Supported | |
| Lisp | `.lisp` | Supported | |
| Lua | `.lua` | Supported | |
| Makefile | `Makefile`, `makefile` | Supported | Detected by filename. |
| Markdown | `.md` | Supported | |
| Objective-C | `.m`, `.mm` | Supported | `.m` is treated as Objective-C. |
| Perl | `.pl` | Supported | |
| Plain text | `.txt`, unmatched files | Supported | Used as the fallback mode. |
| POV-Ray | `.pov` | Supported | |
| Python | `.py` | Supported | |
| R | `.r` | Supported | |
| Ruby | `.rb`, `.rake`, `Rakefile`, `init.rb`, `.mrbmacs`, `.mrbmacsrc` | Supported | Includes current and legacy mrbmacs startup filenames. |
| Rust | `.rs` | Supported | |
| TypeScript | `.ts` | Supported | TSX is not detected yet. |
| XML | `.xml`, `.plist` | Supported | |
| YAML | `.yml`, `.yaml` | Supported | |

Syntax highlighting support does not install language servers, compilers, or
formatters. See [Language Server Protocol](lsp.md) for LSP configuration.

Implementation details, including the corresponding modes, `LexerProfile`
objects, shared Lexilla lexers, and the Lexilla version inventory, are
documented in
[`mruby-mrbmacs-base/docs/lexer-support.md`](https://github.com/masahino/mruby-mrbmacs-base/blob/master/docs/lexer-support.md).
