//
//  CoinLogoView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: Coin
    
    var body: some View {
        VStack(alignment: .leading) {
            CoinImageView(coin: coin)
                .frame(width: 25, height: 25)
                .clipShape(Circle())
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
//            Text(coin.name)
//                .font(.caption)
//                .foregroundStyle(Color.theme.accent.opacity(0.5))
//                .lineLimit(2)
//                .minimumScaleFactor(0.5)
//                .multilineTextAlignment(.leading)
        }
        

    }
}

