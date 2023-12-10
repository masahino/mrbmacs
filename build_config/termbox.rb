require "#{File.dirname(__FILE__)}/common.rb"

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
