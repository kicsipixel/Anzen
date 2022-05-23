//
//  AnzenOkayButtonStyle.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct AnzenOkayButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.mountainFig)
            .frame(width: 100, height: 30)
            .buttonStyle(.plain)
            .background(RoundedRectangle(cornerRadius: 5, style: .continuous)
                .stroke(Color.mountainFig, lineWidth: 1))
    }
}
