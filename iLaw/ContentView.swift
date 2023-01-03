//
//  ContentView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill.badge.checkmark")
                }
        }
        .accentColor(Color.palette.child)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
