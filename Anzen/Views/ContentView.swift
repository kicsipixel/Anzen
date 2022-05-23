//
//  ContentView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        content
    }

    @ViewBuilder var content: some View {
        ZStack {
            BackgroundView()
            DropZoneView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
