//
//  DialogSheetView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI
import System

struct DialogSheetView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var anzenSettings: AnzenSettings
    @State var passwordForKey: String = ""
    @State private var showingErrorSheet = false
    @State private var errorMessage: String = ""

    var body: some View {
        content
            .sheet(isPresented: $showingErrorSheet) {
                ErrorSheetView(errorMessage: errorMessage)
            }
            .frame(width: 400, height: 240)
    }

    @ViewBuilder var content: some View {
        ZStack {

            BackgroundView()

            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    // Close button view on top left corner
                    CloseViewButton()
                        .padding(.top, 20)
                        .padding(.leading, 15)

                    Spacer()

                    // Message depending on encrypt or decrypt
                    DialogSheetTitleTextView()
                        .environmentObject(anzenSettings)

                    // Password secure text field
                    DialogSheetTextFieldView(passwordForKey: $passwordForKey)

                    // Show if the error message if password lenght is 0
                    DialogSheetErrorView()
                        .opacity(passwordForKey.count == 0 ? 1 : 0)
                    Spacer()
                }

                HStack {
                    // Encrypt or decrypt button
                    DialogSheetEncryptButtonView(errorMessage: $errorMessage,
                                                 showingErrorSheet: $showingErrorSheet,
                                                 passwordForKey: $passwordForKey)
                        .disabled(passwordForKey.count == 0 ? true : false)  // If there is no password, no party
                        .modifier(AnzenButtonStyle())

                    Spacer()

                    // Cancel button
                    DialogSheetCancelButtonView()
                        .modifier(AnzenCancelButtonStyle())
                }
                .padding(.horizontal, 50)
                Spacer()
            }

        }
    }
}

struct DialogSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DialogSheetView()
    }
}
