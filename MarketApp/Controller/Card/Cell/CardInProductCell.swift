import UIKit

protocol CardInProductCellDelegate: AnyObject {
  func didRemoveProduct(sender: UITableViewCell)
  func didUpdateProduct(product: Product)
}

class CardInProductCell: UITableViewCell, Reusable {
  
  static var nib: UINib {
    return UINib(nibName: String(describing: CardInProductCell.self), bundle: nil)
  }
  
  //MARK:- ImageView
  @IBOutlet var productImageView: UIImageView!
  
  //MARK:- Label
  @IBOutlet var productCountLabel: UILabel!
  @IBOutlet var productPriceLabel: UILabel!
  @IBOutlet var productNameLabel: UILabel!
  
  weak var delegate: CardInProductCellDelegate?
  
  var product: Product? {
    didSet {
      guard let product = product else { return }
      
      if let urlString = product.imageUrl,
         let url = URL(string: urlString) {
        productImageView.load(url: url)
      }
      productPriceLabel.text = product.amount
      productCountLabel.text = String(product.selectedCount ?? 0)
      productNameLabel.text = product.name
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func decreaseTapped(_ sender: Any) {
    
    product?.selectedCount! -= 1
    productCountLabel.text = String(product!.selectedCount ?? 0)
    
    guard product?.selectedCount != 0 else {
      delegate?.didRemoveProduct(sender: self)
      return
    }
    delegate?.didUpdateProduct(product: product!)
  }
  
  @IBAction func increaseTapped(_ sender: Any) {
    guard product!.stock >= (product?.selectedCount ?? 0) else { return }
    product?.selectedCount! += 1
    productCountLabel.text = String(product!.selectedCount ?? 0)
    delegate?.didUpdateProduct(product: product!)
  }
}
