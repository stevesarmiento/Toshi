//
//  UIApplication.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/3/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
