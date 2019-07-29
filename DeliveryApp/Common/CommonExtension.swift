
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizeStrings.CommonStrings.ok, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
