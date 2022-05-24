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
    @State private var willEncrypt = true
    @State private var sourceFilePath = FilePath()
    @State private var destinationFilePath = FilePath()
    @StateObject var anzenSettings = AnzenSettings()
    var urlsForFileParth: [URL] = []

    var body: some View {
        content
            .sheet(isPresented: $showingDialogSheet) {
                DialogSheetView()
                    .environmentObject(anzenSettings)
            }
    }

    @ViewBuilder var content: some View {
        VStack {
            DropZoneImageView()
                .onDrop(of: [.fileURL, .item], isTargeted: nil, perform: { providers, _ in
                    _ = providers.first!.loadObject(ofClass: NSPasteboard.PasteboardType.self) { pasteboardItem, _ in

                        guard let pasteboardItem = pasteboardItem else {
                            return
                        }

                        // Let's process the dropped file
                        anzenSettings.convertUrlToFilePath(pasteboardItem.rawValue)
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
