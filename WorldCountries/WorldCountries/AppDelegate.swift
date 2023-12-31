import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = ViewController()
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}
