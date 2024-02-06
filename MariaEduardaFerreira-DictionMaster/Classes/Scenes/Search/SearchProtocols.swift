import UIKit

protocol SearchViewType: UIView {
    var didTapSearch: ((String) -> Void)? {get set }
    var didChangeSearch: ((String) -> Void)? { get set }
    
    func show(buttonIsHidden: Bool,
              buttonBottomAnchor: CGFloat)}

protocol SearchViewControllerType: UIViewController {
    func show(buttonIsHidden: Bool,
              buttonBottomAnchor: CGFloat)}

protocol SearchViewControllerDelegate {
    func searchResult(text: String)
}

protocol SearchCoordinatorDelegate {
    func searchResult(text: String)
}

protocol SearchPresenterType {
    func addKeyboardObserver()
    func validateTextField(text: String)
}
