//
//  FavoritesGridView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/9/23.
//

import Foundation
import SwiftUI

struct FavoritesGridView: View {
    @AppStorage("favoritedCoins") var favoritedCoinsData: Data = Data()
        let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]


    var body: some View {
        let favoritedCoins = (try? JSONDecoder().decode([Coin].self, from: favoritedCoinsData)) ?? []


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
        
       if favoritedCoins.isEmpty {

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

       } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(favoritedCoins, id: \.self) { coin in
                        CoinFavoritesView(coin: coin)
                    }
                }
                .padding(.horizontal, 8)
            }
            .frame(height: 110)
       }
    }
}
