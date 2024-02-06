import UIKit

final class SearchResultCoordinator {
    private let navigationController: UINavigationController
    var delegate: SearchResultCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(search: String) {
        let service = SearchResultService()
        let presenter = SearchResultPresenter(service: service)
        let searchViewController = SearchResultViewController(search: search,
                                                              presenter: presenter)
        searchViewController.delegate = self
        presenter.viewController = searchViewController

        navigationController.pushViewController(searchViewController, animated: true)
    }
}

extension SearchResultCoordinator: SearchResultViewControllerDelegate {
    func backToSearch() {
        self.delegate?.backToSearch()
    }
    
    func showAlet(_ controller: UIViewController) {
        navigationController.present(controller, animated: true)
    }
}
