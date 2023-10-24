//
//  SearchBarFullView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/23/23.
//

import Foundation
import SwiftUI

 struct SearchBarFullView: View {
     @FocusState private var isFocused: Bool
     @Binding var searchText: String
    
     var body: some View {
         HStack{
             Image(systemName: "magnifyingglass")
                 .foregroundColor(searchText.isEmpty ? Color.theme.accent.opacity(0.5): Color.theme.accent)
            
             TextField("Search by name or symbol...", text: $searchText)
                 .disableAutocorrection(true)
                 .overlay(
                        Image(systemName: "trash.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .offset(x: 10)
                            .foregroundColor(Color.theme.red)
                            .padding()
                            .symbolEffect(.bounce, value: isFocused)
                            .transition(.symbolEffect(.appear))
                            .opacity(isFocused ? 1.0 : 0.0)
                            .animation(.easeInOut(duration: 0.5), value: isFocused)
                            .onTapGesture {
                             UIApplication.shared.endEditing()
                             searchText = ""
                         }
                         .pressAnimation()
                    
                     ,alignment: .trailing
                 )
                 .focused($isFocused)
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
