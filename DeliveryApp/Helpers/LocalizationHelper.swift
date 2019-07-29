
import Foundation

struct LocalizeStrings {
    struct DeliveryListScreen {
        static let deliveryListScreenTitle = NSLocalizedString("DeliveryListTitle", comment: "")
        static let fetchingString = NSLocalizedString("FetchDeliveries", comment: "")
    }
    struct ErrorMessage {
        static let NetworkErrorMessage = NSLocalizedString("NetworkError", comment: "")
        static let internetErrorMessage = NSLocalizedString("NoInternetError", comment: "")
        static let deliveryErrorMessage = NSLocalizedString("DeliveryFailError", comment: "")
        static let emptyTableErrorMessage = NSLocalizedString("EmptyTableMessage", comment: "")
    }
    struct MapScreen {
        static let mapScreenTitle = NSLocalizedString("MapTitle", comment: "")
        static let currentLocation = NSLocalizedString("Current Location", comment: "")
        static let noLocation = NSLocalizedString("NoLocation", comment: "")
    }
    struct CommonStrings {
        static let errorTitle = NSLocalizedString("Alert", comment: "")
        static let ok = NSLocalizedString("Ok", comment: "")
        static let retry = NSLocalizedString("Retry", comment: "")
        static let loading = NSLocalizedString("Loading", comment: "")
    }
}
