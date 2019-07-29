
import UIKit

extension MapViewController {
    
    func addConstraints() {
        let views: [String: Any] = [
            "mapView": mapView as Any,
            "destinationImageView": destinationImageView as Any,
            "destinationLabel": destinationLabel as Any]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let mapHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[mapView]|",
            metrics: nil,
            views: views)
        allConstraints += mapHorizontalConstraints
        
        let bottomViewHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[destinationImageView(80)]-10-[destinationLabel]-10-|",
            metrics: nil,
            views: views)
        allConstraints += bottomViewHorizontalConstraints
        
        let imageVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[mapView]-10-[destinationImageView(80)]-50-|",
            metrics: nil,
            views: views)
        allConstraints += imageVerticalConstraint
        
        let labelVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[mapView]-10-[destinationLabel]-50-|",
            metrics: nil,
            views: views)
        allConstraints += labelVerticalConstraint
        
        view.addConstraints(allConstraints)
    }
}
