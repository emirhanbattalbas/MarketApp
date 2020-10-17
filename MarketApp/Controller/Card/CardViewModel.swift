import Foundation
import UIKit

class CardViewModel {
  private var selectedProducts: [Product]
  private var editingProduct: Product?
  
  init(selectedProducts: [Product]) {
    self.selectedProducts = selectedProducts.filter { $0.selectedCount != nil }
  }
  
  func getProductCount() -> Int {
    return selectedProducts.count
  }
  
  func getProduct(row: Int) -> Product {
    return selectedProducts[row]
  }
    
  func setEditingProdut(product: Product) {
    editingProduct = product
  }
  
  func getEditingProduct() -> Product? {
    return editingProduct
  }
  
  func deleteProduct(index: Int) {
    selectedProducts.remove(at: index)
  }
  
  func isCardEmpty() -> Bool {
    return selectedProducts.count == 0
  }
}
