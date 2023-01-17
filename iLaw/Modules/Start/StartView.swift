//
//  StartView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

import SwiftUI

struct StartView: View {
    var body: some View {
        GeometryReader { _ in
            CustomNavBar(title: "Start")
        }
        .background(Color.palette.lead)
    }
}
