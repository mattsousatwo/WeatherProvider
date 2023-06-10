//
//  GuageView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 6/9/23.
//

import SwiftUI

struct GuageView: View {
    
    var value: CGFloat?
    
    var minimumValue: CGFloat
    var maximumValue: CGFloat
    
    var minimumTackValue: CGFloat
    var maximumTrackValue: CGFloat
    
    var startPoint: UnitPoint {
        let offset = (0 - minimumTackValue) / (maximumTrackValue - minimumTackValue)
        return UnitPoint(x: offset,
                         y: 0.5)
    }
    
    var endPoint: UnitPoint {
        let offset = (100 - minimumTackValue) / (maximumTrackValue - minimumTackValue)
        return UnitPoint(x: offset,
                         y: 0.5)
    }
    
    var colors: [Color] = [.cyan, .teal, .yellow, .orange, .red]
    var gaugeHeight: CGFloat = 10.0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(
                        LinearGradient(colors: colors,
                                       startPoint: startPoint,
                                       endPoint: endPoint)
                    )
                    .frame(height: gaugeHeight)
                if let value = value {
                    Circle()
                        .strokeBorder(Color.white.opacity(0.4), lineWidth: 2.0)
                        .overlay(
                            Circle()
                                .fill(Color.white)
                                .padding(2)
                        )
                        .frame(width: 12, height: 12)
                        .offset(x: (proxy.size.width - gaugeHeight) * offset(for: value))
                }
            }
        }
        .frame(height: gaugeHeight)
    }
    
    func offset(for value: CGFloat) -> CGFloat {
        if value < minimumTackValue { return 0 }
        if value > maximumTrackValue { return 1 }
        let offset = (value - minimumTackValue) / (maximumTrackValue - minimumTackValue)
        return offset
    }
    
    
}

struct GuageView_Previews: PreviewProvider {
    static var previews: some View {
        GuageView(value: 25,
                  minimumValue: 0, maximumValue: 100,
                  minimumTackValue: 0, maximumTrackValue: 100)
    }
}
