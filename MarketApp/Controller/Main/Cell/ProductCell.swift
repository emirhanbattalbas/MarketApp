import UIKit

protocol ProductCellDelegate: AnyObject {
  func didProductChangePress(isIncrease: Bool, product: Product)
}

class ProductCell: UICollectionViewCell, Reusable {
  
  static var nib: UINib {
    return UINib(nibName: String(describing: ProductCell.self), bundle: nil)
  }
  
  // MARK:- Button
  @IBOutlet var deIncreaseButton: UIButton!
  
  //MARK:- View
  @IBOutlet var productCountView: UIView!
  
  //MARK:- ImageView
  @IBOutlet var productImageView: UIImageView!
  
  //MARK:- Label
  @IBOutlet var productCountLabel: UILabel!
  @IBOutlet var productPriceLabel: UILabel!
  @IBOutlet var productNameLabel: UILabel!
  
  var productCount: Int = 0
  weak var delegate: ProductCellDelegate?
  var product: Product? {
    didSet {
      guard let product = product else { return }
      
      if let urlString = product.imageUrl,
         let url = URL(string: urlString) {
        productImageView.load(url: url)
      }
      productPriceLabel.text = product.amount
      productNameLabel.text = product.name
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @IBAction func deIncreaseTapped(_ sender: Any) {

    guard let product = product else { return }
    productCount -= 1
    delegate?.didProductChangePress(isIncrease: false, product: product)
    
    guard productCount != 0 else {
      productCountView.isHidden = true
      deIncreaseButton.isHidden = true
      return
    }
    productCountLabel.text = String(productCount)
  }
  
  @IBAction func increaseTapped(_ sender: Any) {
    
    guard let product = product, product.stock > productCount else { return }
    productCount += 1
    productCountLabel.text = String(productCount)
    productCountView.isHidden = false
    deIncreaseButton.isHidden = false
    delegate?.didProductChangePress(isIncrease: true, product: product)
  }
}
