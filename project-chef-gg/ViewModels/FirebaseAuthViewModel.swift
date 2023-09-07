import FirebaseCore
import FirebaseAuth
import FirebaseAuthCombineSwift
import GoogleSignIn

final class FirebaseAuthViewModel: ObservableObject {
    @Published var session: User?
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.session = User(id: user.uid, email: user.email, displayName: user.displayName)
            } else {
                self.session = nil
            }
        }
    }
    
    func removeListener() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func authenticateWithGoogle() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else { return }
        
        guard let GCID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: GCID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            
            guard let idToken = result?.user.idToken?.tokenString, let accessToken = result?.user.accessToken.tokenString else {
                print("Error! \(String(describing: error))")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    print("Error in Firebase! \(String(describing: error))")
                    return
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(String(describing: signOutError))")
        }
    }
}
