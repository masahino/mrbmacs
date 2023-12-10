#!/bin/sh
if [ $# -ge 1 ]; then
  if [ -e `pwd`/build_config/$1.rb ] ; then
    export MRUBY_CONFIG=`pwd`/build_config/$1.rb
    shift
  fi
fi
if [ -z "${MRUBY_CONFIG}" ] ; then
  export MRUBY_CONFIG=`pwd`/.github_actions_build_config.rb
fi
if [ -z "${MRUBY_VERSION}" ] ; then
  export MRUBY_VERSION="3.2.0"
fi

if [ ! -d "./mruby/src" ]; then
  git clone --depth=1 https://github.com/mruby/mruby.git
  if [ "${MRUBY_VERSION}" != 'master' ] ; then
    cd mruby
    git fetch --tags
    rev=`git rev-parse $MRUBY_VERSION`
    git checkout $rev
    cd ..
  fi
fi
echo $MRUBY_CONFIG
echo "cd mruby; rake ${@} "
(cd mruby; rake $@)
