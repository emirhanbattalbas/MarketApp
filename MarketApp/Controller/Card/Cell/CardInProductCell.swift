import UIKit

protocol CardInProductCellDelegate: AnyObject {
  func didRemoveProduct(sender: UITableViewCell)
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
  weak var cardDelegate: CardUpdate?
  
  var product: Product? {
    didSet {
      guard let product = product else { return }
      
      if let urlString = product.imageUrl,
         let url = URL(string: urlString) {
        productImageView.load(url: url)
      }
      productPriceLabel.text = String((product.price)*Double(product.selectedCount ?? 1))
      productNameLabel.text = product.name
      if let selectedCount = product.selectedCount {
        productCountLabel.text = String(selectedCount)
      }
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
    setLabels(product: product)
    guard product?.selectedCount != 0 else {
      delegate?.didRemoveProduct(sender: self)
      return
    }
  }
  
  @IBAction func increaseTapped(_ sender: Any) {
    if let selectedCount = product?.selectedCount, product!.stock > selectedCount  {
      product?.selectedCount! += 1
      setLabels(product: product)
    }
  }
  
  private func setLabels(product: Product?) {
    guard let product = product else { return }
    productPriceLabel.text = String((product.price)*Double(product.selectedCount ?? 1))
    productCountLabel.text = String(product.selectedCount ?? 0)
    cardDelegate?.updateCard(product: product)
  }
}
