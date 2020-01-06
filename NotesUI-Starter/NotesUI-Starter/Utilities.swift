//
//  Utilities.swift
//  Notes
//
//  Created by Longe, Chris on 1/5/20.
//  Copyright © 2020 Arshad, Fatima. All rights reserved.
//

import Foundation

let mediumDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US")
    return formatter
}()

let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US")
    return formatter
}()
