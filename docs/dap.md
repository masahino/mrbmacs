# Debug Adapter Protocol (DAP)

DAP support is provided by the optional
[`mruby-mrbmacs-dap`](https://github.com/masahino/mruby-mrbmacs-dap)
extension. A compatible debug adapter must be installed separately.

Configure adapters in `~/.mrbmacsrc` through `@config.ext['dap']`. DAP adapter
fields use symbol keys:

```ruby
@config.ext['dap'] = {
  'ruby-local' => {
    command: 'rdbg',
    args: ['-O', '--sock-path=/tmp/mrbmacs-rdbg'],
    type: 'rdbg',
    langs: ['ruby'],
    sock_path: '/tmp/mrbmacs-rdbg',
    require_target: true
  }
}
```

| Field | Meaning |
| --- | --- |
| `command` | Debug-adapter executable |
| `args` | Command-line arguments |
| `type` | Adapter type sent during DAP initialization |
| `langs` | mrbmacs modes in which this adapter is available |
| `port` | Optional TCP port used by the adapter |
| `sock_path` | Optional Unix socket path |
| `require_target` | Whether a target program must be selected before starting |

User adapters are merged with the built-in adapter table. A user entry with
the same name replaces that built-in entry.

The line-number margin displays breakpoints and the current debugger position.
The default DAP keymap binds `C-x SPC` to toggle a breakpoint. See
[Editor margins](margins.md) for the complete margin layout.
