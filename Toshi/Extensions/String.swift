//
//  String.swift
//  Toshi
//
//  Created by Steven Sarmiento on 10/7/23.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
