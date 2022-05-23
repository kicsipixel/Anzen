//
//  CloseViewButton.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct CloseViewButton: View {

    @State private var overText = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        content
            .background(Color.mountainFig)
    }

    @ViewBuilder var content: some View {

        Image("closeIcon")
            .resizable()
            .frame(width: 15, height: 15)
            .scaledToFit()
            .cornerRadius(25)
            .foregroundColor(overText ? .white : Color.black)
            .background(Color.mountainFig)
            .onTapGesture {
                dismiss.callAsFunction()
            }
            .onHover { over in
                overText = over
            }
    }
}

struct CloseViewButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseViewButton()
    }
}
