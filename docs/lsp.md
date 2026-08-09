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

Common supported operations include completion, hover, signature help, go to
declaration or definition, formatting, and rename. Availability also depends
on the selected language server.

Use `@config.ext`, not `@ext.config`, in `.mrbmacsrc`. `@ext.config` is the
extension's resolved internal state and is populated later during extension
registration.
