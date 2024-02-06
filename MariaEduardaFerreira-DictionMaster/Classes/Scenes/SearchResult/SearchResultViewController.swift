import UIKit

final class SearchResultViewController: UIViewController {
    private var contentView: SearchResultViewType
    private var presenter: SearchResultPresenterType
    var delegate: SearchResultViewControllerDelegate?
    
    private let search: String

    init(search: String,
         contentView: SearchResultViewType = SearchResultView(),
         presenter: SearchResultPresenterType) {
        self.search = search
        self.contentView = contentView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindLayoutEvents()
        presenter.searchResult(search: search)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func bindLayoutEvents() {
        contentView.didTapBackToSearch = {
            self.delegate?.backToSearch()
        }
        
        contentView.didTapPlayAudio = {
            self.presenter.playAudio()
        }
    }
}

extension SearchResultViewController: SearchResultViewControllerType {
    func show(state: SearchResultViewState) {
        contentView.show(state: state)
    }
    
    func showErrorSoundAlert(message: String) {
        let alertController = UIAlertController(title: Strings.errorAlertTitle,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: Strings.ok,
                                     style: .default,
                                     handler: nil)
        
        alertController.addAction(okAction)
        
        delegate?.showAlet(alertController)
    }
}
