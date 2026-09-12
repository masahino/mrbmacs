# Debug Adapter Protocol (DAP)

DAP support is provided by the optional
[`mruby-mrbmacs-dap`](https://github.com/masahino/mruby-mrbmacs-dap)
extension. A compatible debug adapter must be installed separately.

This document describes the user-visible mrbmacs commands and configuration.
Implementation details and message sequencing are documented in the
[`mruby-mrbmacs-dap` session lifecycle](https://github.com/masahino/mruby-mrbmacs-dap/blob/master/docs/session-lifecycle.md).

## Starting a session

Run the mrbmacs `dap` command and select a debugger configuration. The DAP
buffer opens with a `(dap)` prompt. A typical native C debugging session is:

```text
(dap) launch /absolute/path/to/a.out
(dap) run
(dap) next
(dap) step
(dap) continue
```

`launch` sends the program and its arguments to the adapter and starts the DAP
configuration sequence. `run` sends `configurationDone`, indicating that
breakpoint configuration is complete and the debuggee may run. They are
separate commands.

Common commands are:

| Command | Purpose |
| --- | --- |
| `launch PROGRAM [ARG ...]` | Prepare and launch a program |
| `attach PID` or `attach PROGRAM` | Attach to an existing process |
| `break FILE:LINE` | Set a source breakpoint |
| `break FUNCTION` | Set a function breakpoint |
| `delete` | Delete configured breakpoints |
| `run` | Finish configuration and run the debuggee |
| `step` | Step into |
| `next` | Step over |
| `finish` | Step out |
| `continue` | Continue execution |
| `p NAME` | Display a variable by name |
| `scopes`, `variables`, `evaluate` | Inspect debugger data |
| `restart` | Restart the current live debug session when supported |
| `terminate` | Request termination of the debuggee |
| `help` | List DAP-buffer commands |

`restart` is a DAP restart request for an existing debug session. It is not the
same operation as launching another program after a `terminated` event.

## Breakpoints

The line-number margin displays source breakpoints and the current debugger
position. The default DAP keymap binds `C-x SPC` to toggle a source breakpoint
on the current line. See [Editor margins](margins.md) for the complete margin
layout.

Source breakpoints selected before `launch` are retained by `mruby-dap-client`
and sent after the adapter emits its `initialized` event.

The DAP buffer also accepts `break FILE:LINE` and `break FUNCTION`. Source and
function breakpoints are different DAP request types; adapter support may
differ.

## DAP output

The DAP buffer presents a reduced view of adapter activity:

| Output | Meaning |
| --- | --- |
| `[Process]` | A debuggee process was launched or attached |
| `[Stopped]` | Execution stopped and the top stack frame was selected |
| `[Breakpoint]` | The adapter reported a breakpoint change |
| `[Output] stdout` / `[Output] stderr` | Output from the debuggee |
| `[Output] console` | Console information from the adapter |
| `[Exited]` | The debuggee reported an exit code |
| `[Terminated]` | The debug session for that debuggee ended |

Detailed DAP messages are written to the mrbmacs logfile. Adapter standard
error is written to the logfile managed by `mruby-dap-client`; its default path
is under the system temporary directory and includes the adapter command name
and process ID.

## Configuration

Configure adapters in `~/.config/mrbmacs/init.rb` through
`@config.ext['dap']`. DAP adapter
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

## Adapter-specific limitations

### lldb-dap: relaunch after termination

With current `lldb-dap`, a second `launch` on the same adapter connection after
`terminated` may fail to stop at previously configured source breakpoints.
The adapter accepts the second `launch`, emits `initialized`, and returns a
successful `setBreakpoints` response with `verified: true`, but it may retain a
breakpoint object associated with the previous LLDB target instead of creating
one in the new target.

This is currently treated as an `lldb-dap` usage limitation. Use a fresh debug
adapter session when source breakpoints must be preserved across a completed
debuggee run. The limitation does not apply to a breakpoint that is configured
for the first launch.

## Diagnostics

The startup path may contain several external processes. A failure can come
from the proxy command, the native debug adapter, or the target program.

When local and installed copies may both exist, verify the executable selected
through `PATH`:

```sh
command -v lldb-dap
command -v mruby-dap-proxy
```

If a request succeeds but the visible behavior is wrong, inspect the complete
DAP message log. In particular, distinguish these stages:

```text
launch request
initialized event
setBreakpoints response
configurationDone response
process / stopped / exited / terminated events
```
