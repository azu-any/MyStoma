import SwiftUI

enum Route: Hashable {
    case play
    case tools
    case colostomy
}

class NavigationRouter: ObservableObject {
    @Published var path: [Route] = []

    func destination(for route: Route) -> AnyView {
        switch route {
        case .play:
            AnyView(PlayView())
        case .tools:
            AnyView(ToolsView())
        case .colostomy:
            AnyView(ColostomyView())
        }
    }
}
