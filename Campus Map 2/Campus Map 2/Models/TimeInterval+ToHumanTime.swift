//
//  TimeInterval+ToHumanTime.swift
//  Campus Map 2
//
//  Created by Bert Yan on 2/28/22.
//

import Foundation

extension TimeInterval{
    //Added the function to convert the ETA
    func stringFromTimeInterval() -> NSString {

      let ti = NSInteger(self)

      let seconds = ti % 60
      let minutes = (ti / 60) % 60
      let hours = (ti / 3600)

      return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
}
