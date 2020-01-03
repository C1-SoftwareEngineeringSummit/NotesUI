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
        "Pay the electricity bill",
        "Get my car washed",
        "Made assignment"
        ].map { Note(content: $0, title: $0) }
}


