#!/bin/bash

version="1.0.0" # version of your software
pkg_name="name_here" # name of your software as you'd like it to show in pkg file name
identifier="com.your.identifier"

# No need to modify below
unsigned_pkg="unsigned-$pkg_name-$version.pkg"
signed_pkg="$pkg_name-$version.pkg"

dev_installer_cert="$APPLE_DEV_INSTALLER_CERT"
dev_apple_id="$APPLE_DEV_APPLE_ID"
dev_team_id="$APPLE_DEV_TEAM_ID"
dev_app_pw="$APPLE_DEV_APP_PASSWORD"

if [ -z "$dev_installer_cert" ]; then echo "DEV_INSTALLER_CERT env variable is empty"; exit 1; fi
if [ -z "$dev_apple_id" ]; then echo "DEV_APPLE_ID env variable is empty"; exit 1; fi
if [ -z "$dev_team_id" ]; then echo "DEV_TEAM_ID env variable is empty"; exit 1; fi
if [ -z "$dev_app_pw" ]; then echo "DEV_APP_PASSWORD env variable is empty"; exit 1; fi

echo "Building unsigned pkg..."
if ! pkgbuild --root package/Payload --scripts package/Scripts --identifier "$identifier" --version "$version" "$unsigned_pkg" > /dev/null; then
    echo "Failed to build unsigned pkg"
    exit 1
fi

echo "Signing pkg..."
if ! productsign --sign "$dev_installer_cert" "$unsigned_pkg" "$signed_pkg" > /dev/null; then
    echo "Failed to sign pkg"
    exit 1
fi

rm -rf "$unsigned_pkg"

echo "Submitting pkg for notarization..."
if ! xcrun notarytool submit "$signed_pkg" --apple-id "$dev_apple_id" --team-id "$dev_team_id" --password "$dev_app_pw" --wait > /dev/null; then
    echo "Failed to submit pkg for notarization"
    exit 1
fi

echo "Stapling pkg..."
if ! xcrun stapler staple "$signed_pkg" > /dev/null; then
    echo "Failed to staple pkg"
    exit 1
fi

echo "Package successfully signed, notarized, and stapled"
exit 0