//
//  CardGridView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/1/23.
//

import Foundation
import SwiftUI

struct CardView: View {
    @Binding var showingDetail: Bool
    @Binding var showPortfolfioView: Bool
    @Binding var isCardSettingsViewShowing: Bool

    @State private var showDeleteButton = false
    @State private var showDeleteConfirmation = false
    @Namespace private var animation
    
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundColor(.black.opacity(0.1))
                                .frame(width: 40, height: 40)
                            
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 23))
                                    .foregroundColor(.black.opacity(0.6))
                                    .padding(6)
                                    .background(Color.clear)
                                    .clipShape(Circle())
                        }
                        Spacer()
                        //PortfolioStatsView()
                    }
                    Spacer()
                    Spacer()
                    
                    VStack {
                        if showDeleteButton {
                            Button(action: {
                                showDeleteConfirmation = true
                            }) {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.red)
                                        .frame(width: 25, height: 25)
                                    Image(systemName: "xmark")
                                        .bold()
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .background(Color.clear)
                                        
                                    
                                }
                            }
                            .fadeInEffect()
                            .slideUp()
                        } else {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isCardSettingsViewShowing = true
                                }
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                            }) {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color.black.opacity(0.1))
                                        .frame(width: 25, height: 25)
                                    Image(systemName: "ellipsis")
                                        .bold()
                                        .font(.system(size: 16))
                                        .foregroundColor(.black.opacity(0.4))
                                        .background(Color.clear)
                                    
                                }
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .frame(width: 142, height: 92)
        .padding(.horizontal, 10)
        .padding(.vertical, 12)
        .background(Color.theme.accent)
        .cornerRadius(20)
        .onTapGesture {
            showPortfolfioView = true
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        }
        .onLongPressGesture {
            showDeleteButton.toggle()
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
}

struct CardGridView: View {
    @Binding var showingDetail: Bool
    @Namespace var animation
    @Binding var isCardSettingsViewShowing: Bool

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "button.horizontal.fill")
                    .font(.system(size: 14))
                    .foregroundColor(Color.theme.accent.opacity(0.3))
                    .frame(height: 14)
                Text("Bundles")
                    .foregroundColor(Color.theme.accent.opacity(1))
                    .font(.system(size: 14))
                    .bold()
                Spacer()
                
                // Add Bundle
                Button(action: {
                    //  action goes here
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }) {
                    VStack {
                        Image(systemName: "plus")
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(Color.theme.accent.opacity(0.3))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 14)
            
            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 18) {
//                    ForEach(walletManager.wallets) { wallet in
                    CardView(showingDetail: $showingDetail, showPortfolfioView: $showingDetail, isCardSettingsViewShowing: $isCardSettingsViewShowing)
                            .matchedGeometryEffect(id: "card", in: animation)
                            .pressAnimation()
                            .onTapGesture {
                                showingDetail.toggle()
                            }
//                    }
//                }
                .padding(.horizontal, 6)
                .frame(height: 130)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


