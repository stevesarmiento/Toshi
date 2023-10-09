//
//  CustomLinks.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//

import Foundation
import SwiftUI

struct TransactionToggle: View {
    let title: String
    let systemImageName: String

    @Binding var isOn: Bool

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 13)
                .frame(width: 40, height: 40)
                .foregroundColor(Color.black.opacity(0.1))
                .overlay(
                    Image(systemName: systemImageName)
                        .font(.system(size: 18))
                        .foregroundColor(.black.opacity(0.7))
                )
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .green.opacity(1)))
        }
        .padding(.vertical)
        .padding(.horizontal, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}



struct TransactionButton: View {
    let title: String
    let subtitle: String
    let systemImageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 13)
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.theme.accent.opacity(0.1))
                        .overlay(
                            Image(systemName: systemImageName)
                                .font(.system(size: 18))
                                .foregroundColor(Color.theme.accent.opacity(0.7))

                        )
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color.theme.accent.opacity(1))
                        Text(subtitle)
                            .font(.system(size: 13, weight: .light))
                            .foregroundColor(Color.theme.accent.opacity(0.7))
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 14)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.theme.accent.opacity(0.1), Color.theme.accent.opacity(0.1)]),
                    startPoint: .top,
                    endPoint: .bottom
                    
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .pressAnimation()
            
        }
    }
}

struct CustomLinkView: View {
    var iconName: String
    var title: String
    var action: () -> Void
    var screenSize: CGSize
    var offset: CGFloat
    var minHeight: CGFloat

    var progress: Double {
        let total = Double(screenSize.height - minHeight)
        let current = Double(offset)
        return current / total
    }
    

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(.white.opacity(0.3))
                    .frame(width: 30, height: 30)
                 
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(.white.opacity(0.3))
                    .frame(width: 30, height: 30)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(red: 0.063, green: 0.106, blue: 0.106))
            )
        }
        .pressAnimation()
        .opacity(1 - progress)
        .modifier(SlideUpTwo(progress: progress))
    }
}

struct KeyLinkView: View {
    var iconName: String
    var title: String
    var action: () -> Void
    var screenSize: CGSize
    var offset: CGFloat
    var minHeight: CGFloat

    var progress: Double {
        let total = Double(screenSize.height - minHeight)
        let current = Double(offset)
        return current / total
    }
    

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(.white.opacity(0.3))
                    .frame(width: 30, height: 30)
                 
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(.white.opacity(0.3))
                    .frame(width: 30, height: 30)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(red: 0.063, green: 0.106, blue: 0.106))
            )
        }
        .pressAnimation()
        .opacity(1)
        //.modifier(SlideUpTwo(progress: progress))
    }
}
