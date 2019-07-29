
import UIKit
import SDWebImage

class DeliveryViewCell: UITableViewCell {

    var deliveryLabel: UILabel!
    var deliveryImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        deliveryImageView = UIImageView(frame: .zero)
        deliveryImageView.translatesAutoresizingMaskIntoConstraints = false
        deliveryImageView.contentMode = .scaleAspectFill
        deliveryImageView.clipsToBounds = true
        contentView.addSubview(deliveryImageView)
        
        deliveryLabel = UILabel(frame: .zero)
        deliveryLabel.numberOfLines = 0
        selectionStyle = .none
        deliveryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deliveryLabel)
        
        addConstraints()
    }
    
    func configureUI(withDeliveryModel: DeliveryListPresenterProtocol?, index: Int) {
        deliveryLabel.text = withDeliveryModel?.getDeliveryText(index: index)
        deliveryImageView.sd_setImage(with: withDeliveryModel?.getImageUrl(index: index), placeholderImage: UIImage(named: "placeholder"))
    }

}
