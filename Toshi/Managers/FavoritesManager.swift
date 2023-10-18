//
//  FavoritesManager.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/18/23.
//

import Foundation
import SwiftUI

class CoinFavoritesManager {
    @AppStorage("favoritedCoins") var favoritedCoinsData: Data = Data()

    func isCoinFavorited(coin: Coin) -> Bool {
        let favoritedCoins = (try? JSONDecoder().decode([Coin].self, from: favoritedCoinsData)) ?? []
        return favoritedCoins.contains(where: { $0.id == coin.id })
    }

    func addCoinToFavorites(coin: Coin) {
        var favoritedCoins = (try? JSONDecoder().decode([Coin].self, from: favoritedCoinsData)) ?? []
        favoritedCoins.append(coin)
        if let updatedData = try? JSONEncoder().encode(favoritedCoins) {
            favoritedCoinsData = updatedData
        }
    }

    func removeCoinFromFavorites(coin: Coin) {
        var favoritedCoins = (try? JSONDecoder().decode([Coin].self, from: favoritedCoinsData)) ?? []
        favoritedCoins = favoritedCoins.filter { $0.id != coin.id }
        if let updatedData = try? JSONEncoder().encode(favoritedCoins) {
            favoritedCoinsData = updatedData
        }
    }
}
