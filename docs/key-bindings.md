# Key bindings

Run `M-x describe-bindings` to display the key bindings that are currently
available. The bindings are shown in the read-only `*Bindings*` buffer.

The list combines the global keymap with the current mode's keymap. When both
keymaps bind the same key, the current mode's binding is shown. Prefix-only
entries are omitted.

Scintilla commands are displayed by constant name, such as `SCI_LINEUP`, when
the name is available.

Run `M-x list-commands` to display every editor command available in the
current build. The read-only `*Commands*` buffer shows each command's
description and, when present, its effective key bindings. Commands with an
external API handler are marked with `[API]`; commands without registered
descriptions are marked with `(no description)`.
