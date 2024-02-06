import UIKit

final class HeaderSearchResultView: UIView {
    var didTapPlayAudio: (() -> Void)?
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 23
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let subContainerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 11
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleSearchLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.boldH1
        label.textColor = Colors.secondaryBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let audioButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.speaker, for: .normal)
        button.layer.cornerRadius = 23
        button.backgroundColor = Colors.primaryBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let phoneticLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.boldH4
        label.textColor = Colors.terciaryBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func show(title: String, 
              phonetic: String) {
        titleSearchLabel.text = title
        phoneticLabel.text = phonetic
    }
    
    private func setupUI() {
        buildViewHierarchy()
        buildConstraints()
        bindLayoutEvents()
    }
    
    private func bindLayoutEvents() {
        audioButton.addTarget(self, action: #selector(handleTapPlayAudio), for: .touchUpInside)
    }
    
    @objc
    private func handleTapPlayAudio() {
        didTapPlayAudio?()
    }
    
    private func buildViewHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleSearchLabel)
        containerStackView.addArrangedSubview(subContainerStackView)
        subContainerStackView.addArrangedSubview(audioButton)
        subContainerStackView.addArrangedSubview(phoneticLabel)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            audioButton.widthAnchor.constraint(equalToConstant: 46),
            audioButton.heightAnchor.constraint(equalToConstant: 46),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
