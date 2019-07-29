
import UIKit

class Loader: UIView {
    
    var activityIndicator: UIActivityIndicatorView!
    var isLoading = false

    override init(frame: CGRect = .zero) {
        super.init(frame: UIScreen.main.bounds)

        self.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
        self.activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        let lbl = UILabel()
        lbl.textColor = AppThemes.textColorLight
        lbl.text = LocalizeStrings.CommonStrings.loading
        let innerView = UIView()
        innerView.addSubview(self.activityIndicator)
        innerView.addSubview(lbl)
        self.addSubview(innerView)
        innerView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            innerView.widthAnchor.constraint(equalToConstant: 100),
            innerView.heightAnchor.constraint(equalToConstant: 50),
            innerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            innerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: 5),
            activityIndicator.centerYAnchor.constraint(equalTo: innerView.centerYAnchor),
            lbl.widthAnchor.constraint(equalToConstant: 100),
            lbl.heightAnchor.constraint(equalToConstant: 50),
            lbl.leadingAnchor.constraint(equalTo: activityIndicator.trailingAnchor, constant: 5),
            lbl.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor)
            ])
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func start() {
        if self.isLoading { return }
        AppConstants.sharedAppDelegate?.window?.addSubview(self)
        self.activityIndicator.startAnimating()
        self.isLoading = true
    }

    func stop() {
        self.activityIndicator.stopAnimating()
        self.removeFromSuperview()
        self.isLoading = false
    }
}
