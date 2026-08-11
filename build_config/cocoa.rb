require "#{File.dirname(__FILE__)}/common.rb"

MRuby::Build.new('mrbmacs-cocoa') do |conf|
  toolchain :clang

  conf.enable_bintest
  conf.enable_test

  gem_config(conf)

  conf.gem github: 'masahino/mruby-bin-mrbmacs-cocoa'
end
