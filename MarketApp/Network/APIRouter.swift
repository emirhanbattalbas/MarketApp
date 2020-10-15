import Foundation

enum APIRouter {
  
  case product
}

extension APIRouter: Routable {
  
  var baseURL: URL {
    return URL(string: Constant.Network.baseUrl)!
  }
  
  var path: String {
    switch self {
    case .product:
      return "/list"
    }
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var task: Task? {
    switch self {
    case .product:
      return nil
    default:
      return nil
    }
  }
  
  var headers: Headers? {
    return nil
  }
  
  var parametersEncoding: ParametersEncoding {
    return .url
  }
  
}
