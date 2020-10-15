import Foundation
import UIKit

class MainViewModel {
  
  private var product: [Product] = []
  
  init(view: MainView) {
    API.shared.product { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(product):
        self.product = product
        view.collectionView.reloadData()
      case let .failure(error):
        print(error)
      }
    }
  }
  
  func getProduct(row: Int) -> Product {
//    guard product.count > 0 else { return nil }
    return product[row]
  }
  
  
  func getProductCount() -> Int {
    return product.count
  }
}
