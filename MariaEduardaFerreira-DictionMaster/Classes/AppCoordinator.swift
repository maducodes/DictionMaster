import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let cache = CacheManager.shared
    private let navigationController: UINavigationController
    
    private var searchCoordinator: SearchCoordinator?
    private var searchResultCoordinator: SearchResultCoordinator?
    private var purchaseCoordinator: PurchaseCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        startSearchCoordinator()
    }
    
    func startSearchCoordinator() {
        searchCoordinator = SearchCoordinator(navigationController: navigationController)
        searchCoordinator?.delegate = self
        searchCoordinator?.start()
    }
    
    func startResultCoordinator(search: String) {
        searchResultCoordinator = SearchResultCoordinator(navigationController: navigationController)
        searchResultCoordinator?.delegate = self
        searchResultCoordinator?.start(search: search)
    }
    
    func startPurchaseCoordinator() {
        purchaseCoordinator = PurchaseCoordinator(navigationController: navigationController)
        purchaseCoordinator?.delegate = self
        purchaseCoordinator?.start()
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}

extension AppCoordinator: SearchCoordinatorDelegate {
    func searchResult(text: String) {
        if cache.continueToSearch(search: text) {
            startResultCoordinator(search: text.lowercased())
        } else {
            startPurchaseCoordinator()
        }
    }
}

extension AppCoordinator: SearchResultCoordinatorDelegate {
    func backToSearch() {
        dismiss()
    }
}

extension AppCoordinator: PurchaseCoordinatorDelegate {
    func toSubscribe() {
        dismiss()
    }
}
