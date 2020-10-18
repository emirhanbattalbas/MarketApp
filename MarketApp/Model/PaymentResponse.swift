import Foundation

struct PaymentResponse: Codable {
  var orderID: String?
  var message: String?
  var error: String?
}
