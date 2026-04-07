#!/bin/bash
# Resets the macOS Dock to a curated set of pinned items.
# Writes directly to com.apple.dock.plist and restarts the Dock process.

set -euo pipefail

clear

# Build a persistent-apps tile entry for an application bundle.
app_tile() {
    local label="$1" path="$2"
    printf '<dict><key>tile-type</key><string>file-tile</string><key>tile-data</key><dict><key>file-label</key><string>%s</string><key>file-data</key><dict><key>_CFURLString</key><string>file://%s/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
        "$label" "$path"
}

# Build a persistent-others tile entry for a folder/stack.
folder_tile() {
    local label="$1" path="$2"
    printf '<dict><key>tile-type</key><string>directory-tile</string><key>tile-data</key><dict><key>file-label</key><string>%s</string><key>file-data</key><dict><key>_CFURLString</key><string>file://%s/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
        "$label" "$path"
}

# ── Pinned apps (in order) ────────────────────────────────────────────────────
defaults write com.apple.dock persistent-apps -array \
    "$(app_tile Messages        /System/Applications/Messages.app)" \
    "$(app_tile Firefox         /Applications/Firefox.app)" \
    "$(app_tile iTerm           /Applications/iTerm.app)" \
    "$(app_tile Slack           /Applications/Slack.app)" \
    "$(app_tile 'Sublime Text'  '/Applications/Sublime Text.app')" \
    "$(app_tile 'IntelliJ IDEA' '/Applications/IntelliJ IDEA.app')" \
    "$(app_tile Bruno         /Applications/Bruno.app)"

# ── Pinned folders / stacks ───────────────────────────────────────────────────
defaults write com.apple.dock persistent-others -array \
    "$(folder_tile Downloads /Users/peter/Downloads)"

killall Dock
