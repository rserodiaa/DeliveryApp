
import UIKit

extension DeliveryViewCell {
    
    func addConstraints() {
        let views: [String: Any] = [
            "deliveryImageView": deliveryImageView as Any,
            "deliveryLabel": deliveryLabel as Any,
            "superview": contentView]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let horizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[deliveryImageView(80)]-10-[deliveryLabel]-10-|",
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraint
        
        let imageVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(>=10)-[deliveryImageView(80)]-(>=10)-|",
            metrics: nil,
            views: views)
        allConstraints += imageVerticalConstraint
        
        let labelVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[deliveryLabel]-10-|",
            metrics: nil,
            views: views)
        allConstraints += labelVerticalConstraint
        
        deliveryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addConstraints(allConstraints)
    }
}
