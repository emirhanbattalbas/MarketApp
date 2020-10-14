import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    self.window = UIWindow()
    self.window?.backgroundColor = .clear
    self.window?.makeKeyAndVisible()
    let navigationController = UINavigationController(rootViewController: MainViewController())
//    navigationController.isNavigationBarHidden = true
    self.window?.rootViewController = navigationController
    
    return true
  }
  
}

