//
//  AnzenErrors.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import Foundation

enum AnzenErrors: Error {
    case unableToCreateDecodeStream
    case unableToGetHeaderField
    case zeroDataSize
    case unableToCreateFileStream
    case unableToCreateEncryptionStream
    case unableToCreateDecryptionContext
}
