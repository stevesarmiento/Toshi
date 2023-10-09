//
//  InfoButton.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/6/23.
//

import SwiftUI

struct InfoButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "info")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.theme.accent.opacity(0.2))
                .padding(10)
        }
        .background(Color.theme.accent.opacity(0.1))
        .clipShape(Circle())
        .pressAnimation()
    }
}

