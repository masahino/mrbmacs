def gem_config(conf)
  conf.cc.defines << %w[MRB_UTF8_STRING]

  # include the default GEMs
  conf.gembox 'default'

  conf.gem github: 'mattn/mruby-iconv' do |g|
    g.linker.libraries.delete 'iconv' if RUBY_PLATFORM.include?('linux')
  end

  conf.gem github: 'masahino/mruby-mrbmacs-lsp'
  conf.gem github: 'masahino/mruby-mrbmacs-dap', branch: 'main'

  # additional themes
  # conf.gem github: 'masahino/mruby-mrbmacs-themes-base16', branch: 'main'
  # conf.gem github: 'masahino/mruby-mrbmacs-themes-tomorrow', branch: 'main'

  conf.enable_debug
  conf.gem github: 'masahino/mruby-debug', branch: 'main'
end

MRuby::Build.new do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    conf.toolchain :visualcpp
  else
    conf.toolchain :gcc
  end

  conf.enable_bintest
  conf.enable_test

  gem_config(conf)
end

MRuby::Build.new('mrbmacs-curses') do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    conf.toolchain :visualcpp
  else
    conf.toolchain :gcc
  end

  conf.enable_bintest
  conf.enable_test

  gem_config(conf)

  conf.gem github: 'masahino/mruby-bin-mrbmacs-curses'
end

MRuby::Build.new('mrbmacs-termbox') do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    conf.toolchain :visualcpp
  else
    conf.toolchain :gcc
  end

  conf.enable_bintest
  conf.enable_test

  gem_config(conf)

  conf.gem github: 'masahino/mruby-bin-mrbmacs-termbox', branch: 'main'
end

MRuby::Build.new('mrbmacs-gtk') do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    conf.toolchain :visualcpp
  else
    conf.toolchain :gcc
  end

  conf.enable_bintest
  conf.enable_test

  gem_config(conf)
  conf.gem :github => 'masahino/mruby-scintilla-gtk' do |g|
    g.download_scintilla
  end
  conf.gem github: 'masahino/mruby-bin-mrbmacs-gtk'
end
