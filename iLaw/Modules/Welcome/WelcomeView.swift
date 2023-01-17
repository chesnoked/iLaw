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
        GeometryReader { geo in
            AppLabel()
                .zIndex(1)
                .position(x: geo.frame(in: .local).midX,
                          y: geo.size.height / 4)
            Welcome(geo)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    private func Welcome(_ geo: GeometryProxy) -> some View {
        TabView {
            WelcomeBlock(geo, "canvas1") {
                Text("Welcome block 1")
            }
            WelcomeBlock(geo, "canvas2") {
                Text("Welcome block 2")
            }
            WelcomeBlock(geo, "canvas3") {
                goToHomeButton
            }
        }
        .tabViewStyle(.page)
    }
    struct WelcomeBlock<Content:View>:View {
        
        init(_ geo: GeometryProxy, _ image: String, @ViewBuilder content: () -> Content) {
            self.geo = geo
            self.image = image
            self.content = content()
        }
        let geo: GeometryProxy
        let content: Content
        let image: String
        var body: some View {
            content
                .font(.system(size: 24, weight: .light, design: .rounded))
                .foregroundColor(Color.palette.mercury)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .background(Color.palette.lead)
                .divider(.top)
                .divider(.bottom)
                .position(x: geo.size.width / 2,
                          y: geo.size.height * 3 / 4)
                .background(
                    ZStack {
                        Image(image)
                        Color.black.opacity(0.37).blur(radius: 5)
                    }
                )
        }
    }
}

// MARK: Welcome
extension WelcomeView {
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
}

// MARK: App label
extension WelcomeView {
    private func AppLabel() -> some View {
        VStack(spacing: 15) {
            AppLogo()
//            AppTitle()
        }
    }
    private func AppLogo() -> some View {
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
                            Color.palette.lead,
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
    private func AppTitle() -> some View {
        Text("iLaw")
            .font(.system(.title3, design: .monospaced, weight: .semibold))
            .foregroundColor(Color.palette.mercury)
    }
}

extension WelcomeView {
    @ViewBuilder
    private func GoToHome() -> some View {
        if goToHome {
            HomeView()
                .transition(.opacity)
                .zIndex(1)
        }
    }
}

