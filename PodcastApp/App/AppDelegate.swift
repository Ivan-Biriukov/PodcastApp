import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = OnboardingViewController()
//        if UserDefaults.standard.bool(forKey: "OnboardingWasViewed") {
//            window?.rootViewController = AuthViewController()
//        } else {
//            window?.rootViewController = OnboardingViewController()
//        }
        window?.makeKeyAndVisible()
        return true
    }
}
