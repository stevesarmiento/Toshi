//
//  NftDataService.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/22/23.
//

//import Foundation
//import Combine
//
//class JpegsDataService {
//    
//    @Published var allJpegs: [Jpegs] = []
//    
//    var jpegSubscription: AnyCancellable?
//    
//    init() {
//        getCoins()
//    }
//    
//    func getCoins() {
//        guard let url = URL (string: "https://pro-api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=1000&page=1&sparkline=true&price_change_percentage=24h&locale=en&x_cg_pro_api_key=CG-1msFvUPTdwKeaBLi3k34ckxK" ) else { return }
//        
//        jpegSubscription = NetworkingManager.download(url: url)
//            .decode(type: [Jpegs].self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue:{[weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//                self?.jpegSubscription?.cancel()
//            })
//        }
//    }
// 

