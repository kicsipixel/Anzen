//
//  ErrorSheetView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct ErrorSheetView: View {

    @Environment(\.dismiss) private var dismiss
    let errorMessage: String

    var body: some View {
        content
            .frame(width: 230, height: 220)
    }

    @ViewBuilder var content: some View {
        VStack {
            Image("errorIcon")
                .padding(.top, 8)

            Text("Error..:(")
                .bold()
                .padding(.vertical, 5)

            Text("\(errorMessage)")
                .lineLimit(.none)
                .padding(.horizontal, 10)

            Button {
                dismiss.callAsFunction()
            } label: {
                Text("Okay")
            }
            .modifier(AnzenOkayButtonStyle())
            .padding(.bottom, 8)
        }
        .foregroundColor(.mountainFig)
    }
}

struct ErrorSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorSheetView(errorMessage: "Sorry, a system error occured.")
    }
}
