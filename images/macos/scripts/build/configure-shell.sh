#!/bin/bash -e -o pipefail
################################################################################
##  File:  configure-shell.sh
##  Desc:  Configure shell to use bash
################################################################################

source ~/utils/utils.sh
arch=$(get_arch)

echo "Changing shell to bash"
sudo chsh -s /bin/bash $USERNAME
sudo chsh -s /bin/bash root

# Check MacOS architecture and add HOMEBREW PATH to bashrc
if [[ $arch == "arm64" ]]; then
  echo "Adding Homebrew environment to bash"
  /opt/homebrew/bin/brew shellenv >> ~/.bashrc
  # Workaround for the issue (#10624) with the Homebrew PATH in the bashrc
  sed -i '' '/; export PATH;/d' ~/.bashrc
  echo 'export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"' >> ~/.bashrc
fi
