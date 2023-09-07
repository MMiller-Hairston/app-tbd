import SwiftUI
import GoogleSignInSwift


struct SignInView: View {
    @EnvironmentObject var firebaseAuthViewModel: FirebaseAuthViewModel
    @ObservedObject var vm = GoogleSignInButtonViewModel()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    GoogleSignInButton(viewModel: vm, action: firebaseAuthViewModel.authenticateWithGoogle)
                        .accessibilityIdentifier("GoogleSignInButton")
                        .accessibilityHint(Text("Sign in with Google button"))
                        .padding()
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(FirebaseAuthViewModel())
    }
}
