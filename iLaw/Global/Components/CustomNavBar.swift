//
//  CustomNavBar.swift
//  iLaw
//
//  Created by Evgeniy Safin on 17.01.2023.
//

//struct CustomNavBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomNavBar()
//    }
//}

import SwiftUI

struct CustomNavBar: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 42, weight: .black, design: .rounded))
            .foregroundColor(Color.palette.mercury)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.palette.indigo)
            .divider(.bottom)
    }
}

extension View {
    func divider(linewidth: CGFloat = 1.0, _ alignment: Alignment) -> some View {
        self
            .overlay(alignment: alignment) {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [
                            .clear,
                            Color.white,
                            .clear
                        ]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .frame(height: linewidth)
            }
    }
}
