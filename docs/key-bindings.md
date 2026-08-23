# Key bindings

Run `M-x describe-bindings` to display the key bindings that are currently
available. The bindings are shown in the read-only `*Bindings*` buffer.

The list combines the global keymap with the current mode's keymap. When both
keymaps bind the same key, the current mode's binding is shown. Prefix-only
entries are omitted.

Scintilla commands are displayed by constant name, such as `SCI_LINEUP`, when
the name is available.
