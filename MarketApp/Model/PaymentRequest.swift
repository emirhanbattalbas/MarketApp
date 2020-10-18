import Foundation

struct Payment: Codable {
  var products: [PaymentProduct]?
}

struct PaymentProduct: Codable {
  var id: String?
  var amount: Int?
}
