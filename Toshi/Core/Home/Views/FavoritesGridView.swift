//
//  FavoritesGridView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/9/23.
//

import Foundation
import SwiftUI

struct FavoritesGridView: View {
    @EnvironmentObject private var vm: HomeViewModel

    @AppStorage("favoritedCoins") var favoritedCoinsData: Data = Data()
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var isGridViewActive = true // Add this line

    
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
            Spacer()
                Button(action: {
                    vm.isGridViewActive.toggle()
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }) {
                    Image(systemName: vm.isGridViewActive ? "rectangle.grid.2x2.fill" : "rectangle.grid.1x2.fill")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(Color.theme.accent.opacity(0.3))
                            .symbolEffect(.bounce, value: vm.isGridViewActive)
                }
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
            if vm.isGridViewActive {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(favoritedCoins, id: \.self) { coin in
                            CoinFavoritesView(coin: coin)
                        }
                    }
                    .padding(.horizontal, 8)
                }
                .frame(height: 109)
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(favoritedCoins, id: \.self) { coin in
                            CoinRowView(coin: coin, showHoldingsColumn: false)
                        }
                    }
                    .padding(3)
                }
                .refreshable {
                    print("Refresh action triggered")
                    vm.reloadData()
                }
            }
        }
    }
}
