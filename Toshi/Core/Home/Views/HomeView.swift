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
        ZStack {
            if selectedTab == 0 {
                
                homeSection
                    .padding(.top, 25)

                
            } else if selectedTab == 1 {

                coinDetailPage
            } else {
                
                newsPage
            }
            homeMenu
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.background]), startPoint: .bottom, endPoint: .top)
        )
        .animation(.easeInOut(duration: 0.15), value: selectedTab)
        // .overlay(
 
        // )
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

    private var homeMenu: some View {
        GeometryReader { geometry in
                ZStack {
            ContentBlurView(direction: .bottomBlur) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(maxWidth: .infinity)
            }  
            HStack {
                    Button(action: {
                        //previousTab = selectedTab
                        selectedTab = 0
                    }) {
                        Image(systemName: "square.fill.on.circle.fill")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(selectedTab == 0 ? Color.theme.accent : Color.theme.accent.opacity(0.5))
                            .frame(width: 22, height: 22)
                            //.symbolEffect(.bounce.down.byLayer, value: selectedTab == 0)

                    }
                    .pressAnimation()

                    Spacer()

                    Button(action: {
                        //previousTab = selectedTab
                        selectedTab = 1
                    }) {
                        Image(systemName: "book.pages.fill" )
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(selectedTab == 1 ? Color.theme.accent : Color.theme.accent.opacity(0.5))
                            .frame(width: 22, height: 22)
                            //.symbolEffect(.bounce, value: selectedTab == 1)

                    }
                    .pressAnimation()

                    Spacer()

                    Button(action: {
                        //previousTab = selectedTab
                        selectedTab = 2
                    }) {
                        ZStack {
                            Image(systemName: "newspaper.fill")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(selectedTab == 2 ? Color.theme.accent : Color.theme.accent.opacity(0.5))
                                .frame(width: 22, height: 22)
                            // .symbolEffect(.bounce, value: selectedTab == 2)

                            // Notification bubble
                            Text("3")
                                .font(.system(size: 10))
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 18, height: 18)
                                .background(Color.theme.red)
                                .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.theme.background, lineWidth: 4)
                                    )
                                .offset(x: 10, y: -10)
                        }
                    }
                    .pressAnimation()

                }
                .frame(width: UIScreen.main.bounds.width / 2)
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.theme.background, Color.theme.background]), startPoint: .bottom, endPoint: .top))
                        .shadow(radius: 10)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.theme.accent.opacity(0.07), lineWidth: 1)
                )         
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .bottom) 



    }    
    
    private var newsPage: some View {
        
        Group {
            Text("Coming soon...")
                .foregroundStyle(Color.theme.accent.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
       // .transition(makeTransition())
        
    }
    
    private var coinDetailPage: some View {
        Group {
            CardDetailView(isPresented: $showingDetail, selectedCoin: $selectedCoin, animation: _animation)
                .fadeInEffect()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
       // .transition(makeTransition())
    }
    
    private var homeSection: some View {
        Group {
            VStack(alignment: .leading) {
                CardGridView(showingDetail: $showingDetail, isCardSettingsViewShowing: $isCardSettingsViewShowing)
                    .fadeInEffect()

                FavoritesGridView()

                Spacer()
            }
            .padding(.horizontal)
        }
       // .transition(makeTransition())
    }
    
//    private func makeTransition() -> AnyTransition {
//        let insertionEdge: Edge = selectedTab > previousTab ? .trailing : .leading
//        let removalEdge: Edge = selectedTab > previousTab ? .leading : .trailing
//
//        return AnyTransition.asymmetric(
//            insertion: AnyTransition.opacity.combined(with: .move(edge: insertionEdge)),
//            removal: AnyTransition.opacity.combined(with: .move(edge: removalEdge))
//        )
//    }
    
}
