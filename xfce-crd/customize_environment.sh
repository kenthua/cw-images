#!/bin/bash

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."

  # Safer Oh My Zsh installation:
  INSTALL_SCRIPT="$HOME/omz_install.sh"
  if curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o "$INSTALL_SCRIPT"; then
      chmod +x "$INSTALL_SCRIPT"
      # Run the installer non-interactively
      sh "$INSTALL_SCRIPT" --unattended
      rm "$INSTALL_SCRIPT"
      echo "Oh My Zsh installation complete. Please restart your terminal session or run 'zsh'."
  else
      echo "Failed to download Oh My Zsh install script."
      [ -f "$INSTALL_SCRIPT" ] && rm "$INSTALL_SCRIPT"
  fi
else
  echo "Oh My Zsh already installed."
fi

# Install GitHub CLI (gh) if not already installed
if ! command -v gh &> /dev/null; then
  echo "Installing GitHub CLI (gh)..."

  # Fetch the latest release version, with a fallback
  GH_VERSION=$(curl -s "https://api.github.com/repos/cli/cli/releases/latest" | grep -Po '"tag_name": "\Kv[^"]+' || true)

  if [ -z "$GH_VERSION" ]; then
    echo "Failed to fetch latest gh CLI version, falling back to v2.87.2."
    GH_VERSION="v2.87.2" # Fallback version, include 'v' prefix for consistency
  fi
  # Remove 'v' prefix for consistency with download URL format
  GH_VERSION_NO_V="${GH_VERSION#v}"

  GH_TARBALL="gh_${GH_VERSION_NO_V}_linux_amd64.tar.gz"
  GH_DOWNLOAD_URL="https://github.com/cli/cli/releases/download/${GH_VERSION}/${GH_TARBALL}"
  GH_TEMP_DIR="$(mktemp -d)"

  # Download the tarball
  if curl -fsSL "${GH_DOWNLOAD_URL}" -o "${GH_TEMP_DIR}/${GH_TARBALL}"; then
    echo "Downloaded gh CLI tarball."
    
    # Create target directory
    mkdir -p "$HOME/.local/bin"

    # Extract gh binary
    if tar -xzf "${GH_TEMP_DIR}/${GH_TARBALL}" -C "${GH_TEMP_DIR}" --strip-components=2 "gh_${GH_VERSION_NO_V}_linux_amd64/bin/gh"; then
      mv "${GH_TEMP_DIR}/gh" "$HOME/.local/bin/"
      chmod +x "$HOME/.local/bin/gh"
      echo "GitHub CLI (gh) installed to $HOME/.local/bin/gh"
    else
      echo "Failed to extract gh CLI."
    fi
  else
    echo "Failed to download gh CLI tarball."
  fi
  
  # Clean up temporary directory
  rm -rf "${GH_TEMP_DIR}"
else
  echo "GitHub CLI (gh) is already installed."
fi