//
//  DropZoneView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import System
import SwiftUI

struct DropZoneView: View {

    @State private var showingDialogSheet = false
    @State private var passwordForKey = ""
    @State private var willEncrypt = true
    @State private var sourceFilePath = FilePath()
    @State private var destinationFilePath = FilePath()

    var body: some View {
        content
            .sheet(isPresented: $showingDialogSheet) {
                DialogSheetView(passwordForKey: $passwordForKey,
                                willEncrypt: willEncrypt,
                                sourceFilePath: sourceFilePath,
                                destinationFilePath: destinationFilePath)
            }
    }

    @ViewBuilder var content: some View {
        VStack {
            Image("safeImage")
                .onDrop(of: [.fileURL, .item], isTargeted: nil, perform: { providers, _ in
                    _ = providers.first!.loadObject(ofClass: NSPasteboard.PasteboardType.self) { pasteboardItem, _ in

                        guard let pasteboardItem = pasteboardItem else {
                            return
                        }

                        if let sourceFileURL = URL(string: pasteboardItem.rawValue) {
                            sourceFilePath = FilePath(sourceFileURL.path)
                        }

                        if sourceFilePath.extension == "encrypt" {
                            willEncrypt.toggle()
                            // We need to remove the .encrypt but it seems to be super complex...
                            if let destinationFileURLNoExtension = URL(string: pasteboardItem.rawValue) {
                                let  newDestibnationFileULR = destinationFileURLNoExtension
                                if let destionationFileURL = URL(string: "\(newDestibnationFileULR.deletingPathExtension())") {
                                    destinationFilePath = FilePath(destionationFileURL.path)
                                }
                            }
                        } else {
                            if let destionationFileURL = URL(string: "\(URL(string: pasteboardItem.rawValue)!).encrypt") {
                                destinationFilePath = FilePath(destionationFileURL.path)
                            }
                        }
                    }
                    showingDialogSheet.toggle()
                    return true
                })
        }
    }
}

struct DropZoneView_Previews: PreviewProvider {
    static var previews: some View {
        DropZoneView()
    }
}
