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
  //  @EnvironmentObject var walletManager: WalletManager
    @State private var isFavorited = false
    @State private var swipeOffset: CGFloat = 0

    var body: some View {
        ZStack {
            HStack {
                FavoriteIconView(isFavorited: isFavorited)
                Spacer()
            }
            .padding()
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white.opacity(0.1))
            )
            HStack(spacing: 0) {
                Text("\(coin.rank)")
                    .font(.caption)
                    .foregroundColor(Color.theme.accent)
                    .frame(minWidth: 20)
                CoinImageView(coin: coin)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .padding(.leading, 7)
                Text(coin.symbol.uppercased())
                    .font(.headline)
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
                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .foregroundColor(
                            (coin.priceChangePercentage24H ?? 0 >= 0) ?
                            Color.theme.green :
                            Color.theme.red
                        )
                }
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            }
            .font(.subheadline)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.theme.background)
            )           .offset(x: swipeOffset, y: 0)
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
                            if isFavorited {
                         //       walletManager.selectedWallet?.addToFavorites(coin: coin)
                            } else {
                        //        walletManager.selectedWallet?.removeFromFavorites(coin: coin)
                            }
                        }
                        withAnimation {
                            self.swipeOffset = 0
                        }
                    }
            )
        }
        .onAppear {
        //    isFavorited = walletManager.selectedWallet?.favorites.contains(coin) ?? false
        }
    }
}

struct FavoriteIconView: View {
    let isFavorited: Bool

    var body: some View {
        Image(systemName: isFavorited ? "heart.fill" : "heart")
            .foregroundColor(isFavorited ? .red : .gray)
            .font(.system(size: 18))
    }
}

//struct CoinRowView: View {
//    
//    let coin: Coin
//    let showHoldingsColumn: Bool
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            Text("\(coin.rank)")
//                .font(.caption)
//                .foregroundColor(Color.theme.accent)
//                .frame(minWidth: 30)
//            CoinImageView(coin: coin)
//                .frame(width: 30, height: 30)
//                .clipShape(Circle())
//            Text(coin.symbol.uppercased())
//                .font(.headline)
//                .padding(.leading, 6)
//                .foregroundColor(Color.theme.accent)
//            Spacer()
//            
//            if showHoldingsColumn {
//                VStack(alignment: .trailing) {
//                    Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
//                        .bold()
//                    Text((coin.currentHoldings ?? 0).asNumberString())
//                }
//                .foregroundColor(Color.theme.accent)
//            }
//            
//            VStack(alignment: .trailing) {
//                Text(coin.currentPrice.asCurrencyWith6Decimals())
//                    .bold()
//                    .foregroundColor(Color.theme.accent)
//                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
//                    .foregroundColor(
//                        (coin.priceChangePercentage24H ?? 0 >= 0) ?
//                        Color.theme.green :
//                        Color.theme.red
//                    )
//            }
//            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
//        }
//        .font(.subheadline)
//    }
//}

//struct CoinRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
//    }
//}
