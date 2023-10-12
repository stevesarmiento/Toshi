//
//  FavoriteIconCircleView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/11/23.
//


import SwiftUI

    struct FavoriteIconCircleView: View {
        let isFavorited: Bool
        @State private var isUnfavoriting: Bool = false
        @State private var scaleEffect: CGFloat = 1.0

    var body: some View {
            ZStack {
                Circle().fill(isFavorited ? Color.purple : Color.gray)
                    .frame(width: 22, height: 22)
                Image(systemName: getIconName())
                    .foregroundColor(getIconColor())
                    .font(.system(size: 13))
                    .padding()                    
            }
            .scaleEffect(scaleEffect)
            .onChange(of: isFavorited, perform: { newValue in
                if newValue {
                    withAnimation(.easeIn(duration: 0.2)) {
                        scaleEffect = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            scaleEffect = 0
                        }
                    }
                } else {
                    isUnfavoriting = true
                    withAnimation(.easeOut(duration: 0.2)) {
                        scaleEffect = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        isUnfavoriting = false
                        withAnimation(.easeInOut(duration: 0.1)) {
                            scaleEffect = 0
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
                return .white
            } else {
                return isFavorited ? .white : .gray
            }
        }
    }

