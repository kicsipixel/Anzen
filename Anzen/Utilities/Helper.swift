//
//  Helper.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//
// Source: https://developer.apple.com/documentation/applearchive/encrypting_and_decrypting_a_single_file

import AppleArchive
import CryptoKit
import Foundation
import System

// MARK: - Encrypt file
func encryptFile(key: SymmetricKey,
                 sourceFilePath: FilePath,
                 destinationFilePath: FilePath) throws {

    let context = ArchiveEncryptionContext(profile: .hkdf_sha256_aesctr_hmac__symmetric__none,
                                           compressionAlgorithm: .lzfse)
    try context.setSymmetricKey(key)

    guard let sourceFileStream = ArchiveByteStream.fileStream(
        path: sourceFilePath,
        mode: .readOnly,
        options: [ ],
        permissions: FilePermissions(rawValue: 0o644)),
          let destinationFileStream = ArchiveByteStream.fileStream(
            path: destinationFilePath,
            mode: .writeOnly,
            options: [ .create, .truncate ],
            permissions: FilePermissions(rawValue: 0o644)) else {
        throw AnzenErrors.unableToCreateFileStream
    }

    guard let encryptionStream = ArchiveByteStream.encryptionStream(
        writingTo: destinationFileStream,
        encryptionContext: context) else {
        throw AnzenErrors.unableToCreateEncryptionStream
    }

    _ = try ArchiveByteStream.process(readingFrom: sourceFileStream,
                                      writingTo: encryptionStream)

    try encryptionStream.close()
    try sourceFileStream.close()
    try destinationFileStream.close()
}

// MARK: - Decrypt file
func decryptFile(key: SymmetricKey,
                 sourceFilePath: FilePath,
                 destinationFilePath: FilePath) throws {

    guard let sourceFileStream = ArchiveByteStream.fileStream(
        path: sourceFilePath,
        mode: .readOnly,
        options: [ ],
        permissions: FilePermissions(rawValue: 0o644)) else {
        throw AnzenErrors.unableToCreateFileStream
    }

    guard let decryptionContext = ArchiveEncryptionContext(from: sourceFileStream) else {
        throw AnzenErrors.unableToCreateDecryptionContext
    }

    try decryptionContext.setSymmetricKey(key)

    guard let decryptionStream = ArchiveByteStream.decryptionStream(
        readingFrom: sourceFileStream,
        encryptionContext: decryptionContext) else {
        throw AnzenErrors.unableToCreateFileStream
    }

    guard let decryptedFileStream = ArchiveByteStream.fileStream(
        path: destinationFilePath,
        mode: .writeOnly,
        options: [ .create, .truncate ],
        permissions: FilePermissions(rawValue: 0o644)) else {
        throw AnzenErrors.unableToCreateFileStream
    }

    _ = try ArchiveByteStream.process(readingFrom: decryptionStream,
                                      writingTo: decryptedFileStream)

    try decryptedFileStream.close()
    try sourceFileStream.close()
    try decryptedFileStream.close()
}

// MARK: - Create key from user's password
// This is not from Apple...
func keyFromPassword(_ password: String) -> SymmetricKey {
    let hash = SHA256.hash(data: password.data(using: .utf8)!)
    let hashString = hash.map { String(format: "%02hhx", $0) }.joined()
    let subString = String(hashString.prefix(32))
    let keyData = subString.data(using: .utf8)!

    return SymmetricKey(data: keyData)
}
