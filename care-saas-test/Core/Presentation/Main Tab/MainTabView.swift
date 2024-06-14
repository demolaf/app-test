//
//  MainTabView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

enum Tabs {
    case home
    case search
    case account
}
struct MainTabView: View {
    var body: some View {
        TabView {                
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tint(.appPrimary)
                .tag(Tabs.home)
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tabs.search)
            AccountView()
                .tabItem {
                    Label("Account", image: "AccountIconPlaceholder")
                }
                .tag(Tabs.search)
        }
    }
}

#Preview {
    MainTabView()
}
