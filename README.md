# Mac Live Wallpaper

A native macOS application for using local videos as lightweight live wallpapers.

## Status

Early development. The current prototype supports local video selection, muted looping playback, and multiple displays.

## Requirements

- macOS 15 or later
- Xcode 26 or later
- Swift 6.2 or later

## Development

```sh
swift build
swift test
swift run
```

You can also open `Package.swift` directly in Xcode.

## Package as a macOS app

```sh
./scripts/package-app.sh
```

The signed development bundle is created at `.build/release/Mac Live Wallpaper.app`.

## Roadmap

- [x] Select and loop a local video
- [x] Render behind desktop icons
- [x] Support multiple displays
- Pause during full-screen apps and on battery
- Add optional launch-at-login support

## Prototype limitations

- The selected video is not restored after relaunch yet.
- Playback does not pause automatically for full-screen apps or battery power yet.
- The Swift Package build is intended for development; signed app packaging comes later.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

License to be determined before the first public release.
