//
//  CardDetailView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/1/23.
//

import Foundation
import SwiftUI


struct CardDetailView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var isPresented: Bool
    
    @Binding var selectedCoin: Coin?
    @State private var showDetailView: Bool = false
    
    @Namespace var animation
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.theme.background, Color.black.opacity(1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                    .frame(height: 50)
                
                SearchBarView(searchText: $vm.searchText)

                columnHeaders
                                
                allCoinsList
            }.padding()
        }
        .matchedGeometryEffect(id: "detail", in: animation)
    }
}

extension CardDetailView {
    struct NoOpacityButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .opacity(configuration.isPressed ? 1 : 1)
        }
    }
    
    private var allCoinsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(vm.allCoins) { coin in
                    Button(action: {
                        selectedCoin = coin
                    }) {
                        CoinRowView(coin: coin, showHoldingsColumn: false)
                    }
                    .buttonStyle(NoOpacityButtonStyle())                    
                    .pressAnimation()
                }
            }
            .padding(3)
        }.refreshable {
            print("Refresh action triggered")
            vm.reloadData()
        }
    }
    
    private func segue( coin: Coin) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var columnHeaders: some View {
        HStack {
            HStack{
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .rank || vm.sortOptions == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle (degrees: vm.sortOptions == .rank  ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.15)){
                    vm.sortOptions = vm.sortOptions == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            HStack{
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .price || vm.sortOptions == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle (degrees: vm.sortOptions == .price  ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.15)){
                    vm.sortOptions = vm.sortOptions == .price ? .priceReversed : .price
                }
            }

            
            Button(action: {
//                withAnimation(.linear(duration: 1)){
//                    vm.reloadData()
//                }
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                
            }) {
                VStack {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(Color.theme.accent.opacity(0.3))
                }
            }
            // Button(action: {
            //     withAnimation(.linear(duration: 1)){
            //         vm.reloadData()
            //     }
            //     let generator = UINotificationFeedbackGenerator()
            //     generator.notificationOccurred(.success)
                
            // }) {
            //     VStack {
            //         Image(systemName: "ellipsis")
            //             .font(.system(size: 16))
            //             .bold()
            //             .foregroundColor(Color.theme.accent.opacity(0.3))
            //     }
            //     .rotationEffect(Angle(degrees: 90))
            // }
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.accent.opacity(0.7))
    }
    
}
