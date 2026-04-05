#!/bin/sh

set -eu

exec sh -c 'curl -fsSL https://raw.githubusercontent.com/getstassh/stassh/refs/heads/main/install.sh | sh'
