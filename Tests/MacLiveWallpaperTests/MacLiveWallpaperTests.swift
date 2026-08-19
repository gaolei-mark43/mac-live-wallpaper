import Testing

@testable import MacLiveWallpaper

@Test func idleStateHasExpectedPresentation() {
    let state = PlaybackState.idle

    #expect(!state.isPlaying)
    #expect(state.message == "Choose a local video to use as your wallpaper.")
}

@Test func playingStateDescribesOneDisplay() {
    let state = PlaybackState.playing(filename: "ocean.mp4", displayCount: 1)

    #expect(state.isPlaying)
    #expect(state.message == "Playing ocean.mp4 on 1 display.")
}

@Test func playingStatePluralizesDisplays() {
    let state = PlaybackState.playing(filename: "ocean.mp4", displayCount: 2)

    #expect(state.message == "Playing ocean.mp4 on 2 displays.")
}
