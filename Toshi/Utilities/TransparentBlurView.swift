//
//  TransparentBlurView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/8/23.
//

import SwiftUI

struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters: Bool = false
    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let backdropLayer = uiView.layer.sublayers?.first {
                if removeAllFilters {
                    backdropLayer.filters = []
                } else {
                    // removing all filters except blur
                    backdropLayer.filters?.removeAll(where: {filter in
                            String(describing: filter) != "gaussianBlue"
                    })
                }
            }
        }
    }
}

#Preview {
    TransparentBlurView()
}
