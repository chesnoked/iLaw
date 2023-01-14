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
    @State private var goToHome: Bool = false
    var body: some View {
        ZStack {
            // up layer
            GoToHome()
            // down layer
            VStack(spacing: 0) {
                appLabel
                Welcome()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("canvas"))
    }
}

extension WelcomeView {
    struct WelcomeBlock<Content:View>:View {
        
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        let content: Content
        var body: some View {
            content
                .foregroundColor(Color.palette.mercury)
        }
    }
    private var goToHomeButton: some View {
        Button(action: {
            withAnimation(.linear(duration: 0.12)) {
                goToHome = true
            }
        }, label: {
            Text("get experience ...")
                .font(.system(.title3, design: .rounded, weight: .black))
                .foregroundColor(Color.palette.mercury)
                .padding()
                .background(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(color: .white, radius: 1.23, x: 1, y: -1)
        })
    }
    private func Welcome() -> some View {
        TabView {
            WelcomeBlock {
                Text("Welcome block 1")
            }
            WelcomeBlock {
                Text("Welcome block 2")
            }
            WelcomeBlock {
                goToHomeButton
            }
        }
        .tabViewStyle(.page)
    }
}

extension WelcomeView {
    @ViewBuilder
    private func GoToHome() -> some View {
        if goToHome {
            ContentView(selectedTab: 1)
                .transition(.opacity)
                .zIndex(1)
        }
    }
    private var appLabel: some View {
        VStack(spacing: 15) {
            appLogo
//            appTitle
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .environment(\.colorScheme, .dark)
//        .overlay(alignment: .bottom) {
//            Rectangle()
//                .frame(height: 1)
//                .foregroundColor(.white)
//        }
    }
    private var appLogo: some View {
        Image("app-logo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(0.55)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .fill(Color.white).opacity(0.37).blur(radius: 5)
            }
            .overlay {
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
                        lineWidth: 10.0
                    )
                    .shadow(color: Color.palette.mercury.opacity(0.44), radius: 5, x: 0, y: 0)
            }
    }
    private var appTitle: some View {
        Text("iLaw")
            .font(.system(.title3, design: .monospaced, weight: .semibold))
            .foregroundColor(Color.palette.mercury)
    }
}

