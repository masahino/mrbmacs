# Building mrbmacs

The integration repository provides build configurations for Termbox, Curses,
GTK, and Cocoa. The build script downloads mruby 4.0.0 when needed and builds
the selected frontend and its mrbgems. Cocoa is available on macOS only.

```sh
git clone https://github.com/masahino/mrbmacs
cd mrbmacs

./build.sh          # Build Termbox, Curses, and GTK
./build.sh termbox
./build.sh curses
./build.sh gtk
./build.sh cocoa     # macOS only
```

## Runtime configuration versus build configuration

These settings serve different purposes:

- `~/.config/mrbmacs/init.rb` configures editor behavior each time mrbmacs
  starts (`$XDG_CONFIG_HOME/mrbmacs/init.rb` when `XDG_CONFIG_HOME` is set);
- `build_config/*.rb` selects the frontend, mrbgems, compiler settings, and
  features compiled into the executable.

See [Startup configuration](configuration.md) for runtime settings.

## Build configuration files

`build_config/common.rb` contains mrbgems shared by the frontend builds. The
frontend files add the relevant executable and Scintilla backend.

The common configuration includes:

- the mrbmacs LSP extension and LSP client;
- the mrbmacs DAP extension;
- AI Chat and agent tools;
- the Base16 and Tomorrow theme packages;
- debug support used by the development builds.

The corresponding declarations are maintained in `build_config/common.rb`.
For example, the optional editor extensions are included with:

```ruby
conf.gem github: 'masahino/mruby-mrbmacs-lsp'
conf.gem github: 'masahino/mruby-mrbmacs-dap'
conf.gem github: 'masahino/mruby-mrbmacs-aichat'
conf.gem github: 'masahino/mruby-mrbmacs-agent'
```

## Dependency lock files

mruby can generate a `build_config.rb.lock` file that pins resolved mrbgem
revisions. When intentionally upgrading a dependent mrbgem, remove the lock
file associated with that build configuration and build again so it can be
regenerated with the new revision.
