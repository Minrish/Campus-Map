//
//  String+FirstLetter.swift
//  Campus Map 2
//
//  Created by Bert Yan on 2/28/22.
//

import Foundation

extension String {
    var firstLetter : String? {
        return self.isEmpty ? nil : String(self.first!)
    }
}
