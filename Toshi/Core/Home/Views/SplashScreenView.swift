//
//  SplashScreenView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/1/23.
//


import SwiftUI
import UIKit

struct SplashScreenView: View {

    @State private var sunOffset: CGFloat = 100
    @State private var sunScale: CGFloat = 2.0
    @State private var circleScale: [CGFloat] = [1.5, 2, 2.5]
    @State private var sunColor: Color = .red
    @State private var horizonOffset: CGFloat = 1600
    @State private var horizonColor: Color = .black
    @State private var reflectionColor: Color = .orange
    @State private var fadeOutOpacity: Double = 1
    @State private var gradientOpacity: Double = 0

    let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)

    var body: some View {
        ZStack {
            // Solid Background
            Color.pink
                .opacity(Double(1 - sunOffset / 100))
                .edgesIgnoringSafeArea(.all)

            // Gradient Background
            //LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.4, blue: 1), Color(red: 0.988, green: 0.961, blue: 0.851)]), startPoint: .top, endPoint: .bottom)
            Color.black
                .opacity(gradientOpacity)
                .edgesIgnoringSafeArea(.all)

            // Glare Circles
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0), Color.white.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 60, height: 60)
                    .scaleEffect(circleScale[index])
                    .offset(y: sunOffset)
            }

            // Sun
            Circle()
                .foregroundColor(sunColor)
                .frame(width: 100, height: 100)
                .scaleEffect(sunScale)
                .offset(y: sunOffset)

            // Horizon
            Circle()
                .foregroundColor(horizonColor)
                .frame(width: UIScreen.main.bounds.width * 8, height: UIScreen.main.bounds.height * 8)
                .offset(y: horizonOffset)
            
        }
        .onAppear {
            // Generate haptic feedback periodically
            let timer = Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { _ in
                feedbackGenerator.impactOccurred()
            }

            // Invalidate the timer after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                timer.invalidate()
            }

            withAnimation(AnimationUtility.sunriseAnimation()) {
                sunOffset -= 250
                sunScale = 0.85
                sunColor = Color(red: 0.965, green: 0.773, blue: 1)
                horizonOffset += 100
                horizonColor = Color.black
                reflectionColor = Color(red: 0.988, green: 0.961, blue: 0.851)
                gradientOpacity = 1.0
                circleScale = [2.0, 2.5, 3.0]
            }

            withAnimation(AnimationUtility.fadeAnimation()) {
                fadeOutOpacity = 0
            }
        }
        .opacity(fadeOutOpacity)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

