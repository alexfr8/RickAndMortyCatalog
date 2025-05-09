import UIKit
import Networking

class AppDelegate: NSObject, UIApplicationDelegate {
    let app: AppState

    override init() {
        app = AppState(navigation: NavigationState())
        super.init()
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }
}
