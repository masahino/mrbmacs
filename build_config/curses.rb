require "#{File.dirname(__FILE__)}/common.rb"

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
  if RUBY_PLATFORM.downcase =~ /msys|mingw/
    conf.cc.include_paths << "#{MRUBY_ROOT}/../misc"
    conf.cc.include_paths << "#{ENV['MINGW_PREFIX']}/include/pdcurses"
    conf.cc.flags << '-DPDC_WIDE'
    conf.cc.flags << '-DPDC_FORCE_UTF8'
  end
end
