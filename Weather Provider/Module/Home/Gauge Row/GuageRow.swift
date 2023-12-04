//
//  GuageRow.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 6/9/23.
//

import SwiftUI

struct GuageRow: View {
    
    
    var value: CGFloat?
    
    var minimumValue: CGFloat
    var maximumValue: CGFloat
    
    var minimumTackValue: CGFloat
    var maximumTrackValue: CGFloat
    
    var offset: CGFloat {
        let offset = (minimumTackValue - minimumValue) / (maximumValue - minimumValue)
        return offset
    }
    
    var gaugeWidth: CGFloat {
        let max = (maximumTrackValue - minimumValue) / (maximumValue - minimumValue)
        let min = (minimumTackValue - minimumValue) / (maximumValue - minimumValue)
        return max - min
    }
    
    
    var body: some View {
        HStack {
            WPText("Monday")
            Spacer()
            Image(systemName: "sun.max.fill")
                .renderingMode(.original)
                .foregroundColor(.white)
            
            Spacer()
            
            
            WPText("\(Degree(Int(minimumTackValue)).asString)")
//                .font(.title3)
//                .fontWeight(.semibold)
                .multilineTextAlignment(.trailing)
                .frame(width: 34, alignment: .trailing)
            
            GeometryReader { proxy in
                
                ZStack(alignment: .leading) {
                    
                    Capsule()
                        .fill(.quaternary)
                        .frame(height: 10)
                    
                    GuageView(value: value,
                              minimumValue: minimumValue, maximumValue: maximumValue,
                              minimumTackValue: minimumTackValue, maximumTrackValue: maximumTrackValue)
                    .frame(width: gaugeWidth * proxy.size.width)
                    .offset(x: proxy.size.width * offset)
                }
            }
            .frame(width: 100, height: 10)
            
            WPText("\(Degree(Int(maximumTrackValue)).asString)")
//                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .frame(width: 34, alignment: .leading)
        }
        .padding(6)
    }
}

struct GuageRow_Previews: PreviewProvider {
    static var previews: some View {
        Background {
            GuageRow(value: 12,
                     minimumValue: 0, maximumValue: 100,
                     minimumTackValue: 8, maximumTrackValue: 92)
        }
    }
}
