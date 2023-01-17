//
//  HomeView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

import SwiftUI

enum TabBarItems: String, CaseIterable {
//    case welcome = "w.circle.fill"
    case start = "graduationcap.circle.fill"
    case profile = "person.crop.circle.fill.badge.checkmark"
}

struct HomeView: View {
    @State private var selectedTab: TabBarItems = .start
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Pages()
                TabBar()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.palette.lead)
    }
}

extension HomeView {
    @ViewBuilder
    private func Pages() -> some View {
        switch selectedTab {
        case .start:
            StartView()
        case .profile:
            ProfileView()
        default:
            WelcomeView()
        }
    }
    private func TabBar() -> some View {
        HStack(spacing: 15) {
            ForEach(TabBarItems.allCases, id: \.self) { tab in
                Image(systemName: tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .foregroundColor(selectedTab == tab ? Color.palette.mercury : Color.palette.lead)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        self.selectedTab = tab
                    }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.palette.indigo)
        .divider(.top)
    }
}
