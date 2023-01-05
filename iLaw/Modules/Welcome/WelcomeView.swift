//
//  WelcomeView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 05.01.2023.
//

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                appLogoSubView
                    .position(x: geo.frame(in: .local).midX,
                              y: geo.frame(in: .local).midY)
                Spacer()
                TabView {
                    ForEach(1..<4, id: \.self) { i in
                        Text("Welcome title \(i)")
                            .font(.headline)
                            .foregroundColor(Color.palette.indigo)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: geo.size.height / 2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.palette.lead)
    }
}

extension WelcomeView {
    private var appLogoSubView: some View {
        VStack(spacing: 15) {
            // app logo
            Circle()
                .stroke(
                    LinearGradient(colors: .init([
                        .clear,
                        Color.palette.mercury,
                        .clear
                    ]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    ,
                    lineWidth: 5.0
                )
                .frame(width: 75, height: 75)
                .shadow(color: Color.palette.mercury.opacity(0.44), radius: 5, x: 0, y: 0)
            // app title
            Text("iLaw")
                .font(.system(.title3, design: .monospaced, weight: .semibold))
                .foregroundColor(Color.palette.mercury)
        }
    }
}

