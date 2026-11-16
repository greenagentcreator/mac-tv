#!/bin/bash
# Builds "Mac TV.app". Default output is ./build — unless this repo lives under
# iCloud Documents, where rewriting the .app makes macOS forget Accessibility.
# Then the app lands in ~/Library/Developer/MacTV/ (override with MACTV_APP_DIR).
set -euo pipefail
cd "$(dirname "$0")"
ROOT="$(pwd -P)"

# One universal binary: Apple silicon and Intel Macs.
ARCHS=(--arch arm64 --arch x86_64)
BUILD_LOCATION=(--scratch-path "${MACTV_BUILD_DIR:-.build}")
swift build -c release "${ARCHS[@]}" "${BUILD_LOCATION[@]}"
BIN="$(swift build -c release "${ARCHS[@]}" "${BUILD_LOCATION[@]}" --show-bin-path)"

app_dir() {
    if [ -n "${MACTV_APP_DIR:-}" ]; then
        echo "$MACTV_APP_DIR"
        return
    fi
    case "$ROOT" in
        */Documents/*|*/Mobile\ Documents/*)
            echo "$HOME/Library/Developer/MacTV"
            ;;
        *)
            echo "$ROOT/build"
            ;;
    esac
}

OUT="$(app_dir)"
mkdir -p "$OUT"
APP="$OUT/Mac TV.app"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
cp "$BIN/MacTV" "$APP/Contents/MacOS/MacTV"
cp Info.plist "$APP/Contents/Info.plist"
cp -R Icons "$APP/Contents/Resources/Icons"
cp Assets/AppIcon.icns Assets/AppIcon.png "$APP/Contents/Resources/"
# Swift packages' resource bundles (TelemetryDeck's privacy manifest).
for bundle in "$BIN"/*.bundle; do [ -e "$bundle" ] && cp -R "$bundle" "$APP/Contents/Resources/"; done

# Finder/xattrs break codesign; clear before signing.
xattr -cr "$APP" 2>/dev/null || true

# Stable identity keeps Accessibility across rebuilds. Prefer a *valid* local cert
# (scripts/make-signing-cert.sh), then Apple Development, then ad hoc.
IDENTITY="${MACTV_SIGN_IDENTITY:-}"
if [ -z "$IDENTITY" ]; then
    if security find-identity -p codesigning -v 2>/dev/null | grep -q '"Mac TV Local Signing"'; then
        IDENTITY="Mac TV Local Signing"
    elif IDENTITY=$(security find-identity -p codesigning -v 2>/dev/null | sed -n 's/.*"\(Apple Development: .*\)".*/\1/p' | head -1) \
        && [ -n "$IDENTITY" ]; then
        :
    else
        IDENTITY="-"
    fi
fi

if [ "$IDENTITY" = "-" ]; then
    codesign --force --entitlements Assets/MacTV.entitlements --sign - "$APP"
    echo "Signed ad hoc — Accessibility resets every rebuild. Run scripts/make-signing-cert.sh once."
else
    codesign --force --entitlements Assets/MacTV.entitlements --sign "$IDENTITY" "$APP"
    echo "Signed with $IDENTITY"
fi

# Keep ./build/Mac TV.app as a convenience symlink when the real app is elsewhere.
if [ "$OUT" != "$ROOT/build" ]; then
    mkdir -p "$ROOT/build"
    rm -rf "$ROOT/build/Mac TV.app"
    ln -s "$APP" "$ROOT/build/Mac TV.app"
    echo "Built $APP"
    echo "(repo is under Documents/iCloud — app kept outside sync so Accessibility sticks)"
else
    echo "Built $APP"
fi
