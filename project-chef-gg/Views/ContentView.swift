import SwiftUI

struct ContentView: View {
    @EnvironmentObject var firebaseViewModel: FirebaseAuthViewModel
    
    var body: some View {
        return Group {
            NavigationView {
                if firebaseViewModel.session == nil {
                    SignInView().navigationTitle(
                        NSLocalizedString(
                            "Sign-in",
                            comment: "Sign-in navigation title"
                        )
                    )
                } else {
                    Button("Log out", action: {
                        firebaseViewModel.signOut()
                    })
                }
            }
        }
        .onAppear(perform: firebaseViewModel.listen)
        .onDisappear(perform: firebaseViewModel.removeListener)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
