import UIKit

final class LoadingView: UIView {
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = Colors.primaryBlue
        spinner.startAnimating()
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = Colors.primaryWhite
        buildViewHierarchy()
        buildContraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(logoImageView)
        containerStackView.addArrangedSubview(spinner)
    }
    
    private func buildContraints() {
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
