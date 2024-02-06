import UIKit

final class LanguageView: UIView {
    var didTapLanguage: (() -> Void)?
    
    private let containerView: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.secondaryGray
        button.layer.cornerRadius = 20
        button.isAccessibilityElement = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let LanguageimageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regularH3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func show(label: String, 
              icon: UIImage?) {
        languageLabel.text = label.uppercased()
        containerView.accessibilityLabel = Strings.selectedLanguage(label)
        containerView.accessibilityLanguage = Strings.language
        LanguageimageView.image = icon
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        buildViewHierarchy()
        buildContraints()
    }
    
    private func bindLayoutEvents() {
        containerView.addTarget(self, action: #selector(handleTapLanguage), for: .touchUpInside)
    }
    
    @objc
    private func handleTapLanguage() {
        didTapLanguage?()
    }
    
    private func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(LanguageimageView)
        containerStackView.addArrangedSubview(languageLabel)
    }
    
    private func buildContraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            containerView.widthAnchor.constraint(equalToConstant: 137),
            
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            containerStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            LanguageimageView.widthAnchor.constraint(equalToConstant: 26),
            LanguageimageView.heightAnchor.constraint(equalToConstant: 26),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
