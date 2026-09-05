# Project operations

mrbmacs keeps one current project whose root directory is used by project
search and compilation commands.

## Selecting a project

Run `M-x open-project`, or press `C-x C-p`, and select an existing directory.
The selected directory becomes the project root. mrbmacs uses common build
files such as `Rakefile`, `Makefile`, and `build.sh` to choose an initial
compile command when possible.

## Searching a project

Run `M-x search-project` to perform a literal string search below the current
project root. The Scintilla word at the cursor is used as the initial query;
when there is no word at the cursor, the initial query is empty.

The search recursively reads regular text files. Binary or unreadable files,
symbolic-link directories, and directories named `.git`, `build`, `tmp`, or
`node_modules` are skipped.

Results are displayed in the read-only `*Project Search*` buffer. Its header
shows the number of matches and elapsed search time. Result paths are relative
to the project root. Press `Enter` on a result line to open that file at the
matched line in another editor window.

## Compiling

Run `M-x compile` to edit and execute a command in the project root. The most
recent command becomes the default for the next compilation. `M-x recompile`
repeats that command without prompting once one has been run.

Compilation output is displayed in the `*compilation*` buffer. Press `Enter`
on a recognized diagnostic line to open its file and line in another editor
window.

## Grep command

`M-x grep` prompts for a grep command and runs it in the current buffer's
directory. This differs from `search-project`: `grep` executes the command
entered by the user, while `search-project` performs a built-in literal search
from the project root. Press `Enter` on a recognized grep result to open its
file and line.
