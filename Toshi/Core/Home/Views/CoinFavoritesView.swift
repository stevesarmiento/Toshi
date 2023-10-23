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
                    Image(systemName: favoritesManager.isCoinFavorited(coin: coin) ? "xmark.circle.fill" : "xmark.circle.fill")
                        .bold()
                        .font(.system(size: 16))
                        //.frame(width: 20, height: 20)
                        //.background(Color.theme.background)
                        //.clipShape(Circle())
                        .foregroundColor(Color.gray)
                }
                .padding(.top, -3)
                .pressAnimation()
                Spacer()
                    Text(coin.currentPrice.asCurrencyWith6Decimals())
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
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.theme.background)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.theme.accent.opacity(0.07), lineWidth: 1)
                            .shadow(radius: 10)

                    )
                ChartView(coin: coin)
                    .opacity(0.2)
                    .padding(-2)
            }
        )
        .cornerRadius(16)
        .slideUp()


    }
}
