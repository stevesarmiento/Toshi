//
//  TrackingHomeView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/1/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showingDetail = false
    @State private var portfolioModal: PortfolioView.PortfolioModal? = nil
    @State private var selectedCoin: Coin? = nil

    @State private var isCardSettingsViewShowing = false
    @State private var selectedTab = 0
    @State private var previousTab = 0
    
    @Namespace private var animation

    var body: some View {
        VStack {
            
            if selectedTab == 0 {
                
                homeSection

                
            } else if selectedTab == 1 {

                coinDetailPage
            } else {
                
                newsPage
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.background]), startPoint: .bottom, endPoint: .top)
        )
        .animation(.easeInOut(duration: 0.15), value: selectedTab)
        .overlay(
            HStack {
                Button(action: {
                    previousTab = selectedTab
                    selectedTab = 0
                }) {
                    Image(systemName: "backpack.fill")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(selectedTab == 0 ? Color.theme.accent : Color.theme.accent.opacity(0.5))
                        .frame(width: 22, height: 22)
                }.pressAnimation()
                Spacer()
                Button(action: {
                    previousTab = selectedTab
                    selectedTab = 1
                }) {
                    Image(systemName: "circle.hexagongrid.fill" )
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(selectedTab == 1 ? Color.theme.accent : Color.theme.accent.opacity(0.5))
                        .frame(width: 22, height: 22)
                }.pressAnimation()
                Spacer()
                Button(action: {
                    previousTab = selectedTab
                    selectedTab = 2
                }) {
                    Image(systemName: "newspaper.fill")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(selectedTab == 2 ? Color.theme.accent : Color.theme.accent.opacity(0.5))
                        .frame(width: 22, height: 22)
                }.pressAnimation()
            }
            .edgesIgnoringSafeArea(.all)
            .padding(.horizontal, 77)
            .padding(.vertical, 30)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.theme.background, Color.theme.background]), startPoint: .bottom, endPoint: .top)
            )
            .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color.theme.accent.opacity(0.1))
                    , alignment: .top
                )
            , alignment: .bottom
        )
        .overlay(
            Group {
                if showingDetail {
                    PortfolioView(isPresented: $showingDetail, portfolioModal: $portfolioModal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .fadeInEffect()
                }
                if isCardSettingsViewShowing {
                    CardSettingsView(isPresented: $isCardSettingsViewShowing)
                        //.matchedGeometryEffect(id: "settings", in: animation)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .fadeInEffect()
                }
                if selectedCoin != nil {
                    DetailLoadingView(coin: $selectedCoin)
                }
            }
        )
    }
}

extension HomeView {
    
    private var newsPage: some View {
        
        Group {
            Text("Coming soon...")
                .foregroundStyle(Color.theme.accent.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
        .transition(makeTransition())
        
    }
    
    private var coinDetailPage: some View {
        Group {
            CardDetailView(isPresented: $showingDetail, selectedCoin: $selectedCoin, animation: _animation)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
        .transition(makeTransition())
    }
    
    private var homeSection: some View {
        Group {
            Spacer()
                .frame(height: 25)
            
            VStack(alignment: .leading) {
                CardGridView(showingDetail: $showingDetail, isCardSettingsViewShowing: $isCardSettingsViewShowing)
                    .fadeInEffect()

                FavoritesGridView()

                Spacer()
            }
            .padding(.horizontal)
        }
        .transition(makeTransition())
    }
    
    private func makeTransition() -> AnyTransition {
        let insertionEdge: Edge = selectedTab > previousTab ? .trailing : .leading
        let removalEdge: Edge = selectedTab > previousTab ? .leading : .trailing

        return AnyTransition.asymmetric(
            insertion: AnyTransition.opacity.combined(with: .move(edge: insertionEdge)),
            removal: AnyTransition.opacity.combined(with: .move(edge: removalEdge))
        )
    }
    
}
