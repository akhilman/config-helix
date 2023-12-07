#!/usr/bin/env fish

set -q XDG_CONFIG_DIR; or set -l XDG_CONFIG_DIR $HOME/.config
set -q XDG_CACHE_DIR; or set -l XDG_CACHE_DIR $HOME/.cache

function install \
    --inherit-variable XDG_CONFIG_DIR \
    --inherit-variable XDG_CACHE_DIR
  for dict in $argv
    deno run --allow-write=$XDG_CONFIG_DIR/configstore --allow-read --allow-env  npm:cspell link add \
      $(ls $XDG_CACHE_DIR/deno/npm/registry.npmjs.org/@cspell/dict-$dict/*/cspell-ext.json | tail -n 1)
  end
end

function fetch
  for dict in $argv
    deno cache npm:@cspell/dict-$dict
  end
end

function fetch_install
  fetch $argv
  install $argv
end

install en-gb
fetch_install rust ru_ru
