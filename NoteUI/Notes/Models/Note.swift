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
    var title: String = ""
    // Content isn't added until the bonus work
    var content: String = "add more detail here"
}
