import UIKit

final class SearchViewController: UIViewController {
    private var contentView: SearchViewType
    private var presenter: SearchPresenterType
    var delegate: SearchViewControllerDelegate?
    
    private var search: String?

    init(contentView: SearchViewType = SearchView(),
         presenter: SearchPresenterType) {
        self.contentView = contentView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.addKeyboardObserver()
        bindLayoutEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let searchText = search {
            presenter.validateTextField(text: searchText)
        }
    }
    
    func bindLayoutEvents() {
        contentView.didTapSearch = { text in
            self.delegate?.searchResult(text: text)
        }
        
        contentView.didChangeSearch = { text in
            self.search = text
            self.presenter.validateTextField(text: text)
        }
    }
}

extension SearchViewController: SearchViewControllerType {
    func show(buttonIsHidden: Bool,
              buttonBottomAnchor: CGFloat) {
        contentView.show(buttonIsHidden: buttonIsHidden,
                         buttonBottomAnchor: buttonBottomAnchor)
    }
}
