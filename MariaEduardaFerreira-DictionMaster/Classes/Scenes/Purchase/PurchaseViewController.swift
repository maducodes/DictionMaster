import UIKit

final class PurchaseViewController: UIViewController {
    private var contentView: PurchaseViewType
    var delegate: PurchaseViewControllerDelegate?
    
    init(contentView: PurchaseViewType = PurchaseView()) {
        self.contentView = contentView
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
        bindLayoutEvents()
    }
    
    func bindLayoutEvents() {
        contentView.didTapPurchase = {
            self.delegate?.toSubscribe()
        }
    }
}

extension PurchaseViewController: PurchaseViewControllerType {
    
}
