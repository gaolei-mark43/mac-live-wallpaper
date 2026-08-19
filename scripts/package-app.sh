#!/bin/sh
set -eu

project_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
configuration=${CONFIGURATION:-release}
app_name="Mac Live Wallpaper.app"
build_dir="$project_dir/.build/$configuration"
bundle_dir="$build_dir/$app_name"
contents_dir="$bundle_dir/Contents"
macos_dir="$contents_dir/MacOS"
resources_dir="$contents_dir/Resources"

cd "$project_dir"
swift build --configuration "$configuration"

mkdir -p "$macos_dir" "$resources_dir"
cp "$project_dir/Packaging/Info.plist" "$contents_dir/Info.plist"
cp "$build_dir/MacLiveWallpaper" "$macos_dir/MacLiveWallpaper"
chmod 755 "$macos_dir/MacLiveWallpaper"

codesign --force --deep --sign - "$bundle_dir"

printf '%s\n' "$bundle_dir"
