import Foundation

typealias Parameters = [String: Any]

enum Task {
  case plain
  case parameters(Parameters)
  //TODO: Will add download and upload tasks
}
