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
    
    @Binding var selectedCoin: Coin? // Add this line
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
                
//                HStack {
//                    Button(action: {
//                        isPresented = false
//                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
//                        impactMed.impactOccurred()
//                    }) {
//                        ZStack {
//                            CircleButtonView(iconName: "heart.fill")
//                                .matchedGeometryEffect(id: "walletSymbol", in: animation)
//                        }
//                        
//                        Text("hello mango")
//                            .bold()
//                            .font(.system(size: 20))
//                            .foregroundColor(.white)
//                    }
//                    Spacer()
//                }
                
                SearchBarView(searchText: $vm.searchText)

                columnHeaders
                                
                allCoinsList
            }.padding()
            // if let coin = selectedCoin {
            //     DetailView(coin: $selectedCoin)
            // }
        }
        .matchedGeometryEffect(id: "detail", in: animation)
//        .background(
//            .NavigationLink(
//                destination: DetailView(coin: $selectedCoin),
//                isActive: $showDetailView,
//                label: { EmptyView() })
//        )
    }
}

extension CardDetailView {
    private var allCoinsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(vm.allCoins) { coin in
                    Button(action: {
                        selectedCoin = coin
                    }) {
                        CoinRowView(coin: coin, showHoldingsColumn: false)
                    }
                    .pressAnimation()
                }
//                ForEach(vm.allCoins) { coin in
//                    NavigationLink(
//                        destination: DetailView(coin: $selectedCoin),
//                        tag: coin,
//                        selection: $selectedCoin
//                    ) {
//                        CoinRowView(coin: coin, showHoldingsColumn: false)
//                            .onTapGesture {
//                                segue(coin: coin)
//                            }
//                    }
//                }
            }
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
                    //.opacity((vm.sortOptions == .rank || vm.sortOptions == .rankReversed) ? 1.0 : 0.0)
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
                    //.opacity((vm.sortOptions == .price || vm.sortOptions == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle (degrees: vm.sortOptions == .price  ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.15)){
                    vm.sortOptions = vm.sortOptions == .price ? .priceReversed : .price
                }
            }

            
            Button(action: {
                withAnimation(.linear(duration: 1)){
                    vm.reloadData()
                }
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                
            }) {
                VStack {
                    Image(systemName: "goforward")
                        .font(.system(size: 18))
                        .bold()
                        .foregroundColor(Color.theme.accent.opacity(0.3))
                }
            }.rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
        }
        .font(.caption)
        .foregroundColor(Color.theme.accent.opacity(0.7))
    }
    
}
