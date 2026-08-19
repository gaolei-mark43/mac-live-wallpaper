import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: WallpaperController

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: controller.isPlaying ? "play.rectangle.on.rectangle" : "photo.on.rectangle.angled")
                .font(.system(size: 48))
                .foregroundStyle(controller.isPlaying ? .green : .blue)

            VStack(spacing: 6) {
                Text("Mac Live Wallpaper")
                    .font(.title2.bold())

                Text(controller.statusMessage)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }

            HStack(spacing: 12) {
                Button("Choose Video…") {
                    controller.chooseVideo()
                }
                .keyboardShortcut(.defaultAction)

                Button("Stop") {
                    controller.stop()
                }
                .disabled(!controller.isPlaying)
            }

            Text("MP4 and MOV are recommended. Playback is muted and loops automatically.")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(28)
        .frame(width: 480, height: 300)
    }
}
