import Foundation
final class API {
  
  static let shared = API()
  
  private let router = APIRouter.self
  
  func product(completion: @escaping (APIResponse<[Product]>) -> ()) {
    APIClient.shared.request(responseType: [Product].self, router: router.product, completion: completion)
  }

}
