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
        HStack{
            VStack(alignment: .leading) {
                    CoinImageView(coin: coin)
                        .foregroundColor(Color.theme.accent)
                        .frame(width: 33, height: 33)
                        .clipShape(Circle())
                    Spacer()
                    Spacer()

            }
            Spacer()
                VStack(alignment: .trailing) {
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
                        .background(Color.theme.background)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                }
                .padding(.top, -3)
                .pressAnimation()
                Spacer()
                    Text(coin.currentPrice.asCurrencyWith2Decimals())
                        .bold()
                        .foregroundColor(Color.theme.accent)
                        .contentTransition(.numericText())
                        .transaction { t in
                            t.animation = .bouncy
                        }
                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .foregroundColor(
                            (coin.priceChangePercentage24H ?? 0 >= 0) ?
                            Color.theme.green :
                            Color.theme.red
                        )
                        .contentTransition(.numericText())
                        .transaction { t in
                                t.animation = .bouncy
                        }
                }
        }
        .frame(width: 110, height: 70)
        .font(.subheadline)
        .padding(10)
        .background(
            ZStack {
                Color.theme.accent.opacity(0.1)
                ChartView(coin: coin)
                    .opacity(0.2)
            }
        )
        .cornerRadius(16)
        .slideUp()


    }
}
