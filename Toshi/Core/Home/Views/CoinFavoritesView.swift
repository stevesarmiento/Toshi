//
//  CoinFavoritesView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/18/23.
//

import Foundation
import SwiftUI

struct CoinFavoritesView: View {
    let coin: Coin
    let favoritesManager = CoinFavoritesManager()

    var body: some View {
        VStack {
                CoinImageView(coin: coin)
                    .foregroundColor(Color.theme.accent)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .padding(.leading, 7)
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .bold()
                    .padding(.leading, 7)
                    .foregroundColor(Color.theme.accent)
                                Spacer()
                VStack {
                Button(action: {
                    if favoritesManager.isCoinFavorited(coin: coin) {
                        favoritesManager.removeCoinFromFavorites(coin: coin)
                    } else {
                        favoritesManager.addCoinToFavorites(coin: coin)
                    }
                }) {
                    Image(systemName: favoritesManager.isCoinFavorited(coin: coin) ? "xmark" : "xmark")
                        .bold()
                        .font(.system(size: 10))
                        .frame(width: 20, height: 20)
                        .background(Color.black.opacity(0.1))
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                }
                .padding(.top, -3)
                Spacer()
                }
        }
        .frame(width: 104, height: 64)
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
        .background(Color.theme.accent.opacity(0.1))
        .cornerRadius(16)

    }
}
