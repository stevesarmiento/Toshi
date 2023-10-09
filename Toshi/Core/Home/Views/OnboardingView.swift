//
//  Onboarding.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/1/23.
//

import SwiftUI

struct OnboardingView: View {
    @State private var showHomeView = false
    
    var body: some View {
        if showHomeView {
                    HomeView()
        } else {
            ZStack{
                //Background Layer
                Color.theme.background
                    .ignoresSafeArea()
                //Content Layer
                VStack{
                    HStack {
                        Text("Hello")
                            .font(.system(size: 42, weight: .bold))
                            .bold()
                            .foregroundColor(Color.theme.accent)
                            .padding(0)
                        Text("Toshi")
                            .font(.system(size: 42, weight: .bold))
                            .bold()
                            .gradientForeground(colors: [Color(red: 0.965, green: 0.773, blue: 1), Color(red: 0.965, green: 0.773, blue: 1)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .padding(0)
                        Text("👋")
                            .font(.system(size: 42, weight: .bold))
                            .bold()
                            .padding(0)
                            .wiggle()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("A simple, intuitive, and reliable way to track your digital assets.")
                        .foregroundColor(Color.theme.accent.opacity(0.8))
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        listItem(icon: "backpack.fill", title: "Simply magical", text: "Track coin in bundles or individually, quickly understand your portfolio.")
                        listItem(icon: "bell.badge.fill", title: "Keep Alert", text: "You move when prices move, get alerted when volatility hits.")
                        listItem(icon: "newspaper.fill", title: "Stay Connected", text: "Know whats happening and why, as its happening.")
                    }.padding(.vertical)
                    
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        showHomeView = true // Transition to TrackingView
                    }) {
                        HStack {
                            Image(systemName: "hare.fill")
                                .font(.headline)
                                .gradientForeground(colors: [Color(red: 0.965, green: 0.773, blue: 1), Color(red: 0.965, green: 0.773, blue: 1)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                .opacity(1)
                            Text("Start Tracking!")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.accent.opacity(0.1))
                        .cornerRadius(16)
                    }
                    .pressAnimation()
                    .padding(.vertical)
                    
                }.padding()
            }
            
        }
    }
}

private func listItem(icon: String, title: String, text: String) -> some View {
    HStack {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: 50, height: 50)
            .foregroundColor(Color.theme.accent.opacity(0.1))
            .overlay(
                Image(systemName: icon)
                .font(.system(size: 21))
                .gradientForeground(colors: [Color(red: 0.965, green: 0.773, blue: 1), Color(red: 0.965, green: 0.773, blue: 1)], startPoint: .topLeading, endPoint: .bottomTrailing)
                
            )

        VStack(alignment: .leading){
            Text(title)
                .font(.callout)
                .bold()
                .foregroundColor(Color.theme.accent)
                
            
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(Color.theme.accent.opacity(0.7))
        }
    }
}

struct GradientForeground: ViewModifier {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint

    func body(content: Content) -> some View {
        content
            .overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint))
            .mask(content)
    }
}

extension View {
    func gradientForeground(colors: [Color], startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing) -> some View {
        self.modifier(GradientForeground(colors: colors, startPoint: startPoint, endPoint: endPoint))
    }
}

//struct Onboarding_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}
