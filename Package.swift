// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MacLiveWallpaper",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .executable(name: "MacLiveWallpaper", targets: ["MacLiveWallpaper"])
    ],
    targets: [
        .executableTarget(
            name: "MacLiveWallpaper"
        ),
        .testTarget(
            name: "MacLiveWallpaperTests",
            dependencies: ["MacLiveWallpaper"]
        )
    ]
)
