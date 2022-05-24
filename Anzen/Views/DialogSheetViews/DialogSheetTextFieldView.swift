//
//  DialogSheetTextFieldView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct DialogSheetTextFieldView: View {

    @Binding var passwordForKey: String

    var body: some View {
        content
    }

    @ViewBuilder var content: some View {
        SecureField("Your secret password here...", text: $passwordForKey)
            .font(.title2)
            .foregroundColor(.mountainFig)
            .padding(.leading, 25)
            .frame(minHeight: 50)
            .textFieldStyle(PlainTextFieldStyle())
            .background(
                ZStack {
                    Color.white
                    HStack {
                        Image(systemName: "key")
                            .font(.title2)
                            .padding(.leading, 5)
                        // Color of the icon changes if user starts typing
                            .foregroundColor(passwordForKey.count > 0 ? .mountainFig : .gray.opacity(0.8))
                        Spacer()
                    }
                })
            .cornerRadius(5)
            .padding(.horizontal)
    }
}

struct DialogSheetTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        DialogSheetTextFieldView(passwordForKey: .constant("Your secret password here..."))
    }
}
