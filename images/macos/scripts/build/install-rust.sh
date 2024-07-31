#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rust
################################################################################

source ~/utils/utils.sh

echo "Installing Rustup..."
brew_smart_install "rustup-init"

echo "Installing Rust language..."
rustup-init -y --no-modify-path --default-toolchain=stable --profile=minimal

echo "Initialize environment variables..."
CARGO_HOME=$HOME/.cargo

echo "Install common tools..."
rustup component add rustfmt clippy

if is_BigSur || is_Monterey; then
    cargo install --locked bindgen-cli cbindgen cargo-outdated
    cargo install cargo-audit --version 0.21.0-pre.0
fi

echo "Cleanup Cargo registry cached data..."
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
