import UIKit
import GoogleSignIn
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
        
        let isAuthorised = Auth.auth().currentUser != nil
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = isAuthorised ? MainTabBarController() : AuthAssembly.assemble()
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}
