# Version Control

mrbmacs provides basic integration with version control systems. Git is
currently supported.

## Gutter indicators

The version-control gutter appears between the line-number and change-history
margins:

```text
[Line numbers and debugger] [VC] [Change history] [Folding] [Text]
```

See [Editor margins](margins.md) for the responsibilities of all four margins.

| Indicator | Meaning |
| --- | --- |
| Green | Added lines |
| Yellow | Modified lines |
| Red | Deleted lines |

Deleted lines no longer exist in the current buffer, so their marker is
displayed at the nearest remaining line.

## Comparison base

The gutter compares the current working-tree file with `HEAD`. Both staged and
unstaged changes are included.

## Refreshing the gutter

The gutter is refreshed automatically:

- after opening a file;
- after saving a file.

## Viewing a diff

To display the diff for the current file:

```text
M-x vc-diff
```

The result is displayed in a diff buffer.

## Modeline

For files managed by Git, the modeline displays the current branch:

```text
Git:main
```

A detached `HEAD` is displayed using its abbreviated revision.

## Limitations

- Only Git is currently supported.
- Untracked files do not currently produce gutter indicators.
- The gutter is based on `HEAD`; separate staged and unstaged states are not
  distinguished.
- External file modifications are reflected after the file is reopened or
  saved.
