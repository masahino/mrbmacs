# Startup configuration

mrbmacs uses the XDG Base Directory convention for its startup file. The
standard location is:

```text
~/.config/mrbmacs/init.rb
```

When `XDG_CONFIG_HOME` is set, mrbmacs first looks for:

```text
$XDG_CONFIG_HOME/mrbmacs/init.rb
```

The startup file is evaluated as Ruby in the application instance, so
application state such as `@config` and `@frame` is available directly.

For compatibility, `~/.mrbmacs` and `~/.mrbmacsrc` are also recognized. New
configurations should use the XDG location. mrbmacs loads only the first
existing regular file in this order:

1. `$XDG_CONFIG_HOME/mrbmacs/init.rb`, when `XDG_CONFIG_HOME` is set;
2. `~/.config/mrbmacs/init.rb`;
3. `~/.mrbmacs`;
4. `~/.mrbmacsrc`.

When `XDG_CONFIG_HOME` is unset or empty, the first two locations are the same
and are checked only once. A relative `XDG_CONFIG_HOME` is invalid under the
XDG Base Directory specification and is treated as unset.

Use `-q` to start without loading any startup file:

```sh
mrbmacs-termbox -q
```

Use `-l FILE` to load another Ruby file after normal startup initialization:

```sh
mrbmacs-termbox -l project.rb
```

Errors raised while loading a configuration file are written to the mrbmacs
log in the system temporary directory.

## Example

```ruby
# Theme classes must be included in the build.
@config.theme = Mrbmacs::SolarizedDarkTheme

# Try these encodings, in order, when a file is not valid UTF-8.
@config.file_encodings = ['Windows-31J', 'EUC-JP']

# Extension configuration is grouped by extension name.
@config.ext['lsp'] = {
  'ruby' => {
    'command' => 'solargraph',
    'options' => { 'args' => ['stdio'] }
  }
}

@config.ext['dap'] = {
  'ruby' => {
    command: 'rdbg',
    args: ['-O', '--sock-path=/tmp/mrbmacs-rdbg'],
    type: 'rdbg',
    langs: ['ruby'],
    sock_path: '/tmp/mrbmacs-rdbg',
    require_target: true
  }
}

# Font handling is frontend-specific. Cocoa and GTK provide set_font.
@frame.set_font('Menlo', 14) if @frame.respond_to?(:set_font)
```

See [LSP](lsp.md) and [DAP](dap.md) for extension-specific settings.

## Themes

Set the startup theme to a theme class:

```ruby
@config.theme = Mrbmacs::Base16DefaultLightTheme
```

The base package includes default Base16 and Solarized themes. Additional
theme classes are available when `mruby-mrbmacs-themes-base16` or
`mruby-mrbmacs-themes-tomorrow` is included in the build.

At runtime, use `M-x select-theme` to select an included theme by name.

## Fonts

Fonts are not currently part of `Mrbmacs::Config`. Graphical frontends can
provide `@frame.set_font(NAME, SIZE)` and `M-x select-font`. Terminal frontends
use the font selected by the terminal emulator. Guard a portable startup file
with `respond_to?` as shown above.

## Core configuration fields

| Field | Default | Purpose |
| --- | --- | --- |
| `@config.theme` | `Mrbmacs::Base16DefaultDarkTheme` | Theme class used at startup |
| `@config.ext` | `{}` | Settings consumed by optional extensions |
| `@config.file_encodings` | `[]` | Fallback encodings tried when reading files |
| `@config.use_builtin_completion` | `false` | Enable built-in completion handling |
| `@config.use_builtin_indent` | `false` | Select built-in indentation where supported |
| `@config.use_builtin_syntax_check` | `false` | Run built-in syntax checking on file operations |
| `@config.styles` | `Mrbmacs::StyleOverrides.new` | User overrides for syntax and Scintilla styles |

An extension may adjust a core option while registering itself. For example,
the LSP extension disables built-in completion so LSP completion can handle
the same events.

## Style overrides

Override a semantic style globally or for one lexer through `@config.styles`:

```ruby
@config.styles.override(:comment, italic: false)
@config.styles.override(:string, lexer: :ruby, foreground: :base0C)
```

An exact Scintilla style can also be overridden when necessary:

```ruby
@config.styles.override_scintilla(
  :ruby,
  Scintilla::SCE_RB_SYMBOL,
  bold: true
)
```

See the
[`mruby-mrbmacs-base` style-system design](https://github.com/masahino/mruby-mrbmacs-base/blob/master/docs/style-system-design.md)
for the resolution order and available override levels.

## Loading order

The main startup order relevant to configuration is:

1. create the initial buffer and frontend frame;
2. load the highest-priority startup file, unless `-q` was specified;
3. create and apply `@config.theme`;
4. register optional extensions, which consume `@config.ext`;
5. load the file passed with `-l`, if any.

This is why theme, LSP, and DAP startup settings belong in `@config`: they are
read after the startup file has been evaluated.
