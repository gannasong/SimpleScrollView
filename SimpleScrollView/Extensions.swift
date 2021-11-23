//
//  Extensions.swift
//  SimpleScrollView
//
//  Created by SUNG HAO LIN on 2021/11/23.
//

import Foundation
import SwiftDate

extension Date {
    private static var offset: TimeInterval = 0

    static var now: Date {
        let time = Date().timeIntervalSince1970 + Date.offset
        return Date(timeIntervalSince1970: time)
    }

    public var hourString: String {
        String(hour).leftPadding(toLength: 2, withPad: "0")
    }

    public var minuteString: String {
        String(minute).leftPadding(toLength: 2, withPad: "0")
    }

    public var secondString: String {
        String(second).leftPadding(toLength: 2, withPad: "0")
    }
}

extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(suffix(toLength))
        }
    }
}
