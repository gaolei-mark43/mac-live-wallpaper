enum PlaybackState: Equatable {
    case idle
    case playing(filename: String, displayCount: Int)
    case failed(message: String)

    var message: String {
        switch self {
        case .idle:
            "Choose a local video to use as your wallpaper."
        case let .playing(filename, displayCount):
            "Playing \(filename) on \(displayCount) \(displayCount == 1 ? "display" : "displays")."
        case let .failed(message):
            message
        }
    }

    var isPlaying: Bool {
        if case .playing = self {
            return true
        }
        return false
    }
}
