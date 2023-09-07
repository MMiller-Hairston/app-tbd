import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuthCombineSwift
import GoogleSignIn

@main
struct project_chef_ggApp: App {
    @EnvironmentObject var firebaseViewModel: FirebaseAuthViewModel
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL{ url in
                GIDSignIn.sharedInstance.handle(url)
            }.environmentObject(FirebaseAuthViewModel())
        }
    }
}
