//
//  WalletSettingsModalView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//

import SwiftUI

struct CardSettingsModalView<Content: View>: View {
    @ObservedObject private var keyboard = KeyboardResponder()
    @Environment(\.presentationMode) var presentationMode
    @Binding var isShown: Bool
    let onDismiss: () -> Void
    let content: Content
    @State private var offset: CGFloat = UIScreen.main.bounds.height / 2

    init(isShown: Binding<Bool>, onDismiss: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self._isShown = isShown
        self.onDismiss = onDismiss
        self.content = content()
    }

    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let minHeight: CGFloat = screenSize.height * (keyboard.currentHeight > 0 ? 0.1 : 0.22)

        return VStack {
            Spacer()
            ZStack {
                content
                    .padding(.bottom)
                    .frame(width: screenSize.width * 0.94)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.theme.background)
//                            .fill(
//                                LinearGradient(
//                                    gradient: Gradient(colors: [Color(red: 0.922, green: 0.953, blue: 0.992), Color(red: 1, green: 0.976, blue: 0.886)]),
//                                    startPoint: .top,
//                                    endPoint: .bottom
//                                )
//                            )
                    )
                    .gesture(
                        DragGesture().onChanged { value in
                            let yOffset = value.translation.height
                            if yOffset > 0 {
                                offset = yOffset
                            }
                        }
                        .onEnded { value in
                            let threshold = minHeight * 0.2
                            if value.translation.height > threshold {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    offset = UIScreen.main.bounds.height
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    isShown = false
                                    onDismiss()
                                }
                            } else {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    offset = 0
                                }
                            }
                        }
                    )
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.2)) {
                            offset = 0
                        }
                    }
                    .onDisappear {
                        offset = UIScreen.main.bounds.height / 2
                    }
            }
            Spacer()
        }
        .offset(y: max(minHeight + offset, minHeight))
        .frame(width: screenSize.width, height: screenSize.height)
        .edgesIgnoringSafeArea(.all)
        .background(isShown ? Color.black.opacity(0.6) : Color.clear)
        //.animation(.easeInOut(duration: 0.1), value: isShown)
        .animation(.spring(response: 0.2, dampingFraction: 0.8), value: offset)
    }
}
