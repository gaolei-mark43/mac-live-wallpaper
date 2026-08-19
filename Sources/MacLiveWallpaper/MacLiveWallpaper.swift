import SwiftUI

@main
struct MacLiveWallpaperApp: App {
    @StateObject private var wallpaperController = WallpaperController()

    var body: some Scene {
        WindowGroup {
            ContentView(controller: wallpaperController)
        }
        .windowResizability(.contentSize)

        MenuBarExtra("Mac Live Wallpaper", systemImage: "photo.on.rectangle.angled") {
            Button("Choose Video…") {
                wallpaperController.chooseVideo()
            }

            Button("Stop Wallpaper") {
                wallpaperController.stop()
            }
            .disabled(!wallpaperController.isPlaying)

            Divider()

            Toggle("10× Slow Motion", isOn: $wallpaperController.isSlowMotionEnabled)

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}
