
import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapView: MKMapView!
    var destinationImageView: UIImageView!
    var destinationLabel: UILabel!
    var presenter: MapPresenterProtocol?
    static let markerIdentifier = "marker"
    static let routeVisibilityArea: Double = 3000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        dropDestinationPin()
    }
    
    private func setupUI() {
        title = LocalizeStrings.MapScreen.mapScreenTitle
        view.backgroundColor = .white
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
        destinationImageView = UIImageView()
        destinationImageView.translatesAutoresizingMaskIntoConstraints = false
        destinationImageView.sd_setImage(with: presenter?.getImageUrl(), placeholderImage: UIImage(named: "placeholder"))
        destinationImageView.contentMode = .scaleAspectFill
        destinationImageView.clipsToBounds = true
        view.addSubview(destinationImageView)
        
        destinationLabel = UILabel()
        destinationLabel.numberOfLines = 0
        destinationLabel.lineBreakMode = .byWordWrapping
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationLabel.text = presenter?.getDeliveryText()
        view.addSubview(destinationLabel)
        
        addConstraints()
    }
}

extension MapViewController: MapViewProtocol {
    
}
