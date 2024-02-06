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
        label.isAccessibilityElement = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let audioButton: CustomButton = {
        let button = CustomButton()
        button.setImage(Images.speaker, for: .normal)
        button.layer.cornerRadius = 23
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.accessibilityLabel = Strings.audioSpeaker
        button.accessibilityLanguage = Strings.language
        button.accessibilityHint = Strings.audioSpeakerHint
        button.backgroundColor = Colors.primaryBlue
        return button
    }()
    
    private let phoneticLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.boldH4
        label.textColor = Colors.terciaryBlack
        label.isAccessibilityElement = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func show(title: String, 
              phonetic: String?) {
        titleSearchLabel.text = title.capitalized
        titleSearchLabel.accessibilityLabel = title
        titleSearchLabel.accessibilityLanguage = Strings.language
    
        phoneticLabel.text = phonetic
        phoneticLabel.accessibilityLabel = phonetic
        phoneticLabel.accessibilityLanguage = Strings.language
    }
    
    private func setupUI() {
        buildViewHierarchy()
        buildConstraints()
        bindLayoutEvents()
    }
    
    private func bindLayoutEvents() {
        audioButton.didTapButton = {
            self.handleTapPlayAudio()
        }
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
