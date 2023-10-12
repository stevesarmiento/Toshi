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
            .foregroundColor(getIconColor())
            .font(.system(size: 18))
            .scaleEffect(scaleEffect)
            // .padding()
            // .frame(width: 23, height: 23)
            // .background(Circle().fill(Color.white))
            .onChange(of: isFavorited, perform: { newValue in
                if newValue {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        scaleEffect = 1.2
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            scaleEffect = 1.0
                        }
                    }
                } else {
                    isUnfavoriting = true
                    withAnimation(.easeInOut(duration: 0.1)) {
                        scaleEffect = 1.1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isUnfavoriting = false
                        withAnimation(.easeInOut(duration: 0.1)) {
                            scaleEffect = 0.9
                        }
                    }
                }
            })
    }
        
        private func getIconName() -> String {
            if isUnfavoriting {
                return "heart.slash.fill"
            } else {
                return isFavorited ? "heart.fill" : "heart"
            }
        }
        
        private func getIconColor() -> Color {
            if isUnfavoriting {
                return .gray
            } else {
                return isFavorited ? .red : .gray
            }
        }
    }
