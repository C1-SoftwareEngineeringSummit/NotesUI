//
//  NoteRow.swift
//  Notes
//
//  Created by Longe, Chris on 1/5/20.
//  Copyright © 2020 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct NoteRow: View {
    @Binding var notes: [Note]
    var index: Int

    var body: some View {
        TextField("Add note title...", text: $notes[index].title)
    }
}

struct NoteRow_Previews: PreviewProvider {
    static let notes = [Note(title: "Note title...", content: "Note content...")]
    static var previews: some View {
        NoteRow(notes: .constant(notes), index: 0).previewLayout(.fixed(width: 300, height: 70))
    }
}
