import UIKit

class CardView: UIView {
  
  @IBOutlet var cardTotalPriceLabel: UILabel!
  @IBOutlet var tableView: UITableView!
  
  func registerCell() {
    tableView.register(cellType: CardInProductCell.self)
  }
  
}
