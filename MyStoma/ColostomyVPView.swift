//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ColostomyVPView: View {
    
    #if !os(macOS) && !os(tvOS)
    @AppStorage("sidebarCustomizations") var tabViewCustomization: TabViewCustomization
    #endif
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @Namespace private var namespace
    @State private var selectedTab: Tabs = .watchNow

    var body: some View {

        TabView(selection: $selectedTab) {
            Tab(Tabs.watchNow.name, systemImage: Tabs.watchNow.symbol, value: .watchNow) {
                BagRemovalVPView()
            }
            /*.customizationID(Tabs.watchNow.customizationID)
            // Disable customization behavior on the watchNow tab to ensure that the tab remains visible.
            #if !os(macOS) && !os(tvOS)
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            #endif*/
            
            Tab(Tabs.library.name, systemImage: Tabs.library.symbol, value: .library) {
                ContentView()
            }
            /*.customizationID(Tabs.library.customizationID)
            // Disable customization behavior on the library tab to ensure that the tab remains visible.
            #if !os(macOS) && !os(tvOS)
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            #endif*/
            
            Tab(Tabs.new.name, systemImage: Tabs.new.symbol, value: .new) {
                Text("This view is intentionally blank")
            }
            .customizationID(Tabs.new.customizationID)
            
            Tab(Tabs.favorites.name, systemImage: Tabs.favorites.symbol, value: .favorites) {
                Text("This view is intentionally blank")
            }
            .customizationID(Tabs.favorites.customizationID)
            
            Tab(value: .search, role: .search) {
                Text("This view is intentionally blank")
            }
            .customizationID(Tabs.search.customizationID)
            #if !os(macOS) && !os(tvOS)
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            #endif

        }
        //.tabViewStyle(.sidebarAdaptable)
        .tabViewStyle(.page(indexDisplayMode: .never))
        #if !os(macOS) && !os(tvOS)
        .tabViewCustomization($tabViewCustomization)
        #endif
    }
}

#Preview(windowStyle: .automatic) {
    ColostomyVPView()
        .environment(AppModel())
}
