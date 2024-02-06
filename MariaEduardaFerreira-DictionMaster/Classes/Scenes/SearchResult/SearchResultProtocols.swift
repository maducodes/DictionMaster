import UIKit

protocol SearchResultViewType: UIView {
    var didTapBackToSearch: (() -> Void)? { get set }
    var didTapPlayAudio: (() -> Void)? { get set }
    
    func show(state: SearchResultViewState)
}

protocol SearchResultViewControllerType: UIViewController {
    func show(state: SearchResultViewState)
    func showErrorSoundAlert(message: String)
}

enum SearchResultViewState {
    case success(viewModel: SearchResultViewModel)
    case loading
    case error(search: String)
}

protocol SearchResultViewControllerDelegate {
    func backToSearch()
    func showAlet(_ controller: UIViewController)
}

protocol SearchResultCoordinatorDelegate {
    func backToSearch()
}

protocol SearchResultPresenterType {
    func searchResult(search: String)
    func playAudio()
}

protocol SearchResultServiceType {
    func fetchSearch(search: String, _ completion: @escaping ([SearchResultResponse]?) -> Void)
}
