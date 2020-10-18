import Foundation
import UIKit

class CardViewModel {
  private var selectedProducts: [Product]
  private var editingProduct: Product?
  private var paymentProduct: [PaymentProduct] = []
  
  init(selectedProducts: [Product]) {
    self.selectedProducts = selectedProducts.filter { $0.selectedCount != 0 }
    self.selectedProducts.forEach { product in
      paymentProduct.append(PaymentProduct(id: product.id, amount: product.selectedCount))
    }
  }
  
  func payment(completion: @escaping (PaymentResponse)->()) {
    API.shared.payment(body: Payment(products: paymentProduct)) { (result) in
      switch result {
      case .success(let response):
        completion(response)
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func getProductCount() -> Int {
    return selectedProducts.count
  }
  
  func getProduct(row: Int) -> Product {
    return selectedProducts[row]
  }
  
  func getTotalPrice() -> String {
    return String(selectedProducts
                    .map { Double($0.selectedCount ?? 0)*($0.price) }
                    .reduce(0.0, +))
  }
  
  func setEditingProdut(product: Product) {
    paymentProduct = paymentProduct.filter { $0.id != product.id }
    paymentProduct.append(PaymentProduct(id: product.id,
                                         amount: product.selectedCount))
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
  
  func clearCard() {
    selectedProducts.removeAll()
  }
}
