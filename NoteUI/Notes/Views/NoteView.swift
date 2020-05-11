//
//  NoteView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/31/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

// This whole view will be part of the bonus work
struct NoteView: View {
    @Binding var notes: [Note]
    let note: Note

    private var index: Int {
        return notes.firstIndex(where: { noteInStore in
            return noteInStore.id == note.id
        }) ?? 0
    }

    var body: some View {
        return TextView(text: $notes[index].content)
            .padding()
            .navigationBarTitle(notes[index].title)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        let notes = [
            Note(title: "butter"),
            Note(title: "milk"),
            Note(title: "eggs")
        ]
        // We use .constant() to create a binding with an immutable value
        // that is used to insert data for the preview
        return NoteView(notes: .constant(notes), note: notes[0])
    }
}
