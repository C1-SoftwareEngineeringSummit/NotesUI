//
//  NoteRow.swift
//  Notes
//
//  Created by Longe, Chris on 1/5/20.
//  Copyright © 2020 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct NoteRow: View {
    @ObservedObject var noteStore: NoteStore
    let note: Note

    private var index: Int? {
        return noteStore.notes.firstIndex(where: { noteInStore in
            return noteInStore.id == note.id
        })
    }

    var body: some View {
        // This is the only way i could keep the app from crashing (due to index out of bounds exceptions) when deleting notes
        if let i = index {
            return AnyView(TextField("take a note", text: $noteStore.notes[i].title))
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        let noteStore = NoteStore()
        return Group {
            NoteRow(noteStore: noteStore, note: noteStore.notes[0])
                .previewLayout(.fixed(width: 300, height: 70))
            NoteRow(noteStore: noteStore, note: noteStore.notes[1])
                .previewLayout(.fixed(width: 414, height: 70))
        }
    }
}
