#!/bin/sh

set -eu

REPO="https://github.com/getstassh/stassh.git"
INSTALL_ROOT="${INSTALL_ROOT:-$HOME/.local}"
BIN_DIR="$INSTALL_ROOT/bin"
TARGET_BIN="$BIN_DIR/stassh"

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'error: required command not found: %s\n' "$1" >&2
    exit 1
  fi
}

if ! command -v cargo >/dev/null 2>&1; then
  need_cmd curl
  need_cmd sh
  printf 'info: cargo not found, installing Rust toolchain with rustup\n'
  curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs | sh -s -- -y
  # shellcheck disable=SC1090
  . "$HOME/.cargo/env"
fi

need_cmd cargo
need_cmd mktemp
need_cmd rm
need_cmd mkdir
need_cmd mv

TMP_DIR=$(mktemp -d)
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM

printf 'info: building Stassh from %s\n' "$REPO"
cargo install --git "$REPO" --locked --root "$INSTALL_ROOT" --force --package tui

mkdir -p "$BIN_DIR"

if [ -f "$BIN_DIR/tui" ] && [ ! -f "$TARGET_BIN" ]; then
  mv "$BIN_DIR/tui" "$TARGET_BIN"
elif [ -f "$BIN_DIR/tui" ]; then
  rm -f "$TARGET_BIN"
  mv "$BIN_DIR/tui" "$TARGET_BIN"
fi

if [ ! -f "$TARGET_BIN" ]; then
  printf 'error: expected binary not found at %s\n' "$TARGET_BIN" >&2
  exit 1
fi

printf '\ninstalled: %s\n' "$TARGET_BIN"
printf 'next: ensure %s is in PATH, then run: stassh\n' "$BIN_DIR"
