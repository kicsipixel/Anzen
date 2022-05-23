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
    @Binding var passwordForKey: String
    @State private var showingErrorSheet = false
    @State private var errorMessage: String = ""
    let willEncrypt: Bool
    let sourceFilePath: FilePath
    let destinationFilePath: FilePath

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
                    CloseViewButton()
                        .padding(.top, 20)
                        .padding(.leading, 15)
                    Spacer()
                    DialogSheetTitleTextView(willEncrypt: willEncrypt)
                    DialogSheetTextFieldView(passwordForKey: $passwordForKey)
                    // Show if the error message if password lenght is 0
                    DialogSheetErrorView()
                        .opacity(passwordForKey.count == 0 ? 1 : 0)
                    Spacer()
                }

                HStack {
                    Button {
                        if willEncrypt {
                            do {
                                try encryptFile(key: keyFromPassword(passwordForKey),
                                                sourceFilePath: sourceFilePath,
                                                destinationFilePath: destinationFilePath)
                            } catch {
                                errorMessage = error.localizedDescription
                                showingErrorSheet.toggle()
                                return
                            }
                        } else {
                            do {
                                try decryptFile(key: keyFromPassword(passwordForKey),
                                                sourceFilePath: sourceFilePath,
                                                destinationFilePath: destinationFilePath)
                            } catch {
                                errorMessage = error.localizedDescription
                                showingErrorSheet.toggle()
                                return
                            }
                        }
                        // Clear text field value
                        passwordForKey = ""
                        dismiss.callAsFunction()
                    } label: {
                        Text(willEncrypt ? "Encrypt" : "Decrypt")
                            .foregroundColor(.mountainFig)
                    }
                    // If there is no password, no party
                    .disabled(passwordForKey.count == 0 ? true : false)
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
        DialogSheetView(passwordForKey: .constant(""),
                        willEncrypt: true,
                        sourceFilePath: FilePath(),
                        destinationFilePath: FilePath())
    }
}
