import UIKit

final class SearchResultView: UIView {
    var didTapBackToSearch: (() -> Void)?
    var didTapPlayAudio: (() -> Void)?
    
    private let containerScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let headerView: HeaderSearchResultView = {
        let view = HeaderSearchResultView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let meaningsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let searchNewResult: NewSearchResultView = {
        let view = NewSearchResultView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func addMeaningView(viewModel: MeaningViewModel) {
        let meaningView = MeaningView()
        meaningView.translatesAutoresizingMaskIntoConstraints = false
        meaningView.show(definition: viewModel.definition,
                         examples: viewModel.examples)
        meaningsStackView.addArrangedSubview(meaningView)
    }
    
    private func setupUI() {
        backgroundColor = Colors.primaryWhite
        buildViewHierarchy()
        buildContraints()
        bindLayoutEvents()
    }
    
    private func bindLayoutEvents() {
        headerView.didTapPlayAudio = {
            self.didTapPlayAudio?()
        }
        
        searchNewResult.didTapBackToSearch = {
            self.didTapBackToSearch?()
        }
    }
    
    private func buildViewHierarchy() {
        addSubview(containerScrollView)
        addSubview(loadingView)
        containerScrollView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(headerView)
        containerStackView.addArrangedSubview(meaningsStackView)
        containerStackView.addArrangedSubview(searchNewResult)
    }
    
    private func buildContraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: self.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            containerScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            containerScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            containerStackView.topAnchor.constraint(equalTo: containerScrollView.topAnchor, constant: 48),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultView: SearchResultViewType {
    func show(state: SearchResultViewState) {
        containerScrollView.isHidden = false
        loadingView.isHidden = true
        
        switch state {
        case .success(let viewModel):
            headerView.isHidden = false
            searchNewResult.isHidden = false
            
            headerView.show(title: viewModel.word,
                            phonetic: viewModel.phonetic)
            
            for meaningViewModel in viewModel.meanings {
                addMeaningView(viewModel: meaningViewModel)
            }
            
            searchNewResult.show(search: viewModel.word)
            break
        case .loading:
            containerScrollView.isHidden = true
            loadingView.isHidden = false
            break
        case .error(let search):
            headerView.show(title: search,
                            phonetic: nil)
            searchNewResult.show(search: search)
            break
        }
    }
}
