//
//  WaveShape.swift
//  Anzen
//
//  Created by Szabolcs Tóth on 23.05.2022.
//  Copyright © 2022 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct Wave: Shape {

    var offset: Angle
    var percent: Double

    var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let lowFudge = 0.02
        let highFudge = 0.98

        let newPercent = lowFudge + (highFudge - lowFudge) * percent
        let waveHeight = 0.015 * rect.height
        let yOffset = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)

        path.move(to: CGPoint(x: 0, y: yOffset + waveHeight * CGFloat(sin(offset.radians))))

        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let xOffset = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            path.addLine(to: CGPoint(x: xOffset, y: yOffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }

        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}
