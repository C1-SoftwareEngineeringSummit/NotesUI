//
//  NoteView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/31/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject var noteStore: NoteStore
    var note: Note

    var noteIndex: Int {
        noteStore.notes.firstIndex(where: { $0.id == note.id }) ?? 0
    }

    var body: some View {
        VStack {
            TextField("Enter a title here", text: $noteStore.notes[noteIndex].title)
                .font(.title)
            TextView(text: $noteStore.notes[noteIndex].content)
        }
        .padding()
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        let noteStore = NoteStore()
        return NoteView(note: noteStore.notes[0]).environmentObject(noteStore)
    }
}
