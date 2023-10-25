//
//  CoinRowView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/1/23.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let showHoldingsColumn: Bool
    @State private var isFavorited = false
    @State private var swipeOffset: CGFloat = 0
    @State private var showCircle = false 
    @AppStorage("favoritedCoins") var favoritedCoinsData: Data = Data()

    var body: some View {
        ZStack {
            HStack {
                FavoriteIconView(isFavorited: isFavorited)
                Spacer()
            }
            .frame(height: 30)
            .padding()
            //.padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.white.opacity(0.1))
            )
            HStack(spacing: 0) {
                Text("\(coin.rank)")
                    .font(.caption)
                    .foregroundColor(Color.theme.accent.opacity(0.5))
                    .frame(minWidth: 15)
                CoinImageView(coin: coin)
                    .foregroundColor(Color.theme.accent)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .padding(.horizontal, 7)
                    .overlay(
                        ZStack {
                            FavoriteIconCircleView(isFavorited: isFavorited)
                                .opacity(showCircle ? 1 : 0)
                                .offset(x: -8, y: -15)
                        }
                    )
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .bold()
                    .padding(.leading, 7)
                    .foregroundColor(Color.theme.accent)
                Spacer()
                
                if showHoldingsColumn {
                    VStack(alignment: .trailing) {
                        Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                            .bold()
                        Text((coin.currentHoldings ?? 0).asNumberString())
                    }
                    .foregroundColor(Color.theme.accent)
                }
                
                VStack(alignment: .trailing) {
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
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            }
            .frame(height: 30)
            .font(.subheadline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .foregroundColor(Color.theme.background)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.theme.accent.opacity(0.05), lineWidth: 1)
                    )
                )

            .offset(x: swipeOffset, y: 0)
            .gesture(
                DragGesture(minimumDistance: 15)
                    .onChanged { value in
                        withAnimation {
                            self.swipeOffset = min(value.translation.width, 80)
                        }
                    }
                    .onEnded { value in
                        if self.swipeOffset > 30 {
                            isFavorited.toggle()
                            showCircle = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showCircle = false
                            }
                            if isFavorited {
                                addCoinToFavorites(coin: coin)
                            } else {
                                removeCoinFromFavorites(coin: coin)
                            }
                        }
                        withAnimation {
                            self.swipeOffset = 0
                        }
                    }
            )
        }
        .onAppear {
            isFavorited = isCoinFavorited(coin: coin)
        }
    }
}

extension CoinRowView {
    private func isCoinFavorited(coin: Coin) -> Bool {
        let favoritedCoins = (try? JSONDecoder().decode([Coin].self, from: favoritedCoinsData)) ?? []
        return favoritedCoins.contains(where: { $0.id == coin.id })
    }

    private func addCoinToFavorites(coin: Coin) {
        var favoritedCoins = (try? JSONDecoder().decode([Coin].self, from: favoritedCoinsData)) ?? []
        favoritedCoins.append(coin)
        if let updatedData = try? JSONEncoder().encode(favoritedCoins) {
            favoritedCoinsData = updatedData
        }
    }

    private func removeCoinFromFavorites(coin: Coin) {
        var favoritedCoins = (try? JSONDecoder().decode([Coin].self, from: favoritedCoinsData)) ?? []
        favoritedCoins = favoritedCoins.filter { $0.id != coin.id }
        if let updatedData = try? JSONEncoder().encode(favoritedCoins) {
            favoritedCoinsData = updatedData
        }
    }
}

