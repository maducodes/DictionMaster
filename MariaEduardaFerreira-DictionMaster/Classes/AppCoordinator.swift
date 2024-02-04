import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    private var searchCoordinator: SearchCoordinator?
    
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
        searchCoordinator?.start()
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
