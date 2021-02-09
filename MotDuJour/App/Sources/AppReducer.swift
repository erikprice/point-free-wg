import Foundation

enum AppReducer {
  static func appReducer(value: inout AppState, action: AppAction) {
    switch action {
    case .home(.didTapLanguage(let language)):
      value.currentLanguage = language
    case .home(_):
      break
    case .recents(_):
      break
    case .favorites(_):
      break
    case .word(_):
      break
    }
  }
}