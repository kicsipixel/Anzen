//
//  BackgroundView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        content
    }
    
    @ViewBuilder var content: some View {
        ZStack {
            Color(red: 51/255, green: 51/255, blue: 51/255)
            RadialGradient(colors: [.black.opacity(0.58), .white.opacity(0.5)],
                           center: .center,
                           startRadius: 5,
                           endRadius: 1000)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
