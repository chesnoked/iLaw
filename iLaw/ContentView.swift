//
//  ContentView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Int
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .tag(1)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill.badge.checkmark")
                }
                .tag(2)
        }
        .accentColor(Color.palette.indigo)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedTab: 1)
    }
}
