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
            LinearGradient(colors: [.mountainFig, .closedShutter],
                           startPoint: .top,
                           endPoint: .bottom)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
