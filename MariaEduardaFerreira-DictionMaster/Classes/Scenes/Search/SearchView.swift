import UIKit

final class SearchView: UIView {
    var didChangeSearch: ((String) -> Void)?
    var didTapSearch: ((String) -> Void)?
    
    private let languageView: LanguageView = {
        let languageView = LanguageView()
        languageView.show(label: Strings.english,
                          icon: Images.english)
        languageView.translatesAutoresizingMaskIntoConstraints = false
        return languageView
    }()
    
    private let searchTextField: UITextField = {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.secondaryBlack,
            .font: Fonts.regularH1,
        ]
        
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = Fonts.boldH2
        textField.textColor = Colors.secondaryBlue
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isAccessibilityElement = true
        textField.accessibilityLabel = Strings.searchPlaceholder
        textField.accessibilityLanguage = Strings.language
        textField.attributedPlaceholder = NSAttributedString(string: Strings.searchPlaceholder,
                                                             attributes: placeholderAttributes)
        return textField
    }()
    
    private let searchButton: CustomButton = {
        let button = CustomButton()
        button.setTitle(Strings.searchButtonTitle.uppercased(),
                        for: .normal)
        button.backgroundColor = Colors.primaryBlue
        button.titleLabel?.font = Fonts.boldH5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 14
        button.isAccessibilityElement = true
        button.accessibilityLabel = Strings.searchButtonTitle
        button.accessibilityLanguage = Strings.language
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        searchTextField.becomeFirstResponder()
        backgroundColor = Colors.primaryWhite
        buildViewHierarchy()
        buildContraints()
        bindLayoutEvents()
    }
    
    private func bindLayoutEvents() {
        searchButton.didTapButton = {
            self.handleSearch()
        }
        
        searchTextField.addTarget(self, action: #selector(handleChangeText), for: .editingChanged)
    }
    
    @objc
    private func handleSearch() {
        didTapSearch?(searchTextField.text ?? "")
    }
    
    @objc
    private func handleChangeText() {
        didChangeSearch?(searchTextField.text ?? "")
    }
    
    private func buildViewHierarchy() {
        addSubview(languageView)
        addSubview(searchTextField)
        addSubview(searchButton)
    }
    
    private func buildContraints() {
        NSLayoutConstraint.activate([
            languageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 75),
            languageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            searchTextField.topAnchor.constraint(equalTo: languageView.bottomAnchor, constant: 180),
            searchTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    private func buildButtonConstraints(bottomAnchor: CGFloat) {
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                                                constant: bottomAnchor),
            searchButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 17),
            searchButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -17),
            searchButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView: SearchViewType {
    func show(buttonIsHidden: Bool,
              buttonBottomAnchor: CGFloat) {
        self.buildButtonConstraints(bottomAnchor: buttonBottomAnchor)
        self.searchButton.isHidden = buttonIsHidden
    }
}
