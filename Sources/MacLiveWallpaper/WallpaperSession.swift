import AppKit
import AVFoundation
import CoreGraphics

@MainActor
final class WallpaperSession {
    private let player: AVQueuePlayer
    private let looper: AVPlayerLooper
    private let window: WallpaperWindow

    init(videoURL: URL, screen: NSScreen) {
        let item = AVPlayerItem(url: videoURL)
        let player = AVQueuePlayer()

        self.player = player
        looper = AVPlayerLooper(player: player, templateItem: item)
        window = WallpaperWindow(screen: screen, player: player)

        player.isMuted = true
        player.preventsDisplaySleepDuringVideoPlayback = false
    }

    func start() {
        window.orderFrontRegardless()
        player.play()
    }

    func stop() {
        player.pause()
        window.orderOut(nil)
    }
}

@MainActor
private final class WallpaperWindow: NSWindow {
    init(screen: NSScreen, player: AVPlayer) {
        super.init(
            contentRect: screen.frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        let desktopLevel = CGWindowLevelForKey(.desktopWindow)
        level = NSWindow.Level(rawValue: Int(desktopLevel) + 1)
        collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        ignoresMouseEvents = true
        isOpaque = true
        hasShadow = false
        backgroundColor = .black
        contentView = VideoPlayerView(player: player)
        setFrame(screen.frame, display: true)
    }

    override var canBecomeKey: Bool { false }
    override var canBecomeMain: Bool { false }
}

@MainActor
private final class VideoPlayerView: NSView {
    private let playerLayer: AVPlayerLayer

    init(player: AVPlayer) {
        playerLayer = AVPlayerLayer(player: player)
        super.init(frame: .zero)

        wantsLayer = true
        layer?.backgroundColor = NSColor.black.cgColor
        playerLayer.videoGravity = .resizeAspectFill
        layer?.addSublayer(playerLayer)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layout() {
        super.layout()
        playerLayer.frame = bounds
    }
}
