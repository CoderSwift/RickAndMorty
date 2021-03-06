import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let launchVC = ModuleBuilder.createLaunch()
        let navBar = UINavigationController(rootViewController: launchVC)
        let backImage = UIImage(named: "icon-back")
        window?.backgroundColor = Backgrounds.darkGray
        window?.rootViewController = navBar
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().barTintColor = Backgrounds.darkGray
        UINavigationBar.appearance().tintColor = Color.orangeColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().backIndicatorImage = backImage!.stretchableImage(withLeftCapWidth: 0, topCapHeight: 110)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:  Color.orangeColor, .font: UIFont.boldFont(ofSize: 20)]
        return true
    }
}

