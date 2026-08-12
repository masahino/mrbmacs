# Editor margins

mrbmacs uses Scintilla margins to keep independent indicators from obscuring
one another. From left to right, the shared layout is:

```text
[Line numbers and debugger] [Version control] [Change history] [Folding] [Text]
```

| Margin | Purpose |
| ---: | --- |
| 0 | Line numbers, DAP breakpoints, and the current debugger position |
| 1 | Version-control indicators |
| 2 | Scintilla change-history indicators |
| 3 | Code-folding controls |

Widths are derived from the current font where the frontend supports pixel
measurements. Terminal frontends may represent margins with character-cell
widths.

## Debugger indicators

Clicking a sensitive line-number margin can toggle a DAP breakpoint when the
DAP extension is present. Breakpoints and the current debugger position share
the line-number margin, but use separate marker shapes and theme colors.

## Version-control indicators

The version-control margin displays added, modified, and deleted positions
relative to `HEAD`. See [Version control](version-control.md) for indicator
meanings and refresh behavior.

## Change history

Scintilla records whether lines have been modified, saved, or reverted during
the current editing session. These markers have a dedicated margin so they do
not compete with debugger markers in the line-number margin or with Git state
in the version-control margin.

Change history and version control answer different questions:

- change history describes edits during the current editor session;
- version control compares the working-tree file with Git `HEAD`.
