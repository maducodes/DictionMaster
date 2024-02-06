import Foundation
import UIKit

final class SearchPresenter {
    private var buttonBottomAnchor: CGFloat?
    weak var viewController: SearchViewControllerType?
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let convertedKeyboardFrame = viewController?.view.convert(keyboardFrame, from: nil)
            let keyboardHeight = convertedKeyboardFrame?.height ?? 0
            buttonBottomAnchor = keyboardHeight
            viewController?.show(buttonIsHidden: true,
                                 buttonBottomAnchor: -keyboardHeight)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SearchPresenter: SearchPresenterType {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    func validateTextField(text: String) {
        if let buttonBottomAnchor = buttonBottomAnchor {
            viewController?.show(buttonIsHidden: text.isEmpty, 
                                 buttonBottomAnchor: buttonBottomAnchor)
        }
    }
}
