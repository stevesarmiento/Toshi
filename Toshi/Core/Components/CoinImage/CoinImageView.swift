//
//  CoinImageView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/2/23.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue:  CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading{
                ProgressView()
            } else {
                Image (systemName: "questionmark")
                    .foregroundColor(Color.theme.accent.opacity(0.7))
            }
        }
    }
}

//#Preview {
//    CoinImageView()
//}
