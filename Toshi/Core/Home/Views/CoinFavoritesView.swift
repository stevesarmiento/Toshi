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
        Text(coin.name)
            .foregroundColor(.white)
    }
}
