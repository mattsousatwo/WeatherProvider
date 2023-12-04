//
//  TemperatureCapsule.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 6/10/23.
//

import SwiftUI

struct TemperatureCapsule: View {
    
    var currentTemp: Degree?
    
    var minimumTemp: Degree
    var maximumTemp: Degree
    
    var currentMinimumTemp: Degree
    var currentMaximumTemp: Degree
    
    var startPoint: UnitPoint {
        let offset = (0 - currentMinimumTemp.asCGFloat) / (currentMaximumTemp.asCGFloat - currentMinimumTemp.asCGFloat)
        return UnitPoint(x: offset,
                         y: 0.5)
    }
    
    var endPoint: UnitPoint {
        let offset = (100 - currentMinimumTemp.asCGFloat) / (currentMaximumTemp.asCGFloat - currentMinimumTemp.asCGFloat)
        return UnitPoint(x: offset,
                         y: 0.5)
    }
    
    var colors: [Color] = [.cyan, .teal, .yellow, .orange, .red]
    var capsuleHeight: CGFloat = 10.0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(
                        LinearGradient(colors: colors,
                                       startPoint: startPoint,
                                       endPoint: endPoint)
                    )
                    .frame(height: capsuleHeight)
                if let currentTemp = currentTemp {
                    Circle()
                        .strokeBorder(Color.white.opacity(0.4), lineWidth: 2.0)
                        .overlay(
                            Circle()
                                .fill(Color.white)
                                .padding(2)
                        )
                        .frame(width: 12, height: 12)
                        .offset(x: (proxy.size.width - capsuleHeight) * offset(for: currentTemp.asCGFloat))
                }
            }
        }
        .frame(height: capsuleHeight)
    }

    
    func offset(for value: CGFloat) -> CGFloat {
        if value < currentMinimumTemp.asCGFloat { return 0 }
        if value > currentMaximumTemp.asCGFloat { return 1 }
        let offset = (value - currentMinimumTemp.asCGFloat) / (currentMaximumTemp.asCGFloat - currentMinimumTemp.asCGFloat)
        return offset
    }
    

}


struct TemperatureCapsule_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureCapsule(minimumTemp: Degree(20), maximumTemp: Degree(50),
                           currentMinimumTemp: Degree(40), currentMaximumTemp: Degree(45))
    }
}
