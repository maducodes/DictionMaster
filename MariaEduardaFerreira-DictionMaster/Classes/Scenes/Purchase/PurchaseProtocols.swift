import UIKit

protocol PurchaseViewType: UIView {
    var didTapPurchase: (() -> Void)? { get set }
}

protocol PurchaseViewControllerType: UIViewController {
    
}

protocol PurchaseViewControllerDelegate {
    func toSubscribe()
}

protocol PurchaseCoordinatorDelegate {
    func toSubscribe()
}
