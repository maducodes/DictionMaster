import UIKit

final class CustomButton: UIButton {
    let feedbackGenerator = UINotificationFeedbackGenerator()
    var didTapButton: (() -> Void)?
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Colors.terciaryBlue : Colors.primaryBlue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        didTapButton?()
        feedbackGenerator.notificationOccurred(.success)
    }
}
