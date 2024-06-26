import SwiftUI

struct GameViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController (context: Context) -> SafeViewController {
        SafeViewController ()
    }
    
    func updateUIViewController(_ uiViewController: SafeViewController, context: Context) {
        
    }
}
