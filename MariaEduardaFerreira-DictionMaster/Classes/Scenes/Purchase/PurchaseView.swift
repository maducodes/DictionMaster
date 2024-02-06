import UIKit

final class PurchaseView: UIView {
    var didTapPurchase: (() -> Void)?
    
    private let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = Images.background
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = Images.logo
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.2
        image.layer.shadowOffset = CGSize(width: 0, height: 2)
        image.layer.shadowRadius = 2
        return image
    }()
    
    private let nameImageView: UIImageView = {
        let image = UIImageView()
        image.image = Images.title
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let text = Strings.purchaseTitle
        let attributedText = NSMutableAttributedString(string: text)
        
        if let range = text.range(of: Strings.unlimited) {
            let nsRange = NSRange(range, in: text)
            attributedText.addAttribute(.foregroundColor, value: Colors.primaryBlue, range: nsRange)
        }
    
        if let range = text.range(of: Strings.all) {
            let nsRange = NSRange(range, in: text)
            attributedText.addAttribute(.foregroundColor, value: Colors.primaryBlue, range: nsRange)
        }
        
        if let range = text.range(of: Strings.features) {
            let nsRange = NSRange(range, in: text)
            attributedText.addAttribute(.foregroundColor, value: Colors.primaryBlue, range: nsRange)
        }
        
        let label = UILabel()
        label.font = Fonts.boldH7
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let text = Strings.purchaseDescription
        let attributedText = NSMutableAttributedString(string: text)
        
        if let range = text.range(of: Strings.daysFree) {
            let nsRange = NSRange(range, in: text)
            attributedText.addAttribute(.font, value: Fonts.boldH6, range: nsRange)
        }
        
        if let range = text.range(of: Strings.price) {
            let nsRange = NSRange(range, in: text)
            attributedText.addAttribute(.font, value: Fonts.boldH6, range: nsRange)
        }
        
        let label = UILabel()
        label.text = Strings.purchaseDescription
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Fonts.regularH4
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subscribeButton: CustomButton = {
        let button = CustomButton()
        button.setTitle(Strings.purchaseButtonTitle.uppercased(),
                        for: .normal)
        button.backgroundColor = Colors.primaryBlue
        button.titleLabel?.font = Fonts.boldH5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 14
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = Colors.primaryWhite
        buildViewHierarchy()
        buildContraints()
        bindLayoutEvents()
    }
    
    private func bindLayoutEvents() {
        subscribeButton.didTapButton = {
            self.handleTapPurchase()
        }
    }
    
    @objc
    private func handleTapPurchase() {
        didTapPurchase?()
    }
    
    private func buildViewHierarchy() {
        addSubview(backgroundImageView)
        addSubview(logoImageView)
        addSubview(nameImageView)
        
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        containerStackView.addArrangedSubview(subscribeButton)
        
        containerStackView.setCustomSpacing(36, after: titleLabel)
        containerStackView.setCustomSpacing(16, after: descriptionLabel)
    }
    
    private func buildContraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            logoImageView.centerYAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nameImageView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: -15),
            nameImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            containerStackView.topAnchor.constraint(equalTo: nameImageView.bottomAnchor, constant: 26),
            containerStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 23),
            containerStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -23),
            
            subscribeButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PurchaseView: PurchaseViewType {

}
