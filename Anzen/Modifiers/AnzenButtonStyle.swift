//
//  AnzenButtonStyle.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct AnzenButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.mountainFig)
            .frame(width: 100, height: 30)
            .buttonStyle(.plain)
            .background(.white)
            .cornerRadius(5)
    }
}
