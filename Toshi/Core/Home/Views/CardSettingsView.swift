//
//  CardSettingsView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//



import Foundation
import SwiftUI

struct CardSettingsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var isPresented: Bool
   // @Binding var cardSettingsModal: CardSettingsModalView?
    
//    enum CardSettingsModal {
//        case cardSettingsModal
//        // other cases...
//    }
    @Namespace var animation
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(1), Color.black.opacity(1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                Spacer()
                    .frame(height: 50)
                
                HStack {
                    Button(action: {
                        isPresented = false
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                    }) {
                        HStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.white.opacity(0.3))
                        }
                    }
                    Spacer()
                    Button(action: {
                        //action
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                    }) {
                        HStack {
                            Image(systemName: "info")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.white.opacity(0.3))
                        }
                    }
                }
                .padding(.bottom, 20)
                SettingsCard
                    .pressAnimation()
                Spacer()

            }.padding()
            
            
        }
    }
}



extension CardSettingsView {
    
    private var SettingsCard: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundColor(.black.opacity(0.1))
                                .frame(width: 40, height: 40)
                            
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 23))
                                    .foregroundColor(.black.opacity(0.6))
                                    .padding(6)
                                    .background(Color.clear)
                                    .clipShape(Circle())
                        }
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                    
//                    VStack {
//                            Button(action: {
                    //  action
//                            }) {
//                                ZStack {
//                                    Circle()
//                                        .foregroundColor(.red)
//                                        .frame(width: 25, height: 25)
//                                    Image(systemName: "xmark")
//                                        .bold()
//                                        .font(.system(size: 14))
//                                        .foregroundColor(.white)
//                                        .background(Color.clear)
//                                        
//                                    
//                                }
//                            }
//                        Spacer()
//                    }
                }
                Spacer()
            }
        }
        .matchedGeometryEffect(id: "card", in: animation)
        .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height / 3.7)
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(Color.theme.accent)
        .cornerRadius(25)

    }

}
