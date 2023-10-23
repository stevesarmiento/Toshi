//
//  SearchBarView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//

import SwiftUI

struct SearchBarView: View {
    @State private var isExpanded: Bool = false
    @FocusState private var isFocused: Bool
    @Binding var searchText: String
    @Namespace private var animation

    var body: some View {
        HStack {
            if isExpanded {
                HStack {
                    Image(systemName: isFocused ? "sparkle.magnifyingglass" : "magnifyingglass")
                        .frame(width: 18)
                        .foregroundColor(searchText.isEmpty ? Color.theme.accent.opacity(0.2): Color.theme.accent)
                        .matchedGeometryEffect(id: "searchBarIcon", in: animation)
                        .symbolEffect(.bounce, value: isFocused)


                    
                    TextField("Search by name or symbol...", text: $searchText)
                        .disableAutocorrection(true)
                        .overlay(
                            Image(systemName: "trash.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color.theme.red)
                                .padding()
                                .symbolEffect(.bounce, value: isFocused)
                                .transition(.symbolEffect(.appear))
                                .opacity(isFocused ? 1.0 : 0.0)
                                .animation(.easeInOut(duration: 0.1), value: isFocused)
                                .onTapGesture {
                                    self.isExpanded.toggle()
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
                        //.strokeBorder(Color.theme.accent.opacity(0.05), lineWidth: isFocused ? 3 : 0)
                        .matchedGeometryEffect(id: "searchBar", in: animation)
                )
                .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.clear)
                            .strokeBorder(Color.theme.accent.opacity(0.1), lineWidth: isFocused ? 3 : 0)
                            //.strokeBorder(Color.purple, lineWidth: isFocused ? 3 : 0)
                            .padding(-6)
                            .matchedGeometryEffect(id: "searchBar", in: animation)
                )
            }

            if !isExpanded {
                Button(action: {
                    withAnimation {
                        self.isExpanded.toggle()
                        self.isFocused = self.isExpanded
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 18)
                        .foregroundColor(searchText.isEmpty ? Color.theme.accent.opacity(0.2): Color.theme.accent)
                        .matchedGeometryEffect(id: "searchBarIcon", in: animation)

                }
                .font(.headline)
                .padding()
                .background(
                    Circle()
                        .fill(Color.theme.accent.opacity(0.04))
                        //.strokeBorder(Color.theme.accent.opacity(0.2), lineWidth: isFocused ? 0 : 0)
                        .matchedGeometryEffect(id: "searchBar", in: animation)
                )

            }
        }
        .pressAnimation()
        .slideUp()
        .frame(height: 90)
        .animation(.easeInOut(duration: 0.15), value: isExpanded)
    }
}


// struct SearchBarView: View {
    
//     @Binding var searchText: String
    
//     var body: some View {
//         HStack{
//             Image(systemName: "magnifyingglass")
//                 .foregroundColor(searchText.isEmpty ? Color.theme.accent.opacity(0.5): Color.theme.accent)
            
//             TextField("Search by name or symbol...", text: $searchText)
//                 .disableAutocorrection(true)
//                 .overlay(
//                     Image(systemName: "xmark.circle.fill")
//                         .resizable()
//                         .frame(width: 27, height: 27)
//                         .foregroundColor(Color.theme.accent.opacity(0.6))
//                         .padding()
//                         .offset(x: 10)
                        
//                         .opacity(searchText.isEmpty ? 0.0 : 1.0)
//                         .onTapGesture {
//                             UIApplication.shared.endEditing()
//                             searchText = ""
//                         }
//                         .pressAnimation()
                    
//                     ,alignment: .trailing
//                 )
//         }
//         .font(.headline)
//         .padding()
//         .background(
//             RoundedRectangle(cornerRadius: 25)
//                 .fill(Color.theme.accent.opacity(0.04))
//         )
//         .slideUp()
//         .padding(.bottom, 10)
//     }
// }

