//
//  HomeView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geo in
            navBarSubView
            VStack {
                // content page
                Text("home".capitalized)
                    .font(.system(.largeTitle, design: .rounded, weight: .black))
                    .foregroundColor(Color.palette.mercury)
            }
            .position(x: geo.frame(in: .local).midX,
                      y: geo.frame(in: .local).midY)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.palette.lead)
    }
    private var navBarSubView: some View {
        Text("home".capitalized)
            .font(.system(.largeTitle, design: .rounded, weight: .black))
            .foregroundColor(Color.palette.mercury)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.palette.indigo)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
