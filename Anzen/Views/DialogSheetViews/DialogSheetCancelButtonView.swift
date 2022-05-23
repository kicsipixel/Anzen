//
//  DialogSheetCancelButtonView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct DialogSheetCancelButtonView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        content
    }

    @ViewBuilder var content: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            Text("Cancel")
        }
    }
}

struct DialogSheetCancelButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DialogSheetCancelButtonView()
    }
}
