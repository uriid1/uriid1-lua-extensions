#!/usr/bin/env bash

set -euo pipefail

luarocks install --local \
  --tree=$PWD/.rocks \
  --lua-version 5.1 \
  luaunit
