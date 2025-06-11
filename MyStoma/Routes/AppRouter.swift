import SwiftUI

enum Route: Hashable {
    case colostomy
    case colostomyVR
    case settings
}

class NavigationRouter: ObservableObject {
    @Published var path: [Route] = []

    func destination(for route: Route) -> AnyView {
        switch route {
        case .colostomy:
            AnyView(ColostomyView())
        case .colostomyVR:
            AnyView(InfoVPView())
        case .settings:
            AnyView(AppSettingsView())
        }
    }
}
