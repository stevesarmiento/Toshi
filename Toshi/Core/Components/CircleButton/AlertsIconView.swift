//
//  DeleteIconView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/13/23.
//

import SwiftUI

    struct DeleteIconView: View {
        let isDeleted: Bool
        @State private var isDeleting: Bool = false
        @State private var scaleEffect: CGFloat = 1.0

    var body: some View {
        Image(systemName: getIconName())
            .frame(height: 22)
            .foregroundColor(getIconColor())
            .bold()
            .font(.system(size: 20))
            .scaleEffect(scaleEffect)
            .onChange(of: isDeleted, perform: { newValue in
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
                    isDeleting = true
                    withAnimation(.easeOut(duration: 0.1)) {
                        scaleEffect = 1
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isDeleting = false
                        withAnimation(.easeInOut(duration: 0.1)) {
                            scaleEffect = 1
                        }
                    }
                }
            })
    }
        
        private func getIconName() -> String {
            if isDeleting {
                return "bell.slash.fill"
            } else {
                return isDeleted ? "bell.fill" : "bell.fill"
            }
        }
        
        private func getIconColor() -> Color {
            if isDeleting {
                return .gray
            } else {
                return isDeleted ? .purple : .gray
            }
        }
    }
