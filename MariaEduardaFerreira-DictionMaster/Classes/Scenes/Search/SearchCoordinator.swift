import UIKit

final class SearchCoordinator {
    private let navigationController: UINavigationController
    var delegate: SearchCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let presenter = SearchPresenter()
        
        let searchViewController = SearchViewController(presenter: presenter)
        searchViewController.delegate = self
        presenter.viewController = searchViewController
        
        searchViewController.navigationItem.setHidesBackButton(true, animated: false)
        navigationController.pushViewController(searchViewController, animated: true)
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func searchResult(text: String) {
        self.delegate?.searchResult(text: text)
    }
}
