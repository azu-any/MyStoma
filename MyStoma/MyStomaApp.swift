//
//  MyStomaApp.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI


import SwiftUI

extension Font {
    static func customAppFont(forTextStyle style: TextStyle) -> Font {
        // Replace "YourFontName-Regular" with your font's name
        let fontName = "OpenDyslexic-Regular"
        
        // Get the UIFont for dynamic type size
        let uiFont = UIFont(name: fontName, size: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(style)).pointSize)!
        
        return Font(uiFont)
    }
}

extension UIFont.TextStyle {
    init(_ style: Font.TextStyle) {
        switch style {
        case .largeTitle: self = .largeTitle
        case .title: self = .title1
        case .title2: self = .title2
        case .title3: self = .title3
        case .headline: self = .headline
        case .subheadline: self = .subheadline
        case .callout: self = .callout
        case .caption: self = .caption1
        case .caption2: self = .caption2
        case .footnote: self = .footnote
        default: self = .body
        }
    }
}

struct AppFontModifier: ViewModifier {
    let useCustomFont: Bool
    let style: Font.TextStyle

    func body(content: Content) -> some View {
        content.font(useCustomFont ? Font.customAppFont(forTextStyle: style) : Font.system(style))
    }
}

extension View {
    func appFont(_ style: Font.TextStyle, useCustomFont: Bool) -> some View {
        self.modifier(AppFontModifier(useCustomFont: useCustomFont, style: style))
    }
}





@main
struct MyStomaApp: App {

    @State private var appModel = AppModel()
    @StateObject var viewModel = OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
    @StateObject var router = NavigationRouter()
    @AppStorage("useDyslexiaFont") var useDyslexiaFont: Bool = false
    
    @StateObject private var itemModel = ItemModel()


    var body: some Scene {
        
        // Menu
        WindowGroup() {
            ContentView()
                .environment(appModel)
                .environmentObject(viewModel)
                //.environment(\.font, Font.customAppFont(forTextStyle: .body))
                .appFont(.body, useCustomFont: useDyslexiaFont)
                .environmentObject(itemModel)

                //.environment(\.font, useDyslexiaFont ? .custom("OpenDyslexic-Regular", size: 17) : .body)

            

        }
        
        #if os(visionOS)
        ImmersiveSpace(id: "item-view") {
            ItemVRView()
                .environmentObject(itemModel)
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)

        ImmersiveSpace(id: ColostomySpace.first.id) {
            ColostomyFirstView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)

        ImmersiveSpace(id: ColostomySpace.second.id) {
            ColostomySecondView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
       
        ImmersiveSpace(id: ColostomySpace.third.id) {
            ColostomyThirdView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
       
        ImmersiveSpace(id: ColostomySpace.fourth.id) {
            ColostomyFourthView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: ColostomySpace.fifth.id) {
            ColostomyFifthView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        #endif
        
        
     }
}
