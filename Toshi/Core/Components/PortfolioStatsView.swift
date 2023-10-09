//
//  PortfolioStatsView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//

import SwiftUI

struct PortfolioStatsView: View {
    @EnvironmentObject private var vm:HomeViewModel
    
    var body: some View {
        HStack{
            ForEach(vm.statistics) { stat in
                PortfolioStatisticsView(stat: stat)
                    //.frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        //.frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}
