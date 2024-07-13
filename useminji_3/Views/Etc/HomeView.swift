//
//  HomeView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 08/06/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                        .foregroundColor(.yellow)
                }
            ProjectView()
                .tabItem {
                    Label("Projects", systemImage: "sparkles.rectangle.stack.fill")
                        .foregroundColor(.yellow)
                }
            ClientView()
                .tabItem {
                    Label("Clients", systemImage: "figure.gymnastics")
                        .foregroundColor(.yellow)
                }
        }
        .accentColor(.yellow500)
    }
}

#Preview {
    HomeView()
}
