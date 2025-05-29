import SwiftUI

enum Route: Hashable {
    case play
    case colostomy
    case settings
}

class NavigationRouter: ObservableObject {
    @Published var path: [Route] = []

    func destination(for route: Route) -> AnyView {
        switch route {
        case .play:
            AnyView(PlayView())
        case .colostomy:
            AnyView(ColostomyView())
        case .settings:
            AnyView(AppSettingsView())
        }
    }
}
