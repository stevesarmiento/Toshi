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

    var body: some View {
        VStack {
                Text("\(coin.rank)")
                    .font(.caption)
                    .foregroundColor(Color.theme.accent.opacity(0.5))
                    .frame(minWidth: 20)
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
        }
        .frame(width: 104, height: 64)
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
        .background(Color.theme.accent.opacity(0.1))
        .cornerRadius(16)

    }
}
