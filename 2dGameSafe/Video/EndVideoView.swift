//
//  EndVideoView.swift
//  2dGameSafe
//
//  Created by Ali Haidar on 27/06/24.
//

import SwiftUI
import AVKit

struct EndVideoView: View {
    @State private var navigateToMainView = false

    var body: some View {
        NavigationStack {
            ZStack {
                VideoPlayerView(url: Bundle.main.url(forResource: "TheEnd#1", withExtension: "mp4")!) {
                    // Set the state variable to trigger navigation when video finishes
                    self.navigateToMainView = true
                }
                .ignoresSafeArea()
                
                // NavigationLink to the main view, triggered by state change
                NavigationLink(destination: StartView(), isActive: $navigateToMainView) {
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct VideoPlayerView: UIViewControllerRepresentable {
    let url: URL
    let onVideoEnd: () -> Void
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        
        // Add observer to detect when the video ends
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
        
        player.play() // Start playing the video automatically
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onVideoEnd: onVideoEnd)
    }
    
    class Coordinator: NSObject {
        let onVideoEnd: () -> Void
        
        init(onVideoEnd: @escaping () -> Void) {
            self.onVideoEnd = onVideoEnd
        }
        
        @objc func playerDidFinishPlaying() {
            onVideoEnd()
        }
    }
}

struct MainView: View {
    var body: some View {
        Text("Main View")
            .font(.largeTitle)
    }
}

#Preview {
    EndVideoView()
}
