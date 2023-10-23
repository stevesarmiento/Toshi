//
//  ChartView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/5/23.
//

import SwiftUI
// import Charts

// struct ChartView: View {
    
//     @State private var currentIndex: Int = 0
    
//     private let data: [Double]
//     private let maxY: Double
//     private let minY: Double
//     private let lineColor: UIColor
//     private let startingDate: Date
//     private let endingDate: Date
    
//     @State private var percentage: CGFloat = 0
    
//     init(coin: Coin) {
//         data = coin.sparklineIn7D?.price ?? []
//         maxY = data.max() ?? 0
//         minY = data.min() ?? 0
        
//         let priceChange = (data.last ?? 0) - (data.first ?? 0)
//         lineColor = priceChange > 0 ? UIColor.green : UIColor.red
        
//         endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
//         startingDate = endingDate.addingTimeInterval(-7*24*60*50)
//     }
    
//     var body: some View {
//         VStack{
//             LineChartSwiftUI(data: data, color: lineColor)
//         }
//         .font(.caption)
//         .foregroundColor(Color(lineColor).opacity(0.4))
//         .onAppear{
//             DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                 withAnimation(.easeInOut(duration: 2.0)) {
//                     percentage = 1.0
//                 }
//             }
//         }
//     }
// }

// struct LineChartSwiftUI: UIViewRepresentable {
//     let data: [Double]
//     let color: UIColor
    
//     func makeUIView(context: Context) -> LineChartView {
//         let chart = LineChartView()
//         chart.data = generateData()
//         return chart
//     }
    
//     func updateUIView(_ uiView: LineChartView, context: Context) {
//         uiView.data = generateData()
//     }
    
//     func generateData() -> LineChartData {
//         let entries = data.enumerated().map { ChartDataEntry(x: Double($0.offset), y: $0.element) }
//         let dataSet = LineChartDataSet(entries: entries)
//         dataSet.colors = [color]
//         return LineChartData(dataSet: dataSet)
//     }
// }


struct ChartView: View {
    
    @State private var currentIndex: Int = 0
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0
    
    init(coin: Coin) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*50)
    }
    
    
    var body: some View {
        VStack{
            chartView
//                .overlay(
//                    chartYAxis
//                )
//                .background(
//                    charBackground
//                )
//            chartDateLabels
        }
        .font(.caption)
        .foregroundColor(Color.theme.accent.opacity(0.4))
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) *
                        CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint (x: 0, y: 0))
                    }
                    path.addLine(to:  CGPoint(x: xPosition, y: yPosition))
                    
                }
            }
            .trim(from:0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }

    
    private var charBackground: some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }

}
