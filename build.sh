#!/bin/sh
export MRUBY_CONFIG=`pwd`/.github_actions_build_config.rb
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
(cd mruby; rake $1)
