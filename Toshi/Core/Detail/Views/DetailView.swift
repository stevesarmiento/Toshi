//
//  DeatilView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/5/23.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        VStack {
            VStack{
                Button(action: {
                        coin = nil
                }) {
                    RoundedRectangle(cornerRadius: 50.0)
                        .frame(width: 50, height: 5)
                        .foregroundStyle(Color.theme.accent.opacity(0.2))
                }
                .frame(height: 90)
                if let coin = coin {
                    DetailView(coin: coin)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color.theme.background)
                    .shadow(radius: 10)
            )
            .scaleEffect(1 - dragOffset / 2000)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        if value.translation.height > 50 {
                            coin = nil
                        }
                    }
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct VisualEffectView: UIViewRepresentable {
    let effect: UIVisualEffect

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView(effect: effect)
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}

struct DetailView: View {

        @State private var isFavorited = false

    @StateObject private var vm: CoinDetailViewModel
    @State private var showFullDescription: Bool = false
    private let columns3: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let columns2: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue:  CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                HStack {
                    VStack(alignment: .leading) {
                        CoinImageView(coin: vm.coin)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(radius: 10)

                        Text(vm.coin.name)
                            .font(.system(size: 30))
                            .bold()
                        Text(vm.coin.currentPrice.asCurrencyWith2Decimals())
                            .font(.system(size: 20))
                            .opacity(0.6)
                            .bold()
                            .contentTransition(.numericText())
                            .transaction { t in
                                t.animation = .bouncy
                            }
                        Text(vm.coin.priceChangePercentage24H?.asPercentString() ?? "")
                            .foregroundColor(
                                (vm.coin.priceChangePercentage24H ?? 0 >= 0) ?
                                Color.theme.green :
                                Color.theme.red
                            )
                            .contentTransition(.numericText())
                            .transaction { t in
                                t.animation = .bouncy
                            }
                    }
                    Spacer()
                    Button(action: {
                            // withAnimation(.linear(duration: 1)){
                                isFavorited.toggle()
                            // }
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                            
                        }) {
                            VStack {
                                FavoriteIconView(isFavorited: isFavorited)
                                Spacer()
                            }
                        }
                        .buttonStyle(NoOpacityButtonStyle())   
                        .pressAnimation()                 


                }
                .padding(.horizontal, 20)
                
                ChartView(coin: vm.coin)
                
                VStack{
                    descriptionTitle
                        .padding(.top, 20)
                    Divider()
                        descriptionSection
                    
                    VStack {
                        overviewTitle
                            .padding(.top, 20)
                        overviewGird
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.theme.accent.opacity(0.05))
                            )

                        additoinalTitle
                            .padding(.top, 20)

                        additionalGrid
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.theme.accent.opacity(0.05))
                            )
                        
                        linksTitle
                            .padding(.top, 20)
                        linkieSection
                    }
                    .slideUp()

                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

extension DetailView {
    struct NoOpacityButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .opacity(configuration.isPressed ? 1 : 1)
        }
    }
    private var descriptionTitle: some View {
        HStack{
            Image(systemName: "text.alignleft")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.accent.opacity(0.3))
            Text("Description")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    private var overviewTitle: some View {
        HStack {
            Image(systemName: "chart.pie.fill")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.accent.opacity(0.3))
            Text("Stats")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

    }
    
    private var additoinalTitle: some View {
        HStack{
            Image(systemName: "chart.bar.fill")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.accent.opacity(0.3))
            Text("Additional Stats")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

    }
    
    private var linksTitle: some View {
        HStack{
            Image(systemName: "link")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.accent.opacity(0.3))
            Text("Links")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

    }
    
    private var overviewGird: some View {
        LazyVGrid(
            columns: columns3,
            alignment: .center,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(Array(vm.overviewStatistics.enumerated()), id: \.element.id) { index, stat in
                    DetailStatisticView(stat: stat)
                        .background(
                            Group {
                                if index == 0 {
                                    Image(systemName: "seal.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color.theme.accent.opacity(0.1))
                                        .padding(1)
                                        .shadow(radius: 10)
                                }
                            }
                        )
                        .padding(5)
            }
            })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns2,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
    
    private var linkieSection: some View {
        HStack {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Button(action: {
                    UIApplication.shared.open(url)
                }) {
                    HStack {
                        Text("Website")
                            .font(.caption)
                            .foregroundColor(Color.theme.accent.opacity(0.5))
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(Color.theme.accent.opacity(0.2))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.theme.accent.opacity(0.1))
                    )
                }
            }
//                    if let redditString = vm.redditURL,
//                       let url = URL(string: redditString) {
//                        Link("reddit", destination: url)
//                    }
        }
        .padding(.vertical, 10)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading){
            Text(vm.coinDescription ?? placeholder)
                .lineLimit(showFullDescription ? nil : 3)
                .font(.callout)
                .foregroundColor(Color.theme.accent.opacity(0.5))
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.theme.background.opacity(showFullDescription ? 0 : 0.5)]), startPoint: .center, endPoint: .bottom)
                )
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.15)){
                    showFullDescription.toggle()
                }
            }, label: {
                HStack {
                    Text(showFullDescription ? "Read less" : "Read more")
                        .font(.callout)
                        .bold()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(showFullDescription ? 180 : 0))
                        .bold()
                }
                .padding(.vertical, 4)
            })
            .accentColor(.blue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var placeholder: String {
        return Array(repeating: " ", count: 100).joined(separator: " ")
    }
//    private var descriptionSection: some View {
//        ZStack {
//            if let coinDescription = vm.coinDescription,
//               !coinDescription.isEmpty {
//                VStack(alignment: .leading){
//                    Text(coinDescription)
//                        .lineLimit(showFullDescription ? nil : 3)
//                        .font(.callout)
//                        .foregroundColor(Color.theme.accent.opacity(0.5))
//                        .overlay(
//                            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.theme.background.opacity(showFullDescription ? 0 : 0.5)]), startPoint: .center, endPoint: .bottom)
//                        )
//                    
//                    Button(action: {
//                        withAnimation(.easeInOut(duration: 0.15)){
//                            showFullDescription.toggle()
//                        }
//                    }, label: {
//                        HStack {
//                            Text(showFullDescription ? "Read less" : "Read more")
//                                .font(.callout)
//                                .bold()
//                            Image(systemName: "chevron.down")
//                                .rotationEffect(.degrees(showFullDescription ? 180 : 0))
//                                .bold()
//                        }
//                        .padding(.vertical, 4)
//                    })
//                    .accentColor(.blue)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//            }
//        }
//    }
}
