
import UIKit

class DeliveryListViewController: UITableViewController {

    var presenter: DeliveryListPresenterProtocol?
    let loader = Loader()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.startFetchingList()
    }
    
    // MARK: - Table view data sources
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let deliveryCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DeliveryViewCell.self)) as? DeliveryViewCell {
            deliveryCell.configureUI(withDeliveryModel: presenter, index: indexPath.row)
            cell = deliveryCell
        }
        return cell
    }
    
    // MARK: - Table view delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showMapController(navigationController: self.navigationController!, selectedDelivery: (presenter?.delivery(atIndex: indexPath.row))!)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == presenter?.numberOfRows() {
            presenter?.makeNextPageCall()
        }
    }
}

extension DeliveryListViewController: DeliveryListViewProtocol {

    func showDelivery(listArray: [DeliveryModel]) {
        self.tableView.reloadData()
    }

    func showError() {
        let alert = UIAlertController(title: LocalizeStrings.CommonStrings.errorTitle, message: LocalizeStrings.ErrorMessage.deliveryErrorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: LocalizeStrings.CommonStrings.ok, style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: LocalizeStrings.CommonStrings.retry, style: UIAlertAction.Style.default, handler: { (action) in
            self.presenter?.startFetchingList()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func emptyListHandler() {
        if (presenter?.numberOfRows())! > 0 {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        } else {
            let noDataLabel = UILabel()
            noDataLabel.text          = LocalizeStrings.ErrorMessage.emptyTableErrorMessage
            noDataLabel.numberOfLines = AppConstants.numberOfLines
            noDataLabel.textColor     = AppThemes.textColorDark
            noDataLabel.textAlignment = .center
            noDataLabel.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            NSLayoutConstraint.activate([
                noDataLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
                noDataLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
                ])
        }
    }
    
    func pullToRefreshHandler() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    func loadMoreHandler(showLoader: Bool) {
        guard showLoader else {
            self.hideBottomLoader()
            return
        }
        self.showBottomLoader()
    }
    
    func screenLoaderHandler(showLoader: Bool) {
        showLoader ? self.loader.start() : self.loader.stop()
    }
}
