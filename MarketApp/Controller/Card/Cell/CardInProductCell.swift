import UIKit

class CardInProductCell: UITableViewCell, Reusable {
  
  static var nib: UINib {
    return UINib(nibName: String(describing: CardInProductCell.self), bundle: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
}
