import AppKit
import AVFoundation
import Combine
import UniformTypeIdentifiers

@MainActor
final class WallpaperController: ObservableObject {
    @Published private(set) var state: PlaybackState = .idle
    @Published var isSlowMotionEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isSlowMotionEnabled, forKey: Self.slowMotionDefaultsKey)
            sessions.forEach { $0.setPlaybackRate(playbackRate) }
        }
    }

    private static let slowMotionDefaultsKey = "isSlowMotionEnabled"
    private var sessions: [WallpaperSession] = []
    private var currentVideoURL: URL?
    private nonisolated(unsafe) var screenObserver: NSObjectProtocol?

    var isPlaying: Bool { state.isPlaying }
    var statusMessage: String { state.message }
    private var playbackRate: Float { isSlowMotionEnabled ? 0.1 : 1.0 }

    init() {
        isSlowMotionEnabled = UserDefaults.standard.object(forKey: Self.slowMotionDefaultsKey) as? Bool ?? true
        screenObserver = NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.rebuildForCurrentScreens()
            }
        }
    }

    deinit {
        if let screenObserver {
            NotificationCenter.default.removeObserver(screenObserver)
        }
    }

    func chooseVideo() {
        let panel = NSOpenPanel()
        panel.title = "Choose a wallpaper video"
        panel.prompt = "Use as Wallpaper"
        panel.allowedContentTypes = [.movie]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false

        guard panel.runModal() == .OK, let url = panel.url else {
            return
        }

        start(videoURL: url)
    }

    func start(videoURL: URL) {
        currentVideoURL = videoURL
        buildSessions(videoURL: videoURL)
    }

    func stop() {
        sessions.forEach { $0.stop() }
        sessions.removeAll()
        currentVideoURL = nil
        state = .idle
    }

    private func rebuildForCurrentScreens() {
        guard let currentVideoURL else { return }
        buildSessions(videoURL: currentVideoURL)
    }

    private func buildSessions(videoURL: URL) {
        sessions.forEach { $0.stop() }
        sessions.removeAll()

        let screens = NSScreen.screens
        guard !screens.isEmpty else {
            state = .failed(message: "No display is currently available.")
            return
        }

        sessions = screens.map { screen in
            WallpaperSession(videoURL: videoURL, screen: screen)
        }
        sessions.forEach { $0.start(playbackRate: playbackRate) }

        state = .playing(filename: videoURL.lastPathComponent, displayCount: sessions.count)
    }
}
