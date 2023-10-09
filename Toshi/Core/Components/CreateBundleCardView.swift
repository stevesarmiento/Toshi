//
//  CreateBundleCardView.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//

//import Foundation
//import SwiftUI
//
//struct CreateBundleModalView: View {
//    @Binding var isShown: Bool
//
//    var body: some View {
//        HalfModalView(isShown: $isShown, onDismiss: {
//            withAnimation(.easeOut(duration: 0.15)) {
//                isShown = false
//            }
//        }) {
//            ModalContent()
//        }
//    }
//
//    private struct ModalContent: View {
//        var body: some View {
//            VStack(alignment: .center) {
//                HStack {
//                    Image(systemName: "chevron.compact.down")
//                        .foregroundColor(.black.opacity(0.2))
//                        .font(.system(size: 24, weight: .semibold))
//                        .padding(.top, 13)
//                        .padding(.bottom, 2)
//                }
//                VStack(alignment: .leading) {
//                    TransactionButton(title: "Create Account", subtitle: "Create a new account.", systemImageName: "plus.circle.fill", action: {
//                        // Uncomment and integrate with your walletManager here
//                        // walletManager.createWallet(name: "Account \(walletManager.wallets.count + 1)", icon: "person.crop.circle")
//                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
//                        impactMed.impactOccurred()
//                    })
//                    TransactionButton(title: "Import Account", subtitle: "Add an existing account.", systemImageName: "arrow.down.circle.fill", action: {
//                        // Uncomment and integrate with your walletManager here
//                        // let mockWallet = Wallet(name: "Imported Account", publicKey: UUID().uuidString, tokenGroups: [], nfts: [])
//                        // walletManager.importWallet(wallet: mockWallet)
//                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
//                        impactMed.impactOccurred()
//                    })
//                }
//                .padding()
//            }
//        }
//    }
//}

