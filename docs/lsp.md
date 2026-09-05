# Language Server Protocol (LSP)

LSP support is provided by the optional
[`mruby-mrbmacs-lsp`](https://github.com/masahino/mruby-mrbmacs-lsp)
extension. The integration builds include it by default, but a language server
must also be installed and available on `PATH`.

Configure servers in `~/.mrbmacsrc` through `@config.ext['lsp']`:

```ruby
@config.ext['lsp'] = {
  'ruby' => {
    'command' => 'solargraph',
    'options' => { 'args' => ['stdio'] }
  },
  'cpp' => {
    'command' => 'clangd',
    'options' => {}
  }
}
```

The outer key is the mrbmacs mode name. A server starts when a file in that
mode is opened. User entries are merged with the extension's defaults;
matching mode names replace their default server entry.

| Field | Meaning |
| --- | --- |
| `command` | Language-server executable |
| `options` | Options passed to `LSP::Client`, including process arguments and initialization options |

Common supported operations include completion, hover, signature help, code
actions, navigation, formatting, and rename. Availability also depends on the
selected language server.

## Commands

The principal LSP commands are:

| Command | Purpose |
| --- | --- |
| `lsp-completion` | Request completion candidates |
| `lsp-hover` | Show hover information at point |
| `lsp-signature-help` | Request signature information |
| `lsp-declaration` | Go to a declaration |
| `lsp-definition` | Go to a definition |
| `lsp-type-definition` | Go to a type definition |
| `lsp-implementation` | Go to an implementation |
| `lsp-references` | Find references |
| `lsp-document-symbol` | List symbols in the current document |
| `lsp-workspace-symbols` | List symbols in the workspace |
| `lsp-code-action` | Select and execute a code action |
| `lsp-formatting` | Format the current document |
| `lsp-range-formatting` | Format the selected range |
| `lsp-rename` | Rename the symbol at point |
| `lsp-server-capabilities` | Write server capabilities to the logfile |
| `lsp-install-server` | Select and install a configured language server |

The default LSP keymap binds `M-.` to `lsp-definition`, `M-?` to
`lsp-references`, and `M-g i` to `lsp-document-symbol`. Run
`M-x describe-bindings` to inspect the effective bindings in the current mode.

## Code actions

`M-x lsp-code-action` requests actions for the selected region, or for the
cursor position when there is no selection. Returned actions are displayed as
a selectable list. Direct commands and the `edit` and `command` members of a
CodeAction are supported; when both members exist, the edit is applied before
the command is executed. Disabled actions are not executed.

Workspace edits using `changes` are supported. Workspace edits using
`documentChanges` are not currently supported.

Use `@config.ext`, not `@ext.config`, in `.mrbmacsrc`. `@ext.config` is the
extension's resolved internal state and is populated later during extension
registration.
