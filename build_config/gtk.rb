require "#{File.dirname(__FILE__)}/common.rb"

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
