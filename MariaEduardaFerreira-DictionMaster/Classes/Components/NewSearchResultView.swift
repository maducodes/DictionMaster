import UIKit

final class NewSearchResultView: UIView {
    var didTapBackToSearch: (() -> Void)?
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, 
                                           left: 0, 
                                           bottom: 50,
                                           right: 0)
        return stack
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lineOpacity
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.boldH3
        label.textColor = Colors.secondaryBlue
        label.isAccessibilityElement = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regularH4
        label.text = Strings.searchResultDescription
        label.textColor = Colors.secondaryBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.isAccessibilityElement = true
        label.accessibilityLabel = Strings.searchResultDescription
        label.accessibilityLanguage = Strings.language
        return label
    }()
    
    private let newSearchButton: CustomButton = {
        let button = CustomButton()
        button.setTitle(Strings.newSearchButtonTitle.uppercased(),
                        for: .normal)
        button.backgroundColor = Colors.primaryBlue
        button.titleLabel?.font = Fonts.boldH5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 14
        
        button.isAccessibilityElement = true
        button.accessibilityLabel = Strings.newSearchButtonTitle
        button.accessibilityLanguage = Strings.language
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        buildViewHierarchy()
        buildContraints()
        bindLayoutEvents()
        
        containerStackView.setCustomSpacing(8, after: titleLabel)
        containerStackView.setCustomSpacing(20, after: descriptionLabel)
    }
    
    func show(search: String) {
        titleLabel.text = Strings.searchResultTitle(search.capitalized)
        titleLabel.accessibilityLabel = Strings.searchResultTitle(search.capitalized)
        titleLabel.accessibilityLanguage = Strings.language
    }
    
    private func bindLayoutEvents() {
        newSearchButton.didTapButton = {
            self.handleTapNewSearch()
        }
    }
    
    @objc
    private func handleTapNewSearch() {
        didTapBackToSearch?()
    }
    
    private func buildViewHierarchy() {
        addSubview(lineView)
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        containerStackView.addArrangedSubview(newSearchButton)
    }
    
    private func buildContraints() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: self.topAnchor),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            containerStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 35),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

            newSearchButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
