import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet var mainView: MainView!
  
  var viewModel: MainViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = MainViewModel(view: mainView)
    mainView.customizeCollectionView()
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
    
    let button = UIButton(type: .system)
    button.setImage(UIImage.init(systemName: "cart.fill"), for: .normal)
    button.setTitle("123", for: .normal)
    button.sizeToFit()
    button.addTarget(self, action: #selector(didShowMarket), for: .touchUpInside)
    navigationItem.title = Constant.Title.marketTitle
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)

  }
  
  @objc func didShowMarket() {
    
  }
}
