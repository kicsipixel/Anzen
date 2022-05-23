//
//  DialogSheetErrorView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct DialogSheetErrorView: View {
    var body: some View {
        content
    }

    @ViewBuilder var content: some View {
        Text("Your password cannot be empty.")
            .bold()
            .foregroundColor(.red)
            .padding(.leading)
    }
}

struct DialogSheetErrorView_Previews: PreviewProvider {
    static var previews: some View {
        DialogSheetErrorView()
    }
}
