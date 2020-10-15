import Foundation

class Product: Codable {
  var id: String
  var name: String
  var price: Double
  var amount: String {
    return String(price) + (currency ?? "")
  }
  var currency: String?
  var imageUrl: String?
  var stock: Int = 0
}
