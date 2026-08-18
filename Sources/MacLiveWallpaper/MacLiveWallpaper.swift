import SwiftUI

@main
struct MacLiveWallpaperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 42))
                .foregroundStyle(.blue)

            Text("Mac Live Wallpaper")
                .font(.title2.bold())

            Text("Native live wallpaper for macOS")
                .foregroundStyle(.secondary)
        }
        .frame(width: 420, height: 240)
    }
}
