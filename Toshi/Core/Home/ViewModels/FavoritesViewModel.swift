//
//  FavoritesViewModel.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/12/23.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favoritedCoins: [Coin] = []
}
