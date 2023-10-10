//
//  FavoritesGridView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/9/23.
//

import Foundation
import SwiftUI

struct FavoritesGridView: View {
//    let favorites: [Token]
//    @EnvironmentObject var walletManager: WalletManager
//    @State private var isPressed = false

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "heart.fill")
                    .font(.system(size: 14))
                    .foregroundColor(Color.theme.accent.opacity(0.3))
                    .frame(height: 14)
                Text("Favorites")
                    .foregroundColor(Color.theme.accent.opacity(1))
                    .font(.system(size: 14))
                    .bold()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 14)
        
//        if favorites.isEmpty {

                VStack(alignment: .center){
                        Text("No tokens are favorited")
                            .bold()
                            .font(.system(size: 14))
                            .foregroundColor(Color.theme.accent.opacity(0.7))
                        Text("Add to favorites and start tracking coins")
                            .font(.system(size: 12))
                            .foregroundColor(Color.theme.accent.opacity(0.4))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .frame(height: 90)
                .fadeInEffect()
                .slideUp()

//        } else {
//            ScrollView(.horizontal, showsIndicators: false) {
//                LazyHGrid(rows: gridLayout, spacing: 18) {
//                    ForEach(favorites, id: \.self) { token in
//                        TokenFavoritesView(token: token)
//                    }
//                }.fadeInEffect()
//                .slideUp()
//                .padding(.horizontal, 8)
//            }
//            .frame(height: 100)
//            .mask(linearGradient)
//        }
    }
}
