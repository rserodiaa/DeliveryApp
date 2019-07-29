
import UIKit
import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func dropDestinationPin() {
        let destinationLocation = CLLocationCoordinate2D(latitude: presenter?.getLatitude() ?? 0, longitude: presenter?.getLongitude() ?? 0)
        let destinationPin = CustomPin(title: self.presenter?.getAddress() ?? LocalizeStrings.MapScreen.noLocation, location: destinationLocation)
        mapView.addAnnotation(destinationPin)
        let viewRegion = MKCoordinateRegion(center: destinationLocation, latitudinalMeters: MapViewController.routeVisibilityArea, longitudinalMeters: MapViewController.routeVisibilityArea)
        mapView.setRegion(viewRegion, animated: true)

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomPin else { return nil }
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: MapViewController.markerIdentifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: MapViewController.markerIdentifier)
            view.canShowCallout = true
            view.detailCalloutAccessoryView = UIView()
        }
        return view
    }
}
