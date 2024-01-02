//
//  PageNavigationView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/20/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct PageNavigationView: View {
    
    let numberOfPages: Int
    @Binding var currentIndex: Int
    @State private var animationAmount: Int = 0
    
    private let circleSize: CGFloat = 10
    private let circleSpacing: CGFloat = 12
    
    private let primaryColor = Color.white.opacity(0.9)
    private let secondaryColor = Color.white.opacity(0.6)
    
    private let smallScale: CGFloat = 0.6
    
    var body: some View {
        HStack(spacing: circleSpacing) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                if shouldShowIndex(index) {
                    Circle()
                        .fill(currentIndex == index ? primaryColor : secondaryColor)
                        .scaleEffect(currentIndex == index ? 1 : smallScale)
                        .frame(width: circleSize, height: circleSize)
                        .transition(AnyTransition.opacity.combined(with: .scale))
                        .id(index)
                        .animation(.easeInOut(duration: 1.5), value: animationAmount)
                }
            }
        }
        .onChange(of: currentIndex) { _, _ in
            animationAmount += 1
        }
    }
    
    private func shouldShowIndex(_ index: Int) -> Bool {
        ((currentIndex - 1)...(currentIndex + 1)).contains(index)
    }
}

@available(iOS 17.0, *)
#Preview {
    Background(ThemeList.four.theme) {
        PageNavigationView(numberOfPages: 5, currentIndex: .constant(1))
    }
}
