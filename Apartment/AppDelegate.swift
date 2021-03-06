import UIKit
import Ra

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?
    public lazy var anInjector: Ra.Injector = {
        let injector = Ra.Injector()
        ApplicationModule().configureInjector(injector)
        return injector
    }()

    public func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()

        let homeViewController = anInjector.create(HomeViewController.self) as! HomeViewController
        let navController = UINavigationController(rootViewController: homeViewController)
        self.window?.rootViewController = navController

        return true
    }
}

