//
//  FavoriteHeartView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/11/23.
//

import SwiftUI

struct FavoriteIconView: View {
    let isFavorited: Bool
    //@State private var isUnfavoriting: Bool = false
    //@State private var scaleEffect: CGFloat = 1.0
    
    var body: some View {
        Image(systemName: isFavorited ? "bookmark.fill" : "bookmark.slash.fill")
            .frame(height: 30)
            .foregroundColor(isFavorited ? .purple : .gray)
            .bold()
            .font(.system(size: 20))
            .symbolEffect(.bounce, value: isFavorited)
    }
}
