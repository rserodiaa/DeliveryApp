
import UIKit
import MapKit

class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title: String = LocalizeStrings.MapScreen.currentLocation, location: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = location
    }
}
