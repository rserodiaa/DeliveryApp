
import UIKit

extension DeliveryListViewController {
    
    func setupUI() {
        title = LocalizeStrings.DeliveryListScreen.deliveryListScreenTitle
        self.refreshControl = UIRefreshControl()
        refreshControl?.tintColor = AppThemes.themeColor
        refreshControl?.attributedTitle = NSAttributedString(string: LocalizeStrings.DeliveryListScreen.fetchingString, attributes: [NSAttributedString.Key.foregroundColor: AppThemes.themeColor])
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.register(DeliveryViewCell.self, forCellReuseIdentifier: String(describing: DeliveryViewCell.self))
        setupHandlers()
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        presenter?.handlePullToRefresh()
    }
    
    func hideBottomLoader() {
        tableView.tableFooterView = UIView()
    }
    
    func showBottomLoader() {
        let activityView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityView.style = .white
        activityView.color = AppThemes.themeColor
        activityView.startAnimating()
        tableView.tableFooterView = activityView
    }
    
    private func setupHandlers() {
        
        presenter?.errorHandler = { [weak self] errorMessage in
            DispatchQueue.main.async { [weak self] in
                self?.showAlert(title: LocalizeStrings.CommonStrings.errorTitle, message: errorMessage)
            }
        }
    }
}
