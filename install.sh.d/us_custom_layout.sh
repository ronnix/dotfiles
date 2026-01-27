#!/bin/bash -e
# DEPENDS: curl

# Install U.S. Custom keyboard layout
if [ "$(uname -s)" == "Darwin" ]; then

    if [ ! -d "$HOME/Library/Keyboard Layouts/U.S. custom.bundle" ]; then
        # Create destination directory
        KEYBOARD_DIR="$HOME/Library/Keyboard Layouts"
        mkdir -p "$KEYBOARD_DIR"

        # Create temporary directory
        TEMP_DIR="/tmp/uscustom_install"
        mkdir -p "$TEMP_DIR"
        cd "$TEMP_DIR"

        # Cleanup function to remove temp directory on exit
        cleanup() {
            rm -rf "$TEMP_DIR"
        }
        trap cleanup EXIT

        # Download archive
        curl -L -o uscustom.zip "https://downloads.sourceforge.net/project/uscustom/uscustom.2015-06-29.zip"

        # Extract bundle
        bsdtar -xf uscustom.zip --strip-components=1

        # Copy U.S. custom bundle
        if [ -d "U.S. custom.bundle" ]; then
            cp -R "U.S. custom.bundle" "$KEYBOARD_DIR/"
        else
            echo "❌ Error: U.S. custom.bundle not found in the archive"
            exit 1
        fi
    fi

    # Add to available layouts
    if ! defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleEnabledInputSources 2>/dev/null | grep -q "U.S. custom"; then
        defaults write ~/Library/Preferences/com.apple.HIToolbox.plist AppleEnabledInputSources -array-add \
        '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>16383</integer><key>KeyboardLayout Name</key><string>U.S. custom</string></dict>'
    fi

    # Add to selected layouts
    if ! defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources 2>/dev/null | grep -q "U.S. custom"; then
        defaults write ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources -array-add \
        '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>16383</integer><key>KeyboardLayout Name</key><string>U.S. custom</string></dict>'
    fi

    # Set as current layout
    defaults write ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID \
  "org.unknown.keylayout.UScustom"

    # Force update
    killall SystemUIServer
fi
