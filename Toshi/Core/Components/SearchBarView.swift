//
//  SearchBarView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.accent.opacity(0.5): Color.theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .foregroundColor(Color.theme.accent.opacity(0.6))
                        .padding()
                        .offset(x: 10)
                        
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                        .pressAnimation()
                    
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.accent.opacity(0.04))
        )
        .slideUp()
        .padding(.bottom, 10)
    }
}

