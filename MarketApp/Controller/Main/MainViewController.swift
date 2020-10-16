import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet var mainView: MainView!
  
  var viewModel: MainViewModel!
  var totalProductCount: Int = 0
  var selectedProductDictionary: [String:[Product]] = [:]
  
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
    let nav = UINavigationController(rootViewController: cardViewController)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true, completion: nil)
  }
}

extension MainViewController: ProductCellDelegate {
  func didProductChangePress(isIncrease: Bool, product: Product) {
    
    if isIncrease {
      var selectProduct = selectedProductDictionary[product.id] ?? []
      selectProduct.append(product)
      selectedProductDictionary[product.id] = selectProduct
      totalProductCount += 1
    } else {
      selectedProductDictionary.removeValue(forKey: product.id)
      totalProductCount -= 1
    }
    
    let buttonTitle = totalProductCount == 0 ? "" : String(totalProductCount)
    
    cartButton.setTitle(buttonTitle, for: .normal)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
  }
}
