//
//  FavoriteHeartView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/11/23.
//

import SwiftUI

    struct FavoriteIconView: View {
        let isFavorited: Bool
        @State private var isUnfavoriting: Bool = false
        @State private var scaleEffect: CGFloat = 1.0

    var body: some View {
        Image(systemName: getIconName())
            .frame(height: 22)
            .foregroundColor(getIconColor())
            .bold()
            .font(.system(size: 20))
            .scaleEffect(scaleEffect)
            .onChange(of: isFavorited, perform: { newValue in
                if newValue {
                    withAnimation(.easeIn(duration: 0.1)) {
                        scaleEffect = 1
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            scaleEffect = 1
                        }
                    }
                } else {
                    isUnfavoriting = true
                    withAnimation(.easeOut(duration: 0.1)) {
                        scaleEffect = 1
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isUnfavoriting = false
                        withAnimation(.easeInOut(duration: 0.1)) {
                            scaleEffect = 1
                        }
                    }
                }
            })
    }
        
        private func getIconName() -> String {
            if isUnfavoriting {
                return "bookmark.slash.fill"
            } else {
                return isFavorited ? "bookmark.fill" : "bookmark.fill"
            }
        }
        
        private func getIconColor() -> Color {
            if isUnfavoriting {
                return .gray
            } else {
                return isFavorited ? .purple : .gray
            }
        }
    }
