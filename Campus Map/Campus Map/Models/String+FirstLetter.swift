//
//  String+FirstLetter.swift
//  Campus Map
//
//  Created by Bert Yan on 2/20/22.
//

import Foundation

extension String {
    var firstLetter : String? {
        return self.isEmpty ? nil : String(self.first!)
    }
}
