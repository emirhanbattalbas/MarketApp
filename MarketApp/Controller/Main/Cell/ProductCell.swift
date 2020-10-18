import UIKit

protocol ProductCellDelegate: AnyObject {
  func didProductIncrease(product: Product)
  func didProductDecrease(product: Product)
}

class ProductCell: UICollectionViewCell, Reusable {
  
  static var nib: UINib {
    return UINib(nibName: String(describing: ProductCell.self), bundle: nil)
  }
  
  // MARK:- Button
  @IBOutlet var decreaseButton: UIButton!
  
  //MARK:- View
  @IBOutlet var productCountView: UIView!
  
  //MARK:- ImageView
  @IBOutlet var productImageView: UIImageView!
  
  //MARK:- Label
  @IBOutlet var productCountLabel: UILabel!
  @IBOutlet var productPriceLabel: UILabel!
  @IBOutlet var productNameLabel: UILabel!
    
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
      
      if product.selectedCount == 0 {
        decreaseButton.isHidden = true
        productCountView.isHidden = true
      } else {
        productCountLabel.text = String(product.selectedCount ?? 0)
        decreaseButton.isHidden = false
        productCountView.isHidden = false
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @IBAction func decreaseTapped(_ sender: Any) {
    guard let product = product else { return }
    
    product.selectedCount! -= 1
    delegate?.didProductDecrease(product: product)
    productCountLabel.text = String(product.selectedCount!)

    guard product.selectedCount! != 0 else {
      productCountView.isHidden = true
      decreaseButton.isHidden = true
      return
    }
  }
  
  @IBAction func increaseTapped(_ sender: Any) {
    guard let product = product, product.stock > product.selectedCount! else { return }
    
    product.selectedCount! += 1
    productCountLabel.text = String(product.selectedCount!)
    productCountView.isHidden = false
    decreaseButton.isHidden = false
    delegate?.didProductIncrease(product: product)
  }
}
