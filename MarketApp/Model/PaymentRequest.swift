import Foundation

struct Payment: Codable {
  var products: [PaymentProduct]?
}

struct PaymentProduct: Codable {
  var id: String?
  var amount: Int?
}

extension Payment {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
