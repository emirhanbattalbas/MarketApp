import Foundation
import UIKit

class MainViewModel {
  
  private var products: [Product] = []
  
  init(view: MainView) {
    API.shared.product { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(products):
        self.products = products
        for i in 0..<self.products.count {
          self.products[i].selectedCount = 0
        }
        view.collectionView.reloadData()
      case let .failure(error):
        print(error)
      }
    }
  }
    
  func getProduct(row: Int) -> Product {
    return products[row]
  }
  
  func getProductCount() -> Int {
    return products.count
  }
  
  func getProductList() -> [Product] {
    return products
  }
  
  func removeAllSelectedProduct() {
    products.forEach { product in
      product.selectedCount = 0
    }
  }
  
  func editProduct(newProduct: Product) {
    for i in 0..<products.count {
      if products[i].id == newProduct.id {
        products[i] = newProduct
      }
    }
  }
  
  func cardBadgeCount() -> Int {
    return products.map { ($0.selectedCount ?? 0) }.reduce(0, +)
  }
}
