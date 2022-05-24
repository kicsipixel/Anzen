//
//  DialogSheetEncryptButtonView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 24.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct DialogSheetEncryptButtonView: View {

    @EnvironmentObject var anzenSettings: AnzenSettings
    @Environment(\.dismiss) private var dismiss
    @Binding var errorMessage: String
    @Binding var showingErrorSheet: Bool
    @Binding var passwordForKey: String

    var body: some View {
        content
    }

    @ViewBuilder var content: some View {
        Button {
            if anzenSettings.willEncrypt {
                do {
                    try encryptFile(key: keyFromPassword(passwordForKey),
                                    sourceFilePath: anzenSettings.sourceFilePath,
                                    destinationFilePath: anzenSettings.destinationFilePath)
                } catch {
                    errorMessage = error.localizedDescription
                    showingErrorSheet.toggle()
                    return
                }
            } else {
                do {
                    try decryptFile(key: keyFromPassword(passwordForKey),
                                    sourceFilePath: anzenSettings.sourceFilePath,
                                    destinationFilePath: anzenSettings.destinationFilePath)
                } catch {
                    errorMessage = error.localizedDescription
                    showingErrorSheet.toggle()
                    return
                }
            }
            // Clear text field value
            passwordForKey = ""
            // Remove sheet
            dismiss.callAsFunction()
        } label: {
            Text(anzenSettings.willEncrypt ? "Encrypt" : "Decrypt")
                .foregroundColor(.mountainFig)
        }
    }
}

struct DialogSheetEncryptButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DialogSheetEncryptButtonView(errorMessage: .constant("Error happened..."),
                                     showingErrorSheet: .constant(true),
                                     passwordForKey: .constant("secret"))
    }
}
