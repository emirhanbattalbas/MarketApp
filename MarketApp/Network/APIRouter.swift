import Foundation

enum APIRouter {
  
  case product
  case payment(body: Payment)
}

extension APIRouter: Routable {
  
  var baseURL: URL {
    return URL(string: Constant.Network.baseUrl)!
  }
  
  var path: String {
    switch self {
    case .product:
      return "/list"
    case .payment:
      return "/checkout"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .product:
      return .get
    case .payment:
      return .post
    }
  }
  
  var task: Task? {
    switch self {
    case .product:
      return nil
    case let .payment(payment):
      return .parameters(payment.convertToJson!)
    }
  }
  
  var headers: Headers? {
    switch self {
    case .product:
      return nil
    case .payment:
      let header : [String:String] = ["Content-Type":"application/json"]
      return header
    }
  }
  
  var parametersEncoding: ParametersEncoding {
    switch self {
    case .product:
      return .url
    case .payment:
      return .json
    }
  }
}
