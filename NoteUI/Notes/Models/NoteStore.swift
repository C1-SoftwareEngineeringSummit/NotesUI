//
//  NoteStore.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/23/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import Combine

class NoteStore: ObservableObject {
    @Published var notes = [
        Note(title: "butter"),
        Note(title: "milk"),
        Note(title: "eggs")
    ]
}
