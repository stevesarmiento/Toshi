//
//  CircleButtonView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/1/23.
//

import SwiftUI

struct CircleButtonView: View {
    @Namespace private var animation

    let iconName: String
    
    var body: some View {
        ZStack {
            Circle()
                .matchedGeometryEffect(id: "walletSymbol", in: animation)
                .foregroundColor(Color.theme.accent.opacity(0.1))
                .frame(width: 57, height: 57)

           
            Image(systemName: iconName)
                    .font(.system(size: 30))
                    .foregroundColor(Color.theme.accent.opacity(1))
                    .padding(6)
                    .background(Color.clear)
                    .clipShape(Circle())
        }
    }
}

