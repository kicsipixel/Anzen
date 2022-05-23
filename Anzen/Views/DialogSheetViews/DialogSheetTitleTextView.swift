//
//  DialogSheetTitleTextView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct DialogSheetTitleTextView: View {

    let willEncrypt: Bool

    var body: some View {
        content
    }

    @ViewBuilder var content: some View {
        Text(willEncrypt ? "Please, set a password for your encrypted file." : "Please, give your password to decrypt the file.")
            .font(.title3)
            .padding(.horizontal)
            .foregroundColor(.white)
    }
}

struct DialogSheetTitleTextView_Previews: PreviewProvider {
    static var previews: some View {
        DialogSheetTitleTextView(willEncrypt: true)
    }
}
