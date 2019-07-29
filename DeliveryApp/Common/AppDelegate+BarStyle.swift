
import UIKit

protocol AppBarStylable {
    func setNavBarStyle()
}

extension AppDelegate: AppBarStylable {
    func setNavBarStyle() {
        UINavigationBar.appearance().barTintColor = AppThemes.themeColor
        UINavigationBar.appearance().tintColor = AppThemes.navTintColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppThemes.textColorLight]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
