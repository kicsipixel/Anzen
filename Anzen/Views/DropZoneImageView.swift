//
//  DropZoneImageView.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct DropZoneImageView: View {
    
    @State private var waveOffset = Angle(degrees: 0)
    let percent: Int = 49
    
    var body: some View {
        content
            .frame(width: 150, height: 150)
    }
    
    @ViewBuilder var content: some View {
        ZStack {
           Circle()
                .fill(LinearGradient(colors: [.mountainFig, .closedShutter], startPoint: .top, endPoint: .bottom))
                .shadow(color: .black.opacity(0.19), radius: 4, x: 0, y: -4)
                .shadow(color: .white.opacity(0.19), radius: 2, x: 0, y: 4)
                .overlay(
                    Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                        .fill(Color.mountainFig.opacity(0.4))
                        .clipShape(Circle().scale(1))
                )
            
            Text("+")
                .foregroundColor(.white.opacity(0.34))
                .fontWeight(.black)
                .font(.system(size: 45))
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
            
        }
    }
}

struct DropZoneImageView_Previews: PreviewProvider {
    static var previews: some View {
        DropZoneImageView()
    }
}
