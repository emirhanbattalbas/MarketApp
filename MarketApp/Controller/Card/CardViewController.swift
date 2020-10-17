import UIKit

protocol CardViewControllerDelegate: AnyObject {
  func didDeleteCard()
  func didUpdateCard(product: Product)
}

class CardViewController: UIViewController {
  
  @IBOutlet var cardView: CardView!
    
  var cardViewModel: CardViewModel!
  weak var delegate: CardViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cardView.registerCell()
    customizeNavigation()
    cardView.setTotalPrice(totalPrice: cardViewModel.getTotalPrice())
  }
  @IBAction func paymentTapped(_ sender: Any) {
    cardViewModel.payment()
  }
}

extension CardViewController {
  func customizeNavigation() {
    navigationItem.title = "Sepet"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Kapat",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(didCloseCard))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sil",
                                                       style: .plain, target: self,
                                                       action: #selector(didDeleteCard))
  }
  
  @objc func didDeleteCard() {
    createDefaultAlert(title: "Warning",
                       message: "Sepetinizdeki ürünleri silmek istediğinize eminmisiniz ?",
                       okCallBack: {
                        self.dismiss(animated: true, completion: {
                          self.delegate?.didDeleteCard()
                        })
                       }, cancelCallBack: {})
  }
  
  @objc func didCloseCard() {
    dismiss(animated: true, completion: {
      if let editingProduct = self.cardViewModel.getEditingProduct() {
        self.delegate?.didUpdateCard(product: editingProduct)
      }
    })
  }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension CardViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cardViewModel.getProductCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CardInProductCell = tableView.dequeueReusableCell(for: indexPath)
    cell.product = cardViewModel.getProduct(row: indexPath.row)
    cell.delegate = self
    return cell
  }

}

extension CardViewController: CardInProductCellDelegate {
  
  func didUpdateProduct(product: Product) {
    cardViewModel.setEditingProdut(product: product)
    cardView.setTotalPrice(totalPrice: cardViewModel.getTotalPrice())
  }
  
  func didRemoveProduct(sender: UITableViewCell) {
    
    guard let indexPath = cardView.tableView.indexPath(for: sender) else { return }
    cardViewModel.deleteProduct(index: indexPath.row)
    cardView.tableView.deleteRows(at: [indexPath], with: .top)
    
    if cardViewModel.isCardEmpty() {
      delegate?.didDeleteCard()
      dismiss(animated: true, completion: nil)
    }
  }
}
