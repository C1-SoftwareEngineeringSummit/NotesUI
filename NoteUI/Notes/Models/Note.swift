//
//  Notes.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/23/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import Foundation

struct Note: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    let dateCreated = Date()
}
