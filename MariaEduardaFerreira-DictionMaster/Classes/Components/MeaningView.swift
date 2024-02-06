import UIKit

final class MeaningView: UIView {
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.boldH6
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let definitionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func show(definition: NSMutableAttributedString,
              examples: [String?]) {
        definitionLabel.attributedText = definition
        definitionLabel.accessibilityLabel = definition.string
        definitionLabel.accessibilityLanguage = Strings.language
        
        for item in examples {
            addExampleLabel(title: item ?? "")
        }
    }
    
    private func addExampleLabel(title: String) {
        let exampleLabel = UILabel()
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
        exampleLabel.text = "\u{2022} \(title)"
        exampleLabel.font = Fonts.regularH4
        exampleLabel.numberOfLines = 0
        exampleLabel.isAccessibilityElement = true
        exampleLabel.accessibilityLabel = title
        exampleLabel.accessibilityLanguage = Strings.language
        definitionsStackView.addArrangedSubview(exampleLabel)
    }
    
    private func setupUI() {
        buildViewHierarchy()
        buildContraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(definitionLabel)
        addSubview(definitionsStackView)
    }
    
    private func buildContraints() {
        NSLayoutConstraint.activate([
            definitionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            definitionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            definitionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            definitionsStackView.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 5),
            definitionsStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            definitionsStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            definitionsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
