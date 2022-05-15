//
//  View+dismissKeyboard.swift
//  Campus Map 2
//
//  Created by Bert Yan on 2/28/22.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
