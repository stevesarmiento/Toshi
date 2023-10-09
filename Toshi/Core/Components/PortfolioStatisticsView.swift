//
//  PortfolioStatsView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/4/23.
//

import Foundation
import SwiftUI

struct PortfolioStatisticsView: View {
    let stat: Statistic

    var body: some View {
        VStack(alignment: .trailing) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.accent.opacity(0.7))
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent.opacity(1))
            
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
                
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}
