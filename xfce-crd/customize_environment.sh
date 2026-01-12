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