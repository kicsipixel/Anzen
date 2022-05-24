//
//  AnzenSettings.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 24.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import Foundation
import System

class AnzenSettings: ObservableObject {
    @Published var sourceFilePath = FilePath()
    @Published var destinationFilePath = FilePath()
    @Published var willEncrypt = true

    func convertUrlToFilePath(_ urlString: String) {
        if let sourceFileURL = URL(string: urlString) {
            // Encrypt or decrypt
            if FilePath(sourceFileURL.path).extension != "encrypt" {
                DispatchQueue.main.async {
                    // Set source file
                    self.sourceFilePath = FilePath(sourceFileURL.path)

                    // Set destination file
                    if let destinationFileURL = URL(string: urlString) {
                        self.destinationFilePath = FilePath(destinationFileURL.path.appending(".encrypt"))
                    }

                    // Check the bool value
                    if !self.willEncrypt {
                        self.willEncrypt.toggle()
                    }
                }
            } else {
                if let destinationFileURLNoExtension = URL(string: urlString) {
                    // Remove .encrypt extension
                    let  newDestibnationFileULR = destinationFileURLNoExtension
                    if let destionationFileURL = URL(string: "\(newDestibnationFileULR.deletingPathExtension())") {
                        DispatchQueue.main.async {
                            // Set source file
                            self.sourceFilePath = FilePath(sourceFileURL.path)

                            // Set destination file
                            self.destinationFilePath = FilePath(destionationFileURL.path)

                            // Check the bool value
                            if self.willEncrypt {
                                self.willEncrypt.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}
