//
//  ToshiApp.swift
//  Toshi
//
//  Created by Steven Sarmiento on 9/30/23.
//

import SwiftUI

@main
struct ToshiApp: App {
    @State private var showSplashScreen = true
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplashScreen {
                    SplashScreenView()
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showSplashScreen = false
                                }
                            }
                        }
                } else {
                    NavigationView {
                        OnboardingView()
                            .navigationBarHidden(true)
                            .slideUp()
                            .fadeInEffect()
                    }
                    .environmentObject(vm)
                    .environment(\.colorScheme, .dark)
                }
            }
            .environment(\.colorScheme, .dark)
        }
    }
}
