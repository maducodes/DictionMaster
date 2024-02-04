import UIKit

final class SearchCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController()
        searchViewController.navigationItem.setHidesBackButton(true, animated: false)
        navigationController.pushViewController(searchViewController, animated: true)
    }
}
