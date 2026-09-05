# AI Chat and agent tools

AI Chat support is provided by the optional
[`mruby-mrbmacs-aichat`](https://github.com/masahino/mruby-mrbmacs-aichat)
extension. It uses OpenAI's Responses API through an external `curl` process.
It is not included in the integration repository's default builds.

To include AI Chat in a custom build, add the gem to the build configuration:

```ruby
conf.gem github: 'masahino/mruby-mrbmacs-aichat'
```

The extension requires curl 8.3.0 or later. Set the API key in the process
environment before starting mrbmacs:

```sh
export OPENAI_API_KEY='...'
```

The environment can also be configured from `~/.mrbmacsrc`, but API keys must
not be committed to a repository or placed in a shared configuration file.
The optional initial model is configured with `MRBMACS_AICHAT_MODEL`:

```ruby
ENV['MRBMACS_AICHAT_MODEL'] = 'gpt-5.6-luna'
```

## Chat buffer

Run `M-x aichat`, or press `C-c a`, to open the Markdown-highlighted
`*AI Chat*` buffer. Enter a prompt after `You:`, then run
`M-x aichat-send` or press `C-c C-c`. Requests run asynchronously and the
answer replaces the `Waiting for response...` text when it arrives.

The most recent ten successful user-and-assistant turns are sent with later
requests. Failed requests are not added to the conversation. Run
`M-x aichat-clear` to clear both the visible conversation and the API history.
Clearing is rejected while a request is running.

Run `M-x aichat-model` to select the model used for subsequent requests. Model
choices are retrieved from OpenAI's Models API and limited to GPT-5 model IDs.
Built-in choices are used if model retrieval fails. Changing models does not
clear the current conversation. The active model is displayed in the AI Chat
mode line.

When `M-x aichat` is invoked from an editing buffer, that buffer becomes the
target shown in the AI Chat mode line. Invoking it again from another editing
buffer changes the target; invoking it from `*AI Chat*` does not.

## Asking about an editing buffer

Run `M-x aichat-ask`, or press `C-c C-a`, from an editing buffer and enter an
instruction in the echo area. The selected region is sent as editor context;
when there is no selection, the entire current buffer is sent. The answer is
displayed in `*AI Chat*`, and the source buffer is not modified.

Editor context is copied when the request starts and is used only for that
request. It is not stored in conversation history or sent again later. Context
larger than 64 KiB is rejected rather than truncated.

Review the selected text before sending it. A buffer may contain credentials,
private keys, confidential source code, or other information that must not be
sent to an external API. Select a region when only part of a buffer should be
shared.

AI responses are displayed as Markdown text. They are not executed as editor
commands and do not automatically modify the source buffer.

## Agent tools

Optional editor tools are provided by
[`mruby-mrbmacs-agent`](https://github.com/masahino/mruby-mrbmacs-agent).
Include both gems to make these capabilities available to AI Chat:

```ruby
conf.gem github: 'masahino/mruby-mrbmacs-aichat'
conf.gem github: 'masahino/mruby-mrbmacs-agent'
```

The agent extension currently provides tools that can:

- search file contents below the current project root;
- find project-relative paths by name;
- read a project file or a bounded line range;
- open a validated project-relative file in another editor pane.

It also exposes commands whose metadata declares an external API handler, such
as `list_commands`. Paths supplied to file tools are restricted to existing
regular files below the current project root. Absolute paths, traversal outside
the project, and symlinks resolving outside the project are rejected.

Tool results and file contents required to answer a request are sent to the
OpenAI API. Tools do not provide unrestricted shell execution, automatic file
editing, or LSP/DAP operations.
