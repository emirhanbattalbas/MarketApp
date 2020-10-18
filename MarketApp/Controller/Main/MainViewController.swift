import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet var mainView: MainView!
  
  var viewModel: MainViewModel!
  
  lazy private var cartButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage.init(systemName: "cart.fill"), for: .normal)
    button.sizeToFit()
    button.addTarget(self, action: #selector(didShowMarket), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = MainViewModel(view: mainView)
    mainView.registerCell()
    customizeNavigation()
  }
  
  fileprivate func setRightBarButton(totalProductCount: Int) {
    let buttonTitle = totalProductCount <= 0 ? "" : String(totalProductCount)
    cartButton.setTitle(buttonTitle, for: .normal)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
  }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return viewModel.getProductCount()
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ProductCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.product = viewModel.getProduct(row: indexPath.row)
    cell.delegate = self
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (UIScreen.main.bounds.width - 10)/3
    return CGSize(width: (UIScreen.main.bounds.width - 10)/3, height: height*2)
  }
}

extension MainViewController {
  func customizeNavigation() {
    navigationItem.title = Constant.Title.marketTitle
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
  }
  
  @objc func didShowMarket() {
    let cardViewController = CardViewController()
    cardViewController.cardViewModel = CardViewModel(selectedProducts: viewModel.getProductList())
    cardViewController.delegate = self
    cardViewController.updateCardDelegate = self
    let nav = UINavigationController(rootViewController: cardViewController)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true, completion: nil)
  }
}

extension MainViewController: CardViewControllerDelegate {
  func reloadView() {
    mainView.collectionView.reloadData()
  }
  
  func didDeleteCard() {
    viewModel.removeAllSelectedProduct()
    setRightBarButton(totalProductCount: viewModel.getCardBadgeCount())
  }
}

extension MainViewController: CardUpdate {
  func updateCard(product: Product) {
    setRightBarButton(totalProductCount: viewModel.getCardBadgeCount())
  }
}
