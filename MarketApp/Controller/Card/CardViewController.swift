import UIKit

class CardViewController: UIViewController {
  
  @IBOutlet var cardView: CardView!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    cardView.registerCell()
    customizeNavigation()
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
    dismiss(animated: true, completion: {
    })
  }
  
  @objc func didCloseCard() {
    dismiss(animated: true, completion: nil)
  }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension CardViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CardInProductCell = tableView.dequeueReusableCell(for: indexPath)
    return cell
  }
}
