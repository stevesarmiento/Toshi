//
//  PortfolioView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//


import Foundation
import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var isPresented: Bool
    @Binding var portfolioModal: PortfolioModal?
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    
    enum PortfolioModal {
        case addCoinModal
        // other cases...
    }
    
    @Namespace var animation
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(1), Color.black.opacity(1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                Spacer()
                    .frame(height: 50)
                
                HStack {
                    Button(action: {
                        isPresented = false
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                    }) {
                            HStack {
                                ZStack {
                                    CircleButtonView(iconName: "heart.fill")
                                        .matchedGeometryEffect(id: "walletSymbol", in: animation)
                                }
                                Text("Ray baybay")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                    Spacer()
                    PortfolioStatsView()
                }
                

                HStack {
                    Image(systemName: "handbag.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Color.theme.accent.opacity(0.3))
                        .frame(height: 14)
                    Text("Portfolio")
                        .foregroundColor(Color.theme.accent.opacity(1))
                        .font(.system(size: 14))
                        .bold()
                    Spacer()
                    
                    // Add token
                    Button(action: {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                        
                        // Show the half modal
                        portfolioModal = .addCoinModal
                        
                    }) {
                        VStack {
                            Image(systemName: "plus")
                                .font(.system(size: 18))
                                .bold()
                                .foregroundColor(Color.theme.accent.opacity(0.3))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 14)
                
                HStack {
                    Text("Coin")
                    Spacer()
                    Text("Holdings")
                    Text("Price")
                        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                }
                .padding(.top, 10)
                .font(.caption)
                .foregroundColor(Color.theme.accent.opacity(0.7))
                    ScrollView {
                        if vm.portfolioCoins.isEmpty {
                            VStack(alignment: .center){
                                Text("You have no holdings added")
                                    .bold()
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.theme.accent.opacity(0.7))
                                Text("Add to holdings and start tracking coins in this bundle")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.theme.accent.opacity(0.4))
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .frame(height: 90)
                            .fadeInEffect()
                            .slideUp()
                        } else {
                            LazyVStack {
                                ForEach(vm.portfolioCoins) { coin in
                                    CoinRowView(coin: coin, showHoldingsColumn: true)
                                }
                            }
                        }
                    }
                
                Spacer()

            }.padding()
            
            
        }
        if let PortfolioModal = portfolioModal {
            switch PortfolioModal {
            case .addCoinModal:
                addCoinModal()
            }
        }
//        .matchedGeometryEffect(id: "detail", in: animation)
    }
    
    func addCoinModal() -> some View {
        HalfModalView(isShown: Binding<Bool>(
            get: { self.portfolioModal == .addCoinModal },
            set: { newValue in
                if !newValue {
                    self.portfolioModal = .addCoinModal
                }
            }
        ), onDismiss: {
            withAnimation(.easeInOut(duration: 0.15)) {
                self.portfolioModal = nil
            }
        }) {
            VStack(alignment: .center){
                HStack {
                    InfoButton {
                        withAnimation {
                            //self.portfolioModal = nil
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    Spacer()
                    XMarkButton {
                        withAnimation {
                            self.portfolioModal = nil
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 20)

                }
                VStack (alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
        
                    coinLogoList
                    
                    if selectedCoin != nil  {
                        portfolioInfoSection
                        
                    }
                    
                    saveButton


                }.padding()
                
            }
        }
//        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 1)
    }
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack (spacing: 15) {
//              ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.15)) {
                               updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                           RoundedRectangle(cornerRadius: 16)
                               .fill(selectedCoin?.id == coin.id ? Color.theme.accent.opacity(0.2) : Color.theme.accent.opacity(0.1))
                        )
                        .overlay(
                           selectedCoin?.id == coin.id ?
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue.opacity(0.4), lineWidth: 4)
                                    .padding(-5)
                                    .fadeInEffect()
                                : nil
                        )
                        .pressAnimation()
                }
            }.padding(.leading, 7)
            
        })
        .frame(height: 120)
        .onChange(of: vm.searchText, perform: { value in
            if value == ""
            {
                withAnimation(.easeInOut(duration: 0.15)) {
                    removeSelectedCoin()
                }
            }
        })
        
    }
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id}),
            let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private var portfolioInfoSection: some View {
        VStack(spacing: 20) {
            HStack{
                Text("Price per \(selectedCoin?.symbol.uppercased() ?? ""):")
                    .foregroundColor(Color.theme.accent.opacity(0.5))
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                    .foregroundColor(Color.theme.accent.opacity(0.5))
                Spacer()
                TextField("e.g. 1.337", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value:")
                    .foregroundColor(Color.theme.accent.opacity(0.5))
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
            .font(.headline)
            
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
            saveButtonPressed()
            // Close the modal
            withAnimation {
                portfolioModal = nil
            }
        }) {
            HStack {
//                            Image(systemName: "hare.fill")
//                                .font(.headline)
//                                .gradientForeground(colors: [Color(red: 0.965, green: 0.773, blue: 1), Color(red: 0.965, green: 0.773, blue: 1)], startPoint: .topLeading, endPoint: .bottomTrailing)
//                                .opacity(1)
                Text("Add Token")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.theme.accent.opacity(0.1))
            .cornerRadius(16)
        }
        .pressAnimation()
        .padding(.vertical)
    }
    
    private func saveButtonPressed() {
        guard 
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
        
        vm.updatePortfolio(coin: coin, amount: amount )
        
        //show checkmark
        withAnimation(.easeInOut(duration: 0.15)) {
            //showCheckMark = true
            removeSelectedCoin()
        }
        
        //hide keyboard
        UIApplication.shared.endEditing()
    }
    
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
        
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0 )
        }
        return 0
    }
}
