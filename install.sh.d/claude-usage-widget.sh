#!/bin/bash -e
# DEPENDS: brew git

# Claude Usage Widget: menu bar app + desktop widgets showing Claude usage.
# https://github.com/MarcusLai07/claude-usage-widget
# Built from source: prebuilt zips are only development-signed.

# Code signing: upstream hardcodes the author's bundle id prefix and Apple
# team, both of which collide with any other team. We rewrite them to our own
# so a free personal Apple team can sign the build. The team is auto-detected
# from Xcode's logged-in account below; override either via env if needed.
BUNDLE_PREFIX="${CLAUDE_USAGE_BUNDLE_PREFIX:-net.pocketsensei}"

# macOS-only (SwiftUI + WidgetKit)
if [ "$(uname -s)" != "Darwin" ]; then
    echo "claude-usage-widget is macOS-only, skipping"
    exit 0
fi

# Requires macOS 15 or later
macos_major=$(sw_vers -productVersion | cut -d. -f1)
if [ "$macos_major" -lt 15 ]; then
    echo "claude-usage-widget requires macOS 15 or later, skipping"
    exit 0
fi

# Building needs the full Xcode (not just the command-line tools). Use the
# active developer dir if it already points at an Xcode, else fall back to
# /Applications/Xcode.app so we don't need sudo to xcode-select.
if ! xcode-select -p 2>/dev/null | grep -q "Xcode.app"; then
    if [ -d /Applications/Xcode.app ]; then
        export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
    else
        echo "claude-usage-widget needs the full Xcode 16+ (App Store), skipping"
        exit 0
    fi
fi

# Apple team for signing: env override, else the team from Xcode's account
DEVELOPMENT_TEAM="${CLAUDE_USAGE_TEAM:-$(defaults read com.apple.dt.Xcode IDEProvisioningTeamByIdentifier 2>/dev/null | sed -n 's/.*teamID = \([A-Z0-9]*\).*/\1/p' | head -1)}"
if [ -z "$DEVELOPMENT_TEAM" ]; then
    echo "No Apple team found. Sign in to Xcode (Settings > Accounts) or set"
    echo "CLAUDE_USAGE_TEAM=<teamid>, then re-run. Skipping."
    exit 0
fi

if ! brew ls --versions xcodegen >/dev/null ; then
    brew install xcodegen
fi

REPO_URL="https://github.com/MarcusLai07/claude-usage-widget.git"
SRC_DIR="$HOME/local/src/claude-usage-widget"

# Clone or update the source. xcodegen regenerates several tracked files
# (project.pbxproj, Info.plist, entitlements) from our patched project.yml, so
# discard all local changes before pulling to keep the fast-forward clean.
if [ -d "$SRC_DIR/.git" ]; then
    git -C "$SRC_DIR" checkout -- .
    git -C "$SRC_DIR" pull --ff-only
else
    mkdir -p "$(dirname "$SRC_DIR")"
    git clone "$REPO_URL" "$SRC_DIR"
fi

pushd "$SRC_DIR" >/dev/null

# Rewrite the author's bundle id prefix and team to our own, then generate the
# Xcode project from project.yml.
perl -pi -e "s/com\.marcuslai/${BUNDLE_PREFIX}/g; s/P7DV5ZUK9A/${DEVELOPMENT_TEAM}/g" project.yml
xcodegen generate

# Build the app, generating a development cert/profile via our team as needed.
# Paid teams also require this Mac to be a registered device on the profile;
# -allowProvisioningDeviceRegistration lets xcodebuild register it. (Free
# personal teams skip device registration, so this flag was not needed before.)
xcodebuild -scheme ClaudeUsage -configuration Debug \
    -allowProvisioningUpdates -allowProvisioningDeviceRegistration \
    -derivedDataPath build.noindex build

# Install into /Applications
ditto build.noindex/Build/Products/Debug/ClaudeUsage.app /Applications/ClaudeUsage.app

popd >/dev/null

open /Applications/ClaudeUsage.app

echo "ClaudeUsage.app installed to /Applications and launched (menu bar icon)."
echo "Authenticate via OAuth or import Claude Code credentials from the keychain."
echo "Add widgets: right-click desktop > Edit Widgets > search 'Claude Usage'."
