import UIKit

final class PurchaseCoordinator {
    private let navigationController: UINavigationController
    var delegate: PurchaseCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = PurchaseViewController()
        searchViewController.delegate = self
        searchViewController.navigationItem.setHidesBackButton(true, animated: false)
        navigationController.pushViewController(searchViewController, animated: true)
    }
}

extension PurchaseCoordinator: PurchaseViewControllerDelegate {
    func toSubscribe() {
        self.delegate?.toSubscribe()
    }
}
